class ModifierGroup < ApplicationRecord
  has_many :item_modifier_groups, dependent: :destroy
  has_one :items, through: :item_modifier_groups
  has_many :modifiers, dependent: :destroy
end
