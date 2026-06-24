//
//  Recipe.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import Foundation

struct Recipe: Identifiable, Hashable {
    let id: String
    let name: String
    var dietTags: String
    var ingredients: [Ingredient]
    var instructions: String
    var imageURLs: [String]
}

struct Ingredient: Hashable {
    let name: String
    let measure: String
}
