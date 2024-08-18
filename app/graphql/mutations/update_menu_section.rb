class Mutations::UpdateMenuSection < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :menu_id, ID, required: true
  argument :section_id, ID, required: true
  argument :display_order, Integer, required: true

  field :menu_section, Types::MenuSectionType, null: false
  field :errors, [ String ], null: false

  def resolve(id:, menu_id:, section_id:, display_order:)
    menu_section = MenuSection.find(id)
    if menu_section.update(menu_id: menu_id, section_id: section_id, display_order: display_order)
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
