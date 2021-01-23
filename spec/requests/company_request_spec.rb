require 'rails_helper'

RSpec.describe 'Companies', type: :request do
  # initialize test data
  let!(:company) { FactoryBot.create(:company) }
  let(:company_id) { company.id }

  describe 'GET /company/:id' do
    before { get "/company/#{company_id}" }

        context 'when the record exists' do
        it 'returns status code 200' do
            expect(response.body).to match(/200/)
            expect(response.body).to match(/Successful operation/)
        end
        end

        context 'when the record does not exist' do
            let(:company_id) { 1000 }
            it 'returns status code 404' do
            expect(response.body).to match(/404/)
            expect(response.body).to match(/Company not found/)
            end
        end


        context 'when the id is invalid' do
            let(:company_id) { 'aeb' }
                it 'returns status code 400' do
                    expect(response.body).to match(/400/)
                    expect(response.body).to match(/Invalid ID supplied/)
                end
            end
    end

    describe 'POST /company' do
        let(:company_id) {  rand(1..100) }
        let(:name) { 'Company' }
        context 'when the parammetrs is valid' do
            before { post '/company', params: { company: { id: company_id, name: name, legalForm: company.legalForm } }}
      
            it 'creates a company' do
              expect(response.body).to match(/Company/)
            end
      
            it 'returns status code 200' do
                expect(response.body).to match(/200/)
                expect(response.body).to match(/Successful operation/)
            end
          end

        context 'when the parammetrs is invalid' do
            before { post '/company', params: { company: { id: 'fdav'} }}
      
            it 'returns status code 405' do
                expect(response.body).to match(/405/)
                expect(response.body).to match(/Invalid Input/)
            end
        
              it 'returns a validation failure message' do
                expect(response.body)
                  .to match(/is not a number/)
              end
        end
    end

    describe 'POST /company/:id' do
        context 'when the parammetrs is valid' do
            before { post "/company/#{company_id}", params: { company: { name: 'New'} }}
      
            it 'creates a company' do
              expect(response.body).to match(/New/)
            end
          end

        context 'when the parammetrs is invalid' do
            before { post "/company/#{company_id}", params: { company: { legalForm: 'New'} }}
      
            it 'returns status code 405' do
                expect(response.body).to match(/405/)
                expect(response.body).to match(/Validation exception/)
            end
        
              it 'returns a validation failure message' do
                expect(response.body)
                  .to match(/is not included in the list/)
              end
        end
    end

    describe 'DELETE /company/:id' do
        context 'when the parammetrs is valid' do
            before { delete "/company/#{company_id}" }
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when the parammetrs is valid' do
            let(:company_id) {'sdv'}
            before { delete "/company/#{company_id}" }
            it 'returns status code 400' do
                expect(response.body).to match(/400/)
                expect(response.body).to match(/Invalid ID supplied/)
            end
        end
        context 'when the record does not exist' do
            let(:company_id) { 1000 }
            before { delete "/company/#{company_id}" }
            it 'returns status code 404' do
                expect(response.body).to match(/404/)
                expect(response.body).to match(/Company not found/)
            end
        end
    end 

    describe 'GET /company/:id/employees' do
        context 'when the parammetrs is valid' do
            let(:company_id) {'sdv'}
            before { get "/company/#{company_id}/employees" }
            it 'returns status code 400' do
                expect(response.body).to match(/400/)
                expect(response.body).to match(/Invalid ID supplied/)
            end
        end
        context 'when the record does not exist' do
            let(:company_id) { 1000 }
            before { get "/company/#{company_id}" }
            it 'returns status code 404' do
                expect(response.body).to match(/404/)
                expect(response.body).to match(/Company not found/)
            end
        end
    end 
end