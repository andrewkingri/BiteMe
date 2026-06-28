//
//  RecipeMenu.swift
//  BiteMe
//
//  Created by Andrew King on 6/27/26.
//

import Foundation

struct RecipeMenu: Identifiable, Hashable {
    let id: UUID
    var name: String
    var recipes: [Recipe]

    init(id: UUID = UUID(), name: String, recipes: [Recipe] = []) {
        self.id = id
        self.name = name
        self.recipes = recipes
    }
}
