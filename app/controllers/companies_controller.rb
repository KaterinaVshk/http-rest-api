class CompaniesController < ApplicationController
  before_action :set_company, only: [:show, :update, :destroy, :get_list_employees]

  # GET /company/1
  def show
    render json:{ company: @company,  code: 200, descriprion: 'Successful operation'} 
  end

  # POST /company
  def create
    @company = Company.new(company_params)

    if @company.save
      render json: { company: @company,  code: 200, descriprion: 'Successful operation'} 
    else
      render  json: { errors: @company.errors,  code: 405, descriprion: 'Invalid Input'}
    end
  end

  # POST/PUT /company/1
  def update
    if @company.update(company_params)
      render json: @company
    else
      render  json: { company: @company.errors,  code: 405, descriprion: 'Validation exception'}
    end
  end

  # DELETE /company/1
  def destroy
    @company.destroy
  end

  # GET /company/:id/employees
  def get_list_employees
    @employees = Employee.all.where(companyId: params[:id] )
    render json:@employees
  end 

  private
    # Checks the validity of the id
    def set_company
      if  /^0*[1-9]\d*$/.match(params[:id])
        find_company
      else
        render  json: { description: "Invalid ID supplied", code: 400 }
      end
    end
 
    # Finds the company we need
    def find_company
      @company = Company.exists?(params[:id])
      if @company
        @company = Company.find(params[:id])
      else
        render  json: { description: "Company not found", code: 404  }
      end
    end

    # Only allow a trusted parameter "white list" through.
    def company_params
      params.require(:company).permit(:id, :name, :legalForm)
    end
end
