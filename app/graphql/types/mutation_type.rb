# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_menu, mutation: Mutations::CreateMenu
    field :update_menu, mutation: Mutations::UpdateMenu
    field :destroy_menu, mutation: Mutations::DestroyMenu

    field :create_section, mutation: Mutations::CreateSection
    field :update_section, mutation: Mutations::UpdateSection
    field :destroy_section, mutation: Mutations::DestroySection

    field :create_item, mutation: Mutations::CreateItem
    field :update_item, mutation: Mutations::UpdateItem
    field :destroy_item, mutation: Mutations::DestroyItem

    field :create_menu_section, mutation: Mutations::CreateMenuSection
    field :update_menu_section, mutation: Mutations::UpdateMenuSection
    field :destroy_menu_section, mutation: Mutations::DestroyMenuSection

    field :create_section_item, mutation: Mutations::CreateSectionItem
    field :update_section_item, mutation: Mutations::UpdateSectionItem
    field :destroy_section_item, mutation: Mutations::DestroySectionItem

    field :create_modifier, mutation: Mutations::CreateModifier
    field :update_modifier, mutation: Mutations::UpdateModifier
    field :destroy_modifier, mutation: Mutations::DestroyModifier

    field :create_item_modifier_group, mutation: Mutations::CreateItemModifierGroup
    field :update_item_modifier_group, mutation: Mutations::UpdateItemModifierGroup
    field :destroy_item_modifier_group, mutation: Mutations::DestroyItemModifierGroup

    field :create_modifier_group, mutation: Mutations::CreateModifierGroup
    field :update_modifier_group, mutation: Mutations::UpdateModifierGroup
    field :destroy_modifier_group, mutation: Mutations::DestroyModifierGroup
  end
end
