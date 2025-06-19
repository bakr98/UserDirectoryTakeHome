//
//  UserListViewModel.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

import Foundation

class UserListViewModel: ObservableObject {
    
    //Published Properties
    
    @Published var users: [User] = []           // User list from API/Cache
    @Published var filteredUsers: [User] = []   // List after filtering (searching/sorting)
    @Published var isLoading = false            // Controls when loading UI is displayed
    @Published var error: String?               // String for UI error message
    
    //Sorting options for the user list
    enum SortOption {
        case nameAsc, nameDesc, cityAsc, cityDesc
    }

    // The option selected for sorting, initially ascending by name
    @Published var sortOption: SortOption = .nameAsc

    // service layer, private for only the View Model to access and make network calls to fetch users
    private let service = UserService()

    // Fetches users from the API or falls back to cache if request fails
    func fetchUsers() {
        isLoading = true
        service.fetchUsers { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let users):
                    self?.users = users
                    self?.filteredUsers = users
                    UserStore.save(users) // saves to UserDefaults
                case .failure(let err):
                    self?.error = "Failed to fetch users: \(err)"
                    let cachedUsers = UserStore.load() //loads cache from UserDefaults
                    if !cachedUsers.isEmpty {
                        self?.users = cachedUsers
                        self?.filteredUsers = cachedUsers
                        self?.error = nil
                    }
                }
            }
        }
    }

    // Filters users based on name and keeps current sort (by sorting again after search)
    func search(query: String) {
        DispatchQueue.main.async {
            if query.isEmpty {
                self.filteredUsers = self.users
            } else {
                self.filteredUsers = self.users.filter {
                    $0.name.lowercased().contains(query.lowercased())
                }
            }
            self.sortUsers()
        }
    }
    
    // Sorts the filteredUsers List based on the user selected SortOption
    func sortUsers() {
        switch sortOption {
        case .nameAsc:
            filteredUsers.sort { $0.name.lowercased() < $1.name.lowercased() }
        case .nameDesc:
            filteredUsers.sort { $0.name.lowercased() > $1.name.lowercased() }
        case .cityAsc:
            filteredUsers.sort { $0.address.city.lowercased() < $1.address.city.lowercased() }
        case .cityDesc:
            filteredUsers.sort { $0.address.city.lowercased() > $1.address.city.lowercased() }
        }
    }

}

