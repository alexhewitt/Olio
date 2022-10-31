require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  # setup do
  #   @article = articles(:one)
  # end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  # test "should get new" do
  #   get new_article_url
  #   assert_response :success
  # end

  # test "should create article" do
  #   assert_difference('Article.count') do
  #     post articles_url, params: { article: { collection_notes: @article.collection_notes, description: @article.description, images: @article.images, is_owner: @article.is_owner, location: @article.location, reactions: @article.reactions, section: @article.section, status: @article.status, title: @article.title, value: @article.value } }
  #   end

  #   assert_redirected_to article_url(Article.last)
  # end

  # test "should update article" do
  #   patch article_url(@article), params: { article: { collection_notes: @article.collection_notes, description: @article.description, images: @article.image, is_owner: @article.is_owner, reactions: @article.reactions, section: @article.section, status: @article.status, title: @article.title } }
  #   assert_redirected_to article_url(@article)
  # end

  # test "should destroy article" do
  #   assert_difference('Article.count', -1) do
  #     delete article_url(@article)
  #   end

  #   assert_redirected_to articles_url
  # end
end
