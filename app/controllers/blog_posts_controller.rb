class BlogPostsController < ApplicationController
  add_breadcrumb "Home", :root_path
  def index
    add_breadcrumb "<strong>Blog</strong>".upcase.html_safe, blog_posts_path
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
    add_breadcrumb "Blog".upcase.html_safe, blog_posts_path
    add_breadcrumb "<strong>#{@post.titre.upcase}</strong>".html_safe

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
    params.require(:blog_post).permit(:titre,:content,:chapo,:img_description,:photo)
  end
end
