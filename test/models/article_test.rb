require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  context "columns" do
    should have_db_column(:title).of_type(:string)
    should have_db_column(:description).of_type(:text)
    should have_db_column(:section).of_type(:string)
    should have_db_column(:status).of_type(:string)
    should have_db_column(:is_owner).of_type(:boolean)
    should have_db_column(:collection_notes).of_type(:string)
    should have_db_column(:image).of_type(:string)
    should have_db_column(:user_id).of_type(:integer)
    should have_db_column(:created_at).of_type(:datetime).with_options(null: false)
    should have_db_column(:updated_at).of_type(:datetime).with_options(null: false)
  end

  context 'associations' do
    should have_one(:value)
    should have_one(:reaction)
    should have_one(:address)
    should belong_to(:user)
  end
end
