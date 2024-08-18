class Mutations::DestroyMenuSection < Mutations::BaseMutation
  argument :menu_section_id, ID, required: true

  field :menu_section, Types::MenuSectionType, null: false
  field :errors, [ String ], null: false

  def resolve(menu_section_id:)
    menu_section = MenuSection.find(menu_section_id)
    if menu_section.destroy
      {
        menu_section: menu_section,
        errors: []
      }
    else
      {
        menu_section: nil,
        errors: menu_section.errors.full_messages
      }
    end
  end
end
