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

    field :all_items, [ ItemType ], null: false

    def all_items
      Item.all
    end
  end
end
