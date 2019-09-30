# == Schema Information
#
# Table name: nodes
#
#  id             :integer          not null, primary key
#  name           :string
#  token          :string
#  parent_id      :integer
#  lft            :integer          not null
#  rgt            :integer          not null
#  depth          :integer          default("0"), not null
#  children_count :integer          default("0"), not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Node < ApplicationRecord

  has_secure_token

  validates :name, presence: true

end
