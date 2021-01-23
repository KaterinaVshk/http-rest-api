require 'rails_helper'

RSpec.describe 'Employees', type: :request do
  # initialize test data
  let!(:company) { FactoryBot.create(:company) }
  let!(:employee) { FactoryBot.create(:employee)}
  let(:employee_id) { employee.id }

  describe 'GET /employee/:id' do
    before { get "/employee/#{employee_id}" }

        context 'when the record exists' do
        it 'returns status code 200' do
            expect(response.body).to match(/200/)
            expect(response.body).to match(/Successful operation/)
        end
        end

        context 'when the record does not exist' do
            let(:employee_id) { 1999 }
            it 'returns status code 404' do
            expect(response.body).to match(/404/)
            expect(response.body).to match(/Employee not found/)
            end
        end


        context 'when the id is invalid' do
            let(:employee_id) { 'aeb' }
                it 'returns status code 400' do
                    expect(response.body).to match(/400/)
                    expect(response.body).to match(/Invalid ID supplied/)
                end
            end
    end

    describe 'POST /employee' do
        let(:employee_id) { 101 }
        let!(:company) { FactoryBot.create(:company) }
        let(:name) { 'new_name' }
        context 'when the parammetrs is valid' do
            before { post '/employee', params: { employee: { id: employee_id, name: name, companyId: company.id}}}
      
            it 'creates a employee' do
              expect(response.body).to match(/new_name/)
            end
      
            it 'returns status code 200' do
                expect(response.body).to match(/200/)
                expect(response.body).to match(/Successful operation/)
            end
        end
    end

    describe 'POST /employee/:id' do
        context 'when the parammetrs is valid' do
            before { post "/employee/#{employee_id}", params: { employee: { name: 'New'} }}
      
            it 'creates a employee' do
              expect(response.body).to match(/New/)
            end
          end

        context 'when the parammetrs is invalid' do
            let(:employee_id) { 'aeb' }
            before { post "/employee/#{employee_id}", params: { employee: { surname: 'New'} }}
      
            it 'returns status code 400' do
                expect(response.body).to match(/400/)
                    expect(response.body).to match(/Invalid ID supplied/)
            end
        end
    end

    describe 'DELETE /employee/:id' do
        context 'when the parammetrs is valid' do
            before { delete "/employee/#{employee_id}" }
            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end

        context 'when the parammetrs is valid' do
            let(:employee_id) {'sdv'}
            before { delete "/employee/#{employee_id}" }
            it 'returns status code 400' do
                expect(response.body).to match(/400/)
                expect(response.body).to match(/Invalid ID supplied/)
            end
        end
        context 'when the record does not exist' do
            let(:employee_id) { 1000 }
            before { delete "/employee/#{employee_id}" }
            it 'returns status code 404' do
                expect(response.body).to match(/404/)
                expect(response.body).to match(/Employee not found/)
            end
        end
    end 

end