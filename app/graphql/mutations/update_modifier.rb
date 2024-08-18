class Mutations::UpdateModifier < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :display_order, Integer, required: true
  argument :price_override, Float, required: true
  argument :modifier_group_id, ID, required: true
  argument :item_id, ID, required: true

  field :modifier, Types::ModifierType, null: false
  field :errors, [ String ], null: false

  def resolve(id:, display_order:, price_override:, modifier_group_id:, item_id:)
    modifier = Modifier.find(id)
    if modifier.update(display_order: display_order, price_override: price_override, modifier_group_id: modifier_group_id, item_id: item_id)
      {
        modifier: modifier,
        errors: []
      }
    else
      {
        modifier: nil,
        errors: modifier.errors.full_messages
      }
    end
  end
end
