class Mutations::CreateModifierGroup < Mutations::BaseMutation
  argument :identifier, String, required: false
  argument :label, String, required: true
  argument :selection_required_min, Integer, required: true
  argument :selection_required_max, Integer, required: true

  field :modifier_group, Types::ModifierGroupType, null: false
  field :errors, [ String ], null: false

  def resolve(identifier:, label:, selection_required_min:, selection_required_max:)
    modifier_group = ModifierGroup.new(identifier: identifier, label: label, selection_required_min: selection_required_min, selection_required_max: selection_required_max)
    if modifier_group.save
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
