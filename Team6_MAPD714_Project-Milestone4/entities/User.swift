//
//  User.swift
//  Team6_MAPD714_Project-Milestone4
//  *****Milestone 4*****
//  *****Team6*****
//  *****Team Members*****
//  Srijeet Sthapit - 301365217
//  Abi Chitrakar - 301369773
//  Promish Khaniya - 301369717
//
//  Created by Srijeet Sthapit on 2023-10-29.
//  Submitted on 2023-12-01

class User {
    var id: Int          // Property to store the user's ID
    var email: String    // Property to store the user's email
    var password: String // Property to store the user's password

    // Initializer to set up a new User instance
    init(id: Int, email: String, password: String) {
        self.id = id         // Assigning the id parameter to the id property
        self.email = email   // Assigning the email parameter to the email property
        self.password = password // Assigning the password parameter to the password property
    }
}
