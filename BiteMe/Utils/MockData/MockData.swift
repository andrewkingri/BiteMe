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
            ingredients: [
                .init(name: "Romaine", measure: "2 cups"),
                .init(name: "Kale", measure: "1 cup"),
                .init(name: "Parmesan", measure: "1/4 cup shaved")
            ],
            instructions: "Wash and chop the romaine and kale. Toss with shaved parmesan, drizzle with olive oil and lemon, and season to taste.",
            imageURLs: ["Salad", "salad1"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Raspberry Cheesecake",
            dietTags: "",
            ingredients: [
                .init(name: "Caramelized raspberries", measure: "1 cup"),
                .init(name: "Cream cheese", measure: "16 oz"),
                .init(name: "Graham crust", measure: "1 prepared")
            ],
            instructions: "Bake the cream cheese filling over a graham crust until just set. Chill overnight, then top with caramelized raspberries before serving.",
            imageURLs: ["cheesecake", "cheesecake2"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Smokehouse Burger",
            dietTags: "",
            ingredients: [
                .init(name: "Angus beef", measure: "1/3 lb"),
                .init(name: "Bacon", measure: "2 strips"),
                .init(name: "BBQ sauce", measure: "2 tbsp"),
                .init(name: "Bun", measure: "1")
            ],
            instructions: "Form angus beef into patties and season generously. Grill to medium, top with crispy bacon and a brush of BBQ sauce, then build on a toasted bun.",
            imageURLs: ["burger", "burger2", "burger3"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Old Fashioned Kabobs",
            dietTags: "",
            ingredients: [
                .init(name: "Steak", measure: "1 lb cubed"),
                .init(name: "Bell peppers", measure: "2"),
                .init(name: "Onion", measure: "1 large")
            ],
            instructions: "Cube the steak and marinate briefly. Thread onto skewers with peppers and onion, then grill over high heat, turning until charred on all sides.",
            imageURLs: ["kabobs", "kabobs2"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Imani Salad",
            dietTags: "V,GF",
            ingredients: [
                .init(name: "Romaine", measure: "2 cups"),
                .init(name: "Kale", measure: "1 cup"),
                .init(name: "Parmesan", measure: "1/4 cup shaved")
            ],
            instructions: "Wash and chop the romaine and kale. Toss with shaved parmesan, drizzle with olive oil and lemon, and season to taste.",
            imageURLs: ["Salad", "salad1"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Raspberry Cheesecake",
            dietTags: "",
            ingredients: [
                .init(name: "Caramelized raspberries", measure: "1 cup"),
                .init(name: "Cream cheese", measure: "16 oz"),
                .init(name: "Graham crust", measure: "1 prepared")
            ],
            instructions: "Bake the cream cheese filling over a graham crust until just set. Chill overnight, then top with caramelized raspberries before serving.",
            imageURLs: ["cheesecake", "cheesecake2"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Smokehouse Burger",
            dietTags: "",
            ingredients: [
                .init(name: "Angus beef", measure: "1/3 lb"),
                .init(name: "Bacon", measure: "2 strips"),
                .init(name: "BBQ sauce", measure: "2 tbsp"),
                .init(name: "Bun", measure: "1")
            ],
            instructions: "Form angus beef into patties and season generously. Grill to medium, top with crispy bacon and a brush of BBQ sauce, then build on a toasted bun.",
            imageURLs: ["burger", "burger2", "burger3"]
        ),
        .init(
            id: NSUUID().uuidString,
            name: "Old Fashioned Kabobs",
            dietTags: "",
            ingredients: [
                .init(name: "Steak", measure: "1 lb cubed"),
                .init(name: "Bell peppers", measure: "2"),
                .init(name: "Onion", measure: "1 large")
            ],
            instructions: "Cube the steak and marinate briefly. Thread onto skewers with peppers and onion, then grill over high heat, turning until charred on all sides.",
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
