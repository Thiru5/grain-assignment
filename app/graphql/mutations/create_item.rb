class Mutations::CreateItem < Mutations::BaseMutation
  argument :item_type, String, required: true
  argument :identifier, String, required: false
  argument :label, String, required: true
  argument :description, String, required: true
  argument :price, Float, required: true

  field :item, Types::ItemType, null: false
  field :errors, [ String ], null: false

  def resolve(identifier:, item_type:, label:, description:, price:)
    item = Item.new(item_type: item_type, identifier: identifier, label: label, description: description, price: price)
    if item.save
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
