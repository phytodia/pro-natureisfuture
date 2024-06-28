class BlogPostsController < ApplicationController
  def index
    @posts = BlogPost.all
  end

  def new
    @post = BlogPost.new
  end

  def create
    @post = BlogPost.new(blog_post_params)
    @post.save
    redirect_to blog_post_path(@post)
  end

  def show
    @post = BlogPost.find(params[:id])
  end

  def edit
    @post = BlogPost.find(params[:id])
  end

  def update
    @post = BlogPost.find(params[:id])
    @post.update(blog_post_params)
    @post.save
    redirect_to blog_post_path(@post)
  end

  def destroy
  end

  private
  def blog_post_params
    params.require(:blog_post).permit(:titre,:content,:photo)
  end
end
