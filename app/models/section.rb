class Section < ApplicationRecord
  has_many :section_items, dependent: :destroy
  has_many :items, through: :section_items
end
