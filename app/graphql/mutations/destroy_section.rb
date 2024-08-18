class Mutations::DestroySection < Mutations::BaseMutation
  argument :section_id, ID, required: true

  field :section, Types::SectionType, null: false
  field :errors, [ String ], null: false

  def resolve(section_id:)
    section = Section.find(section_id)
    section.menu_sections.each do |menu_section|
      menu_section.destroy
    end
    if section.destroy
      {
        section: section,
        errors: []
      }
    else
      {
        section: nil,
        errors: section.errors.full_messages
      }
    end
  end
end
