require "test_helper"

class ReactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create!(id: 1)
    @reaction = Reaction.create!(article_id: @article.id)
  end

  test "should post like" do
    puts @article.inspect, "@article"
    puts @reaction.inspect, "@reaction"
    get like_path(@reaction.id)
    assert_response :success
  end
end
