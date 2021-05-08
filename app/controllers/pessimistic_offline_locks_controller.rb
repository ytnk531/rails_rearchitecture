require 'securerandom'

class PessimisticOfflineLocksController < ApplicationController
  def edit
    @post = Post.find(params[:id])
    pp session[:pessimistic_id]
    session[:pessimistic_id] = SecureRandom.uuid unless session[:pessimistic_id]
    LockManager.new.lock(@post, session[:pessimistic_id])
    pp session[:pessimistic_id]
  end

  def update
    @post = Post.find(params[:id])
    LockManager.new.lock(@post, session[:pessimistic_id])
    @post.update!(post_params)
    LockManager.new.release(@post, session[:pessimistic_id])
  end

  private

  def post_params
    params.require(:post).permit(:title)
  end
end
