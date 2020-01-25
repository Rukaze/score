class EmployeesController < ApplicationController
  def index
   @employees = Employee.all
  end

 def show
   @employee = Employee.find(params[:id])
   render json: @employee
 end
end
