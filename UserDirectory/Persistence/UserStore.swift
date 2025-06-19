//
//  UserStore.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

import Foundation

struct UserStore {
    
    //key used to store cached users in UserDefaults
    private static let cacheKey = "cached_users"

    //saves users to UserDefaults
    static func save(_ users: [User]) {
        do {
            let data = try JSONEncoder().encode(users)
            UserDefaults.standard.set(data, forKey: cacheKey)
        } catch {
            print("Failed to save users: \(error)")
        }
    }

    //loads users from UserDefaults and returns them in an Array, returns an empty array otherwise
    static func load() -> [User] {
        guard let data = UserDefaults.standard.data(forKey: cacheKey) else {
            return []
        }

        do {
            return try JSONDecoder().decode([User].self, from: data)
        } catch {
            print("Failed to load cached users: \(error)")
            return []
        }
    }
}

