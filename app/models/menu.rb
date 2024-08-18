class Menu < ApplicationRecord
  has_many :menu_sections, dependent: :destroy
  has_many :sections, through: :menu_sections
end
