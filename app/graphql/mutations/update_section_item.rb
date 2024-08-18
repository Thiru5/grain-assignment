class Mutations::UpdateSectionItem < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :section_id, ID, required: true
  argument :item_id, ID, required: true
  argument :display_order, Integer, required: true

  field :section_item, Types::SectionItemType, null: false
  field :errors, [ String ], null: false

  def resolve(id:, section_id:, item_id:, display_order:)
    section_item = SectionItem.find(id)
    if section_item.update(section_id: section_id, item_id: item_id, display_order: display_order)
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
