class StudentsController < ApplicationController

  wrap_parameters format: []

  def index
    render json: Student.all, status: :ok
  end

  def show
    student = Student.find_by(id:params[:id])
    if student
      render json: student, status: :ok
    else 
      render json: {error: "Student not found"}, status: :not_found
    end
  end

  def create
    student = Student.new(student_params)
    if student.save
      render json: student, status: :created
    else 
      render json: { errors: student.errors.full_messages }, status: :unprocessable_entity
    end    
  end

  def update
    student = Student.find_by(id:params[:id])
    if student
      student.update(student_params)
      render json: student, status: :accepted
    else
      render json: {error: "Student not found"}, status: :not_found
    end
  end

  def destroy
    student = Student.find_by(id:params[:id])
    if student
      student.destroy
      head :no_content
    else
      render json: {error: "Student not found"}, status: :not_found
    end
  end

  private
  
  def student_params
    params.permit(:name, :age, :major, :instructor_id)
  end

end
