//
//  MockData.swift
//  BiteMe
//
//  Created by Andrew King on 10/11/25.
//

import Foundation

struct MockData {
    static let recipes: [Recipe] = [
        .init(
            id: NSUUID().uuidString,
            name: "Imani Salad",
            dietTags: "V,GF",
            ingredients: "Romaine, Kale, Parmesan",
            imageURLs: ["Salad", "salad1"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Raspberry Cheesecake",
            dietTags: "",
            ingredients: "Caramelized raspberries, cream cheese",
            imageURLs: ["cheesecake", "cheesecake2"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Smokehouse Burger",
            dietTags: "",
            ingredients: "Angus Beef, Bacon, BBQ",
            imageURLs: ["burger", "burger2", "burger3"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Old Fashioned Kabobs",
            dietTags: "",
            ingredients: "Steak, Peppers, Onion",
            imageURLs: ["kabobs", "kabobs2"]
        )
    ]
    
    static let users: [User] = [
        .init(
            id: NSUUID().uuidString,
            firstName: "Andy",
            username: "andyking15",
            profileImageURL: "exampleProfileImg"
        )
    ]
}
