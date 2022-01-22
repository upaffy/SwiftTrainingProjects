//
//  User.swift
//  LoginApp
//
//  Created by Pavlentiy on 29.08.2021.
//

import Foundation

struct User {
    let username: String
    let password: String
    
    let person: Person
}

struct Person {
    let name: String
    let surname: String
    
    let address: String
    let age: Int
}
