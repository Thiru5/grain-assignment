class Mutations::DestroyModifierGroup < Mutations::BaseMutation
  argument :modifier_group_id, ID, required: true

  field :modifier_group, Types::ModifierGroupType, null: false
  field :errors, [ String ], null: false

  def resolve(modifier_group_id:)
    modifier_group = ModifierGroup.find(modifier_group_id)
    modifier_group.modifiers.each do |modifier|
      modifier.destroy
    end
    if modifier_group.destroy
      {
        modifier_group: modifier_group,
        errors: []
      }
    else
      {
        modifier_group: nil,
        errors: modifier_group.errors.full_messages
      }
    end
  end
end
