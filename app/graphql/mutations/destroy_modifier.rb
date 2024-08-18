class Mutations::DestroyModifier < Mutations::BaseMutation
  argument :modifier_id, ID, required: true

  field :modifier, Types::ModifierType, null: false
  field :errors, [ String ], null: false

  def resolve(modifier_id:)
    modifier = Modifier.find(modifier_id)
    if modifier.destroy
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
