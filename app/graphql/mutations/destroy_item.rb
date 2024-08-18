class Mutations::DestroyItem < Mutations::BaseMutation
  argument :item_id, ID, required: true

  field :item, Types::ItemType, null: false
  field :errors, [ String ], null: false

  def resolve(item_id:)
    item = Item.find(item_id)
    item.item_modifier_groups.each do |item_modifier_group|
      item_modifier_group.destroy
    end
    item.modifiers.each do |modifier|
      modifier.destroy
    end
    if item.destroy
      {
        item: item,
        errors: []
      }
    else
      {
        item: nil,
        errors: item.errors.full_messages
      }
    end
  end
end
