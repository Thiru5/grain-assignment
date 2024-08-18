class Mutations::CreateMenu < Mutations::BaseMutation
  argument :identifier, String, required: true
  argument :label, String, required: true
  argument :state, String, required: true
  argument :start_date, GraphQL::Types::ISO8601Date, required: true
  argument :end_date, GraphQL::Types::ISO8601Date, required: true

  field :menu, Types::MenuType, null: false
  field :errors, [ String ], null: false

  def resolve(identifier:, label:, state:, start_date:, end_date:)
    menu = Menu.new(identifier: identifier, label: label, state: state, start_date: start_date, end_date: end_date)
    if menu.save
      {
        menu: menu,
        errors: []
      }
    else
      {
        menu: nil,
        errors: menu.errors.full_messages
      }
    end
  end
end
