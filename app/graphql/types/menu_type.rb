# frozen_string_literal: true

module Types
  class MenuType < Types::BaseObject
    field :id, ID, null: false
    field :identifier, String
    field :label, String
    field :state, String
    field :start_date, GraphQL::Types::ISO8601Date
    field :end_date, GraphQL::Types::ISO8601Date
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false


    def getAllMenus
      Menu.all
    end

    def getMenuById(id:)
      Menu.find(id)
    end

    def getSections(menu_id:)
      Menu.find(menu_id).sections
    end

    def getSection(menu_id:, section_id:)
      Menu.find(menu_id).sections.find(section_id)
    end

    def getItems(menu_id:, section_id:)
      Menu.find(menu_id).sections.find(section_id).items
    end

    def getItem(menu_id:, section_id:, item_id:)
      Menu.find(menu_id).sections.find(section_id).items.find(item_id)
    end
  end
end
