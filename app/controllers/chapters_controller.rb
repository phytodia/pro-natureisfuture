class ChaptersController < ApplicationController
  def new
    @chapter = Chapter.new
    @courses = Course.all
  end

  def create
    @chapter = Chapter.new(chapter_params)
    @chapter.save
  end

  def edit
    @chapter = Chapter.find(params[:id])
  end

  def update
    @chapter = Chapter.find(params[:id])
    @chapter.update(chapter_params)
    @chapter.save
    redirect_to preview_path(@chapter.course)
  end

  def destroy
  end

  private
  def chapter_params
    params.require(:chapter).permit(:titre,:content,:course_id)
  end
end
