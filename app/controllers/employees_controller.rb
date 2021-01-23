require 'pry'
class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :update, :destroy]

  # GET /employee/1
  def show
    render json:{ company: @employee,  code: 200, descriprion: 'Successful operation'} 
  end

  # POST /employee
  def create
    @employee = Employee.new(employee_params)

    if @employee.save
    render json: { employee: @employee , description: "Successful operation", code: 200  }
    else
      render  json: { employee: @employee.errors, description: "Invalid Input", code: 405  }
    end
  end

  # POST/PUT /employee/1
  def update
    if @employee.update(employee_params)
      render json: @employee
    else 
      render  json: { employee: @employee.errors, description: "Validation exception", code: 405  }
    end
  end

  # DELETE /employee/1
  def destroy
    @employee.destroy
  end

  private
     # Checks the validity of the id
    def set_employee
      if  /[[:digit:]]/.match(params[:id])
        find_employee
      else
        render  json: { description: "Invalid ID supplied", code: 400 }
      end
    end
 
     # Finds the employee we need
    def find_employee
      @employee = Employee.exists?(params[:id])
      if @employee
        @employee = Employee.find(params[:id])
      else
        render  json: { description: "Employee not found", code: 404  }
      end
    end

    # Only allow a trusted parameter "white list" through.
    def employee_params
      params.require(:employee).permit(:id, :name, :secondName, :surname, :hireDate, :position, :companyId)
    end
end
