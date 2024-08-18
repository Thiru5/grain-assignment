class Mutations::UpdateModifierGroup < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :identifier, String, required: true
  argument :label, Integer, required: true
  argument :selection_required_max, Integer, required: true
  argument :selection_required_min, Integer, required: true

  field :modifier_group, Types::ModifierGroupType, null: false
  field :errors, [ String ], null: false

  def resolve(id:, identifier:, label:, selection_required_max:, selection_required_min:)
    modifier_group = ModifierGroup.find(id)
    if modifier_group.update(identifier: identifier, label: label, selection_required_max: selection_required_max, selection_required_min: selection_required_min)
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
