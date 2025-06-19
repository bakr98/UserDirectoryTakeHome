//
//  NetworkManager.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

import Foundation

// enum for errors that could happen during the network request
enum NetworkError: Error {
    case invalidURL                 // URL string was not able to be turned into a valid usable URL
    case unableToComplete           // General netork issue
    case invalidResponse            // The server response was not valid (HTTP 200)
    case invalidData                // No data received
    case decodingError(Error)       // Decoding the JSON failed
}

class NetworkManager {
    static let shared = NetworkManager() // Singleton responsible for performing network requests
    private init() {}

    // Makes a network request and decodes the response (T/generic for reusablity sake)
    func request<T: Decodable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            // if there's a networking error/no internet, return unableToComplete
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }

            // Check that the response is a valid HTTP response (200 (OK) status code)
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            // Makes sure that there's actual data to be decoded before we try decoding
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }

            // Try to decode the data
            do {
                let decoded = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decodingError(error)))
            }
        }
        
        // resume the task/start the network request
        task.resume()
    }
}
