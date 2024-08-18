class Mutations::CreateMenuSection < Mutations::BaseMutation
  argument :menu_id, ID, required: true
  argument :section_id, ID, required: true
  argument :display_order, Integer, required: true

  field :menu_section, Types::MenuSectionType, null: false
  field :errors, [ String ], null: false

  def resolve(menu_id:, section_id:, display_order:)
    menu_section = MenuSection.new(menu_id: menu_id, section_id: section_id, display_order: display_order)
    if menu_section.save
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
