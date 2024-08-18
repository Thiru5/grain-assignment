# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts("Seeding database...")


puts("Creating menu: Indian")
created_menu = Menu.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  label: "Indian",
  state: "active",
  start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
  end_date: Faker::Date.between(from: Date.today, to: 2.days.from_now)
)

# #section 1
puts("Creating section: Appetizers")
created_section = Section.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  label: "Appetizers",
  description: "Section for Appetizers"
)

MenuSection.create(
  menu_id: created_menu.id,
  section_id: created_section.id,
  display_order: 1,
)


puts("Creating item: Samosa")


product = Item.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  item_type: "Product",
  label: "Samosa",
  description: "Description for Samosa",
  price: Faker::Number.decimal(l_digits: 2)
)

SectionItem.create(
  section_id: created_section.id,
  item_id: product.id,
  display_order: Faker::Number.number(digits: 2)
)


puts("Creating components for No. of Samosas")
component = Item.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  item_type: "Component",
  label: "3 Samosas",
  description: "Description for 3 Samosa",
  price: Faker::Number.decimal(l_digits: 2)
)

component_two = Item.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  item_type: "Component",
  label: "2 Samosas",
  description: "Description for 2 Samosa",
  price: Faker::Number.decimal(l_digits: 2)
)

components = [ component, component_two ]


modifier_group = ModifierGroup.create(
    identifier: Faker::Alphanumeric.alpha(number: 10),
    label: 'No. Of Pieces',
    selection_required_min: 1,
    selection_required_max: 3
)

ItemModifierGroup.create(
  item_id: product.id,
  modifier_group_id: modifier_group.id
)

components.each do |component|
  Modifier.create(
    item_id: component.id,
    modifier_group_id: modifier_group.id,
    display_order: Faker::Number.number(digits: 2),
    default_quantity: Faker::Number.number(digits: 1),
    price_override: Faker::Number.decimal(l_digits: 2)
  )
end

# #section 1 end
#
# section 2

puts("Creating section: Main Course")
created_section_main = Section.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  label: "Main Course",
  description: "Section for Main Course"
)

MenuSection.create(
  menu_id: created_menu.id,
  section_id: created_section_main.id,
  display_order: 2,
)

puts("Creating item: Biryani")
product_main = Item.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  item_type: "Product",
  label: "Biryani",
  description: "Description for Biryani",
  price: Faker::Number.decimal(l_digits: 2)
)

SectionItem.create(
  section_id: created_section_main.id,
  item_id: product_main.id,
  display_order: 1
)

puts("Creating Masala Thosai")
product_main_two = Item.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  item_type: "Product",
  label: "Masala Thosai",
  description: "Description for Masala Thosai",
)

SectionItem.create(
  section_id: created_section_main.id,
  item_id: product_main_two.id,
  display_order: 2
)


puts("Database seeded!")
