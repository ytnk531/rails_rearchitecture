require "test_helper"

class PessimisticOfflineLocksControllerTest < ActionDispatch::IntegrationTest

  test "updates record" do
    get edit_pessimistic_offline_lock_url(Post.first.id)
    patch(pessimistic_offline_lock_url(Post.first.id), params: { post: { title: "new_title"}})

    assert_response :success
    assert_equal("new_title", Post.first.title)
  end

  test "lock edit" do
    get edit_pessimistic_offline_lock_url(Post.first.id)
    reset!
    assert_raises(LockManager::LockManagerError) do
      get edit_pessimistic_offline_lock_url(Post.first.id)
    end
  end

  test "lock update" do
    get edit_pessimistic_offline_lock_url(Post.first.id)
    reset!
    assert_raises(LockManager::LockManagerError) do
      patch(pessimistic_offline_lock_url(Post.first.id), params: { post: { title: "new_title"}})
    end
  end

  test "release lock after edit" do
    get edit_pessimistic_offline_lock_url(Post.first.id)
    patch(pessimistic_offline_lock_url(Post.first.id), params: { post: { title: "new_title"}})
    reset!
    get edit_pessimistic_offline_lock_url(Post.first.id)
    assert_response :success
  end
end
