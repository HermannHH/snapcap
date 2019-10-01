class Nodes::FileStoresController < ApplicationController

  def new
    @file_store = FileStore.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @file_store = FileStore.new(data_params)
    @file_store.fileable = @node
    respond_to do |format|
      if @file_store.save
        # format.html { redirect_to admin_company_path(@company.slug), notice: 'Company was successfully created.' }
        format.js
      else
        # format.html { render :new }
        format.json { render json: @file_store.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  def destroy
    @node.destroy
    respond_to do |format|
      format.js
    end
  end

  private

    before_action :set_node, only: [:create]


    def set_node
      @node = Node.find_by(token: url_params[:node_token])
    end


    def data_params
      params.require(:file_store).permit(
        :attachment
      )
    end

    def url_params
      params.permit(
        :node_token
      )
    end
  
end
