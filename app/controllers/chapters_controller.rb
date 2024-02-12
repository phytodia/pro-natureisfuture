class ChaptersController < ApplicationController
  def new
    @chapter = Chapter.new
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.content = chapter_params[:content]
    fail
    @chapter.save
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def chapter_params
    params.require(:chapter).permit(:titre,:course_id,:content)
  end
end
