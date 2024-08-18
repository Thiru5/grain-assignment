class Mutations::UpdateSection < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :label, String, required: true
  argument :description, String, required: true
  argument :identifier, Integer, required: false

  field :section, Types::SectionType, null: false
  field :errors, [ String ], null: false

  def resolve(id:, label:, description:, identifier:)
    section = Section.find(id)
    if section.update(label: label, description: description, identifier: identifier)
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
