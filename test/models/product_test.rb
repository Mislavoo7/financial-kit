# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  company       :string
#  is_visible    :boolean          default(TRUE)
#  position      :integer          default(1000)
#  price_in_cent :integer          default(0)
#  product_name  :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  app_id        :integer
#  list_id       :integer
#
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
