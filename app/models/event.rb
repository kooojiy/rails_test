class Event < ApplicationRecord
    validates :name, {presence: true, uniqueness: true}
    validates :owner, {presence: true}
    validates :date, {presence: true}
    validates :site, {presence: true}
    validates :link, {inclusion: {in: [true, false]}}
end
