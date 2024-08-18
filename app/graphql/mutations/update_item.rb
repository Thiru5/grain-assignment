class Mutations::UpdateItem < Mutations::BaseMutation
  argument :id, ID, required: true
  argument :item_type, String, required: true
  argument :description, String, required: true
  argument :price, Float, required: true
  argument :label, String, required: true
  argument :identifier, ID, required: true

  field :item, Types::ItemType, null: false
  field :errors, [ String ], null: false

  def resolve(id:, item_type:, description:, price:, label:, identifier:)
    item = Item.find(id)
    if item.update(item_type: item_type, description: description, price: price, label: label, identifier: identifier)
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
