//
//  User.swift
//  BiteMe
//
//  Created by Andrew King on 10/15/25.
//

import Foundation

struct User: Identifiable, Hashable {
    let id: String
    let firstName: String
    let username: String
    let profileImageURL: String
}
