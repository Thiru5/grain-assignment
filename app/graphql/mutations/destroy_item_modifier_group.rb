class Mutations::DestroyItemModifierGroup < Mutations::BaseMutation
  argument :id, ID, required: true

  field :item_modifier_group, Types::ItemModifierGroupType, null: false
  field :errors, [ String ], null: false

  def resolve(id:)
    item_modifier_group = ItemModifierGroup.find(id)
    if item_modifier_group.destroy
      {
        item_modifier_group: item_modifier_group,
        errors: []
      }
    else
      {
        item_modifier_group: nil,
        errors: item_modifier_group.errors.full_messages
      }
    end
  end
end
