class Company < ApplicationRecord
has_many :employee ,foreign_key: "companyId"
validates :legalForm, inclusion: { in: %w(OOO ZAO IP)} ,allow_blank: true
validates :id, numericality: { only_integer: true, greater_than: 0},
               uniqueness: true
end
