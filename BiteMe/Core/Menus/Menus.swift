//
//  Menus.swift
//  BiteMe
//
//  Created by Andrew King on 6/27/26.
//

import Foundation

@MainActor
class Menus: ObservableObject {
    @Published private(set) var menus: [RecipeMenu] = []

    @discardableResult
    func createMenu(name: String) -> RecipeMenu {
        let menu = RecipeMenu(name: name)
        menus.append(menu)
        return menu
    }

    func addRecipe(_ recipe: Recipe, to menuID: RecipeMenu.ID) {
        guard let index = menus.firstIndex(where: { $0.id == menuID }) else { return }
        guard !menus[index].recipes.contains(where: { $0.id == recipe.id }) else { return }
        menus[index].recipes.append(recipe)
    }

    func contains(_ recipe: Recipe, in menuID: RecipeMenu.ID) -> Bool {
        guard let menu = menus.first(where: { $0.id == menuID }) else { return false }
        return menu.recipes.contains(where: { $0.id == recipe.id })
    }
}
