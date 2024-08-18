class Mutations::CreateModifier < Mutations::BaseMutation
  argument :item_id, ID, required: true
  argument :modifier_group_id, ID, required: true
  argument :display_order, Integer, required: true
  argument :default_quantity, Integer, required: true
  argument :price_override, Float, required: true


  field :modifier, Types::ModifierType, null: false
  field :errors, [ String ], null: false

  def resolve(item_id:, modifier_group_id:, display_order:, default_quantity:, price_override:)
    modifier = Modifier.new(item_id: item_id, modifier_group_id: modifier_group_id, display_order: display_order, default_quantity: default_quantity, price_override: price_override)
    if modifier.save
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
