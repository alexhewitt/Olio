require "test_helper"

class ValueTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  context "columns" do
    should have_db_column(:price).of_type(:float)
    should have_db_column(:currency).of_type(:string)
    should have_db_column(:payment_type).of_type(:string)
    should have_db_column(:article_id).of_type(:integer)
    should have_db_column(:created_at).of_type(:datetime).with_options(null: false)
    should have_db_column(:updated_at).of_type(:datetime).with_options(null: false)
  end

  context 'associations' do
    should belong_to(:article)
  end
end
