# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :all_menus, [ MenuType ], null: false

    def all_menus
      Menu.all
    end

    field :menu, MenuType, null: false do
      argument :id, ID, required: true
    end

    def menu(id:)
      Menu.find(id)
    end

    field :identifyMenu, MenuType, null: false do
      argument :identifier, ID, required: true
    end

    def identifyMenu(identifier:)
      Menu.find_by(identifier: identifier)
    end

    field :all_sections, [ SectionType ], null: false

    def all_sections
      Section.all
    end

    field :section, SectionType, null: false do
      argument :id, ID, required: true
    end

    def section(id:)
      Section.find(id)
    end

    field :identifySection, SectionType, null: false do
      argument :identifier, ID, required: true
    end

    def identifySection(identifier:)
      Section.find_by(identifier: identifier)
    end

    field :all_items, [ ItemType ], null: false

    def all_items
      Item.all
    end

    field :item, ItemType, null: false do
      argument :id, ID, required: true
    end

    def item(id:)
      Item.find(id)
    end

    field :identifyItem, ItemType, null: false do
      argument :identifier, ID, required: true
    end

    def identifyItem(identifier:)
      Item.find_by(identifier: identifier)
    end


    field :all_menu_sections, [ MenuSectionType ], null: false

    def all_menu_sections
      MenuSection.all
    end

    field :menu_section, MenuSectionType, null: false do
      argument :id, ID, required: true
    end

    def menu_section(id:)
      MenuSection.find(id)
    end

    field :all_section_items, [ SectionItemType ], null: false

    def all_section_items
      SectionItem.all
    end

    field :section_item, SectionItemType, null: false do
      argument :id, ID, required: true
    end

    def section_item(id:)
      SectionItem.find(id)
    end

    field :all_modifiers, [ ModifierType ], null: false

    def all_modifiers
      Modifier.all
    end

    field :modifier, ModifierType, null: false do
      argument :id, ID, required: true
    end

    def modifier(id:)
      Modifier.find(id)
    end

    field :all_item_modifier_groups, [ ItemModifierGroupType ], null: false

    def all_item_modifier_groups
      ItemModifierGroup.all
    end

    field :item_modifier_group, ItemModifierGroupType, null: false do
      argument :id, ID, required: true
    end

    def item_modifier_group(id:)
      ItemModifierGroup.find(id)
    end

    field :all_modifier_groups, [ ModifierGroupType ], null: false

    def all_modifier_groups
      ModifierGroup.all
    end

    field :modifier_group, ModifierGroupType, null: false do
      argument :id, ID, required: true
    end

    def modifier_group(id:)
      ModifierGroup.find(id)
    end

    field :identifyModifierGroup, ModifierGroupType, null: false do
      argument :identifier, ID, required: true
    end

    def identifyModifierGroup(identifier:)
      ModifierGroup.find_by(identifier: identifier)
    end


    field :all_products, [ ItemType ], null: false

    def all_products
      Item.find_by(item_type: "Product")
    end

    field :all_components, [ ItemType ], null: false

    def all_components
      Item.find_by(item_type: "Component")
    end


    field :active_menus, [ MenuType ], null: false

    def active_menus
      Menu.where(state: "active")
    end
  end
end
