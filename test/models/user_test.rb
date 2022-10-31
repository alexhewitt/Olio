require "test_helper"

class UserTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  context "columns" do
    should have_db_column(:first_name).of_type(:string)
    should have_db_column(:roles).of_type(:text)
    should have_db_column(:rating).of_type(:json)
    should have_db_column(:verifications).of_type(:json)
    should have_db_column(:current_avatar).of_type(:string)
    should have_db_column(:created_at).of_type(:datetime).with_options(null: false)
    should have_db_column(:updated_at).of_type(:datetime).with_options(null: false)
  end

  context 'associations' do
    should have_many(:articles)
  end
end
