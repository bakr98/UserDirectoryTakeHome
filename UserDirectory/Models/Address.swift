//
//  Address.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/15/25.
//

// mirrors the JSON for the Address from the API
struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String

    // Creates a nice formatted readable string with all the fields brought together
    var fullAddress: String {
        "\(suite), \(street), \(city), \(zipcode)"
    }
}

