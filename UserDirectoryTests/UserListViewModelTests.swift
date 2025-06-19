//
//  UserListViewModelTests.swift
//  UserDirectoryTests
//
//  Created by Bakr Marouf on 6/17/25.
//

import XCTest
@testable import UserDirectory

final class UserListViewModelTests: XCTestCase {

    // Test: Does search filter users correctly when searching? (Testing using the query "johnny") + mock user
    func testSearchFiltersUsersCorrectly() {
        let expectation = XCTestExpectation(description: "Filtered users should include Johnny Appleseed")

        // A view model is created to test the user list
        let viewModel = UserListViewModel()
        let users = [
            User(id: 1, name: "Johnny Appleseed", email: "johnny@test.com", phone: "123", website: "johnny.com", address: .mock(city: "Austin"), company: .mock(name: "CompanyA")),
            User(id: 2, name: "Bob Smith", email: "bob@test.com", phone: "456", website: "bob.com", address: .mock(city: "Boston"), company: .mock(name: "CompanyB"))
        ]

        //Users are assigned and then the search for lowercase "johnny" is performed
        DispatchQueue.main.async {
            viewModel.users = users
            viewModel.search(query: "johnny")

            //delaying so state changes and the UI update propagates to test properly
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                // One result with "Johnny Appleseed" is expected here
                XCTAssertEqual(viewModel.filteredUsers.count, 1)
                XCTAssertEqual(viewModel.filteredUsers.first?.name, "Johnny Appleseed")
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }
    
    // Test: Does search return the correct user (confirming by id)?
    func testSearchReturnsCorrectUser() {
        let expectation = XCTestExpectation(description: "Search returns correct user by ID")

        // A view model is created to test the user list and a test user is added
        let viewModel = UserListViewModel()
        let originalUser = User(id: 99, name: "Test User", email: "test@user.com", phone: "000", website: "test.com", address: .mock(city: "Denver"), company: .mock(name: "CompanyX"))

        //Users are assigned and then the search for the test user is performed
        DispatchQueue.main.async {
            viewModel.users = [originalUser]
            viewModel.search(query: "test")

            // The filtered result should return the same user confirmed by id
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                let filtered = viewModel.filteredUsers.first
                XCTAssertEqual(filtered?.id, originalUser.id)
                expectation.fulfill()
            }
        }

        wait(for: [expectation], timeout: 2.0)
    }
    
    // Test: Does the API call succeed in fetching users and return a non-empty user list?
    func testUserServiceFetchUsersSuccess() {
        let service = UserService()
        let expectation = XCTestExpectation(description: "UserService: Users fetched successfully")

        service.fetchUsers { result in
            switch result {
            case .success(let users):
                // Confirming that a non empty user list is received
                XCTAssertFalse(users.isEmpty, "Expected non-empty users list")
                expectation.fulfill()
            case .failure(let error):
                XCTFail("Expected success but failed: \(error)")
            }
        }

        wait(for: [expectation], timeout: 5.0)
    }

}

