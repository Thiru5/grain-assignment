# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# menu_variety = [ 'Indian', 'Chinese', 'Italian' ]
# section_variety = [ 'Appetizers', 'Main Course', 'Add-Ons' ]
# indian_appetizer = [ 'Samosa', 'Pakora', 'Papdi Chaat', 'Dahi Puri', 'Aloo Tikki' ]
# chinese_appetizer = [ 'Spring Rolls', 'Dimsums', 'Manchurian', 'Noodles', 'Fried Rice' ]
# italian_appetizer = [ 'Bruschetta', 'Garlic Bread', 'Soup', 'Salad', 'Pesto' ]
# indian_main = [ 'Biryani', 'Butter Chicken', 'Paneer Tikka', 'Masala Dosa', 'Chole Bhature' ]
# chinese_main = [ 'Fried Rice', 'Manchurian', 'Noodles', 'Dimsums', 'Spring Rolls' ]
# italian_main = [ 'Pasta', 'Pizza', 'Lasagna', 'Risotto', 'Tiramisu' ]
# indian_addons = [ 'Raita', 'Papad', 'Salad', 'Pickles', 'Chutney' ]
# chinese_addons = [ 'Chilli Sauce', 'Soy Sauce', 'Vinegar', 'Kimchi', 'Chowmein' ]
# italian_addons = [ 'Garlic Bread', 'Soup', 'Salad', 'Bruschetta', 'Pesto' ]
# indian_dishes_array = [ indian_appetizer, indian_main, indian_addons ]
# chinese_dishes_array = [ chinese_appetizer, chinese_main, chinese_addons ]
# italian_dishes_array = [ italian_appetizer, italian_main, italian_addons ]
# dishes_array = [ indian_dishes_array, chinese_dishes_array, italian_dishes_array ]


puts("Seeding database...")

# menu_variety.each do |menu, menu_index|
#   puts("Creating menu: #{menu}")
#   created_menu = Menu.create(
#     identifier: Faker::Alphanumeric.alpha(number: 10),
#     label: menu,
#     state: "active",
#     start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
#     end_date: Faker::Date.between(from: Date.today, to: 2.days.from_now)
#   )

#   section_variety.each do |section, section_index|
#     puts("Creating section: #{section}")
#     created_section = Section.create(
#       identifier: Faker::Alphanumeric.alpha(number: 10),
#       label: section,
#       description: `Section for #{section}`
#     )
#     MenuSection.create(
#       menu_id: created_menu.id,
#       section_id: created_section.id,
#       display_order: Faker::Number.number(digits: 2),
#     )
#      dishes_array[menu_index][section_index].each do |dish|
#       puts("Creating item: #{dish}")
#       created_section_item = SectionItem.create(
#         section_id: created_section.id,
#         display_order: Faker::Number.number(digits: 2)
#       )
#       section_index == 2 ? (
#         item = Item.create(
#         section_item_id: created_section_item.id,
#         identifier: Faker::Alphanumeric.alpha(number: 10),
#         item_type: "Product",
#         label: dish,
#         description: `Description for #{dish}`,
#         price: Faker::Number.decimal(l_digits: 2)
#       )

#       Modifier.create(
#         item_id: component.id,
#         modifier_group_id: modifier_group.id,
#         display_order: Faker::Number.number(digits: 2),
#         default_quantity: Faker::Number.number(digits: 1),
#         price_override: Faker::Number.decimal(l_digits: 2)
#       )
#       ) : (
#         puts("Creating component: #{dish}")
#         component = Item.create(
#           section_item_id: created_section_item.id,
#           identifier: Faker::Alphanumeric.alpha(number: 10),
#           item_type: "Component",
#           label: dish,
#           description: `Description for #{dish}`,
#           price: Faker::Number.decimal(l_digits: 2)
#         )
#         modifier_group_1 = ModifierGroup.create(
#             identifier: Faker::Alphanumeric.alpha(number: 10),
#             label: 'Modifier Group for ' + dish,
#             selection_required_min: 1,
#             selection_required_max: 3
#         )
#         modifier_group_2 = ModifierGroup.create(
#             identifier: Faker::Alphanumeric.alpha(number: 10),
#             label: 'Modifier Group for ' + dish,
#             selection_required_min: 1,
#             selection_required_max: 3
#         )
#         modifier_groups = [ modifier_group_1, modifier_group_2 ]

#         modifier_groups.each do |modifier_group|
#           puts("Creating modifier group: #{modifier_group.label}")
#           ItemModifierGroup.create(
#             item_id: component.id,
#             modifier_group_id: modifier_group.id
#           )
#         end
#       )
#     end
#   end
# end
#


puts("Creating menu: Indian")
created_menu = Menu.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  label: "Indian",
  state: "active",
  start_date: Faker::Date.between(from: 2.days.ago, to: Date.today),
  end_date: Faker::Date.between(from: Date.today, to: 2.days.from_now)
)

puts("Creating section: Appetizers")
created_section = Section.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  label: "Appetizers",
  description: "Section for Appetizers"
)

MenuSection.create(
  menu_id: created_menu.id,
  section_id: created_section.id,
  display_order: Faker::Number.number(digits: 2),
)

puts("Creating item: Samosa")
created_section_item = SectionItem.create(
  section_id: created_section.id,
  display_order: Faker::Number.number(digits: 2)
)

product = Item.create(
  identifier: Faker::Alphanumeric.alpha(number: 10),
  item_type: "Product",
  label: "Samosa",
  description: "Description for Samosa",
  price: Faker::Number.decimal(l_digits: 2)
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



puts("Database seeded!")


# item = Item.create(
#         identifier: Faker::Alphanumeric.alpha(number: 10),
#         type: "Product",
#         label: Faker::Food.dish,
#         description: Faker::Food.description,
#         price: Faker::Number.decimal(l_digits: 2)
#     )
