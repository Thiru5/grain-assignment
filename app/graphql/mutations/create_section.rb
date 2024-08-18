class Mutations::CreateSection < Mutations::BaseMutation
  argument :label, String, required: true
  argument :description, String, required: true
  argument :identifier, Integer, required: false

  field :section, Types::SectionType, null: false
  field :errors, [ String ], null: false

  def resolve(label:, description:, identifier:)
    section = Section.new(label: label, description: description, identifier: identifier)
    if section.save
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
