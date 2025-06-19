//
//  User.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/15/25.
//

// mirrors the JSON for the User from the API
// conforms to Codable, so it can be parsed from the JSON
// confroms to Identifiable, so it can be used in List with a unique id for each instance
struct User: Codable, Identifiable {
    let id: Int
    let name: String
    let email: String
    let phone: String
    let website: String
    let address: Address
    let company: Company
}
