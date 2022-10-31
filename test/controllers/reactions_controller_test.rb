require "test_helper"

class ReactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(id: 1)
    @article = Article.create!(id: 1, user_id: @user.id)
    @reaction = Reaction.create!(article_id: @article.id, likes: 0)
  end

  test "should post like" do
    get like_path(id: @reaction.id)
    assert_redirected_to articles_path
  end
end
