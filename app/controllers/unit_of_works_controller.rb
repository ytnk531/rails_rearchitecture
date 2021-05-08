class UnitOfWorksController < ApplicationController
  def create
    u = UnitOfWork.new

    user = User.new(name: "new")
    u.register_new(user)
    post = Post.new(title: "new", user: user)
    u.register_new(post)

    u.commit
  end

  def update
    u = UnitOfWork.new

    user = User.first
    user.name = 'Changed name'
    u.register_dirty(user)
    
    post = Post.first
    post.title = 'Changed title'
    u.register_dirty(post)

    u.commit
  end

  def destroy
    u = UnitOfWork.new

    post = Post.first
    u.register_deleted(post)

    user = User.first
    u.register_deleted(user)

    u.commit
  end
end
