class Mutations::CreateSectionItem < Mutations::BaseMutation
  argument :section_id, ID, required: true
  argument :item_id, ID, required: true
  argument :display_order, Integer, required: true

  field :section_item, Types::SectionItemType, null: false
  field :errors, [ String ], null: false

  def resolve(section_id:, item_id:, display_order:)
    section_item = SectionItem.new(section_id: section_id, item_id: item_id, display_order: display_order)
    if section_item.save
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
