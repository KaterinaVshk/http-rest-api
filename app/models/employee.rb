class Employee < ApplicationRecord
    belongs_to :company, foreign_key: "companyId"
    validates :name, presence: true
    validates :id, uniqueness: true
end
