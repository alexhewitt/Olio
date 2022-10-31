require "test_helper"

class AddressTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  context "columns" do
    should have_db_column(:town).of_type(:string)
    should have_db_column(:country).of_type(:string)
    should have_db_column(:locatable_id).of_type(:integer)
    should have_db_column(:locatable_type).of_type(:string)
    should have_db_column(:distance).of_type(:float)
    should have_db_column(:location).of_type(:geometry)
    should have_db_column(:created_at).of_type(:datetime).with_options(null: false)
    should have_db_column(:updated_at).of_type(:datetime).with_options(null: false)
  end

  context 'associations' do
    should belong_to(:locatable)
  end
end
