//
//  UserService.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

import Foundation

// The service responsible for fetching users from the remote API
class UserService {
    //the base URL to fetch data from
    private let baseURL = "https://jsonplaceholder.typicode.com/users"
    
    // Fetches users from the API and returns the result asynchronously
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        
        // Ensure URL is correct/valid
        guard let url = URL(string: baseURL) else {
            completion(.failure(.invalidURL))
            return
        }

        // Uses the shared network manager (singleton instance) to perform the request
        NetworkManager.shared.request(url: url, completion: completion)
    }
}
