class Nodes::FileStoresController < ApplicationController

  def new
    @file_store = FileStore.new
    respond_to do |format|
      format.js
    end
  end

  def create
    @node = Node.new(data_params)

    respond_to do |format|
      if @node.save
        # format.html { redirect_to admin_company_path(@company.slug), notice: 'Company was successfully created.' }
        format.js
      else
        # format.html { render :new }
        format.json { render json: @node.errors, status: :unprocessable_entity }
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

    # before_action :set_node, only: [:destroy]


    # def set_node
    #   @node = Node.find_by(token: url_params[:token])
    # end


    def data_params
      params.require(:node).permit(
        :name
      )
    end

    # def url_params
    #   params.permit(
    #     :token
    #   )
    # end
  
end
