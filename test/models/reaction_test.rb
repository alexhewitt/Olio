require "test_helper"

class ReactionTest < ActiveSupport::TestCase
  include ActiveJob::TestHelper

  context "columns" do
    should have_db_column(:likes).of_type(:integer)
    should have_db_column(:by_user).of_type(:boolean)
    should have_db_column(:views).of_type(:integer)
    should have_db_column(:impressions).of_type(:integer)
    should have_db_column(:article_id).of_type(:integer)
    should have_db_column(:created_at).of_type(:datetime).with_options(null: false)
    should have_db_column(:updated_at).of_type(:datetime).with_options(null: false)
  end

  context 'associations' do
    should belong_to(:article)
  end
end
