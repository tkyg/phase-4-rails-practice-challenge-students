class InstructorsController < ApplicationController

  wrap_parameters format: []

  def index
    render json: Instructor.all, status: :ok
  end

  def show
    instructor = Instructor.find_by(id:params[:id])
    if instructor
      render json: instructor, status: :ok
    else 
      render json: {error: "Instructor not found"}, status: :not_found
    end
  end

  def create
    instructor = Instructor.new(instructor_params)
    if instructor.save
      render json: instructor, status: :created
    else 
      render json: { errors: instructor.errors.full_messages }, status: :unprocessable_entity
    end    
  end

  def update
    instructor = Instructor.find_by(id:params[:id])
    if instructor
      instructor.update(instructor_params)
      render json: instructor, status: :accepted
    else
      render json: {error: "Instructor not found"}, status: :not_found
    end
  end

  def destroy
    instructor = Instructor.find_by(id:params[:id])
    if instructor
      instructor.destroy
      head :no_content
    else
      render json: {error: "Instructor not found"}, status: :not_found
    end
  end

  private
  
  def instructor_params
    params.permit(:name)
  end

end
