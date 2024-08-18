class Mutations::UpdateMenu < Mutations::BaseMutation
  argument :menu_id, ID, required: true
  argument :label, String, required: false
  argument :state, String, required: false
  argument :start_date, GraphQL::Types::ISO8601Date, required: false
  argument :end_date, GraphQL::Types::ISO8601Date, required: false

  field :menu, Types::MenuType, null: false
  field :errors, [ String ], null: false

  def resolve(menu_id:, label: nil, state: nil, start_date: nil, end_date: nil)
    menu = Menu.find(menu_id)
    if menu.update(label: label, state: state, start_date: start_date, end_date: end_date)
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
