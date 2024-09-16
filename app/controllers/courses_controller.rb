class CoursesController < ApplicationController
  #before_action :authenticate_customer!, except:[:new,:create,:show,:edit,:update,:destroy]
  def index

  end
  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    @course.save
  end

  def show
    @cours = Course.find(params[:id])
  end

  def edit
    @course = Course.find(params[:id])
  end

  def update
    @course = Course.find(params[:id])
    @course.update(course_params)
    @course.save
    redirect_to preview_path(@course)
  end

  def destroy
  end

  def preview
    @course = Course.find(params[:id])
  end
  private
  def course_params
    params.require(:course).permit(:titre,:introduction)
  end
end
