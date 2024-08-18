class Mutations::DestroySectionItem < Mutations::BaseMutation
  argument :section_item_id, ID, required: true

  field :section_item, Types::SectionItemType, null: false
  field :errors, [ String ], null: false

  def resolve(section_item_id:)
    section_item = SectionItem.find(section_item_id)
    if section_item.destroy
      {
        section_item: section_item,
        errors: []
      }
    else
      {
        section_item: nil,
        errors: section_item.errors.full_messages
      }
    end
  end
end
