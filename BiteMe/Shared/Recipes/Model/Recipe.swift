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
    var ingredients: String
    var imageURLs: [String]
}
