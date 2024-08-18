class Mutations::DestroyMenu < Mutations::BaseMutation
  argument :menu_id, ID, required: true

  field :menu, Types::MenuType, null: false
  field :errors, [ String ], null: false

  def resolve(menu_id:)
    menu = Menu.find(menu_id)
    if menu.destroy
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
