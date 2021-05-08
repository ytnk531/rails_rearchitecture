class UnitOfWorksControllerTest < ActionDispatch::IntegrationTest
  test "insert records" do
    post unit_of_works_url
    assert_response :success
    assert_equal("new", User.last.name)
    assert_equal("new", Post.last.title)
  end

  test "update records" do
    patch unit_of_work_url(1)
    assert_response :success
    assert_equal("Changed name", User.first.name)
    assert_equal("Changed title", Post.first.title)
  end

  test "destroy records" do
    user_count = User.count
    post_count = Post.count
    delete unit_of_work_url(1)
    assert_response :success
    assert_equal(user_count - 1, User.count)
    assert_equal(post_count - 1, Post.count)
  end
end