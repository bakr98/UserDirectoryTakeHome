//
//  UserListView.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

import SwiftUI

// The main view displaying a searchable/sortable list of users.
struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    @State private var searchText = ""
    @State private var isShowingDetail = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            NavigationStack {
                Group {
                    if viewModel.isLoading {
                        LoadingView() // show loading spinner while fetching users
                    } 
                    else if let errorMessage = viewModel.error {
                        ErrorView(message: errorMessage) {
                            viewModel.fetchUsers() // Retry fetch if we run into an error
                        }
                    } 
                    else {
                        List(viewModel.filteredUsers) { user in
                            // Show each user in a row with a navigation link to their detail view
                            NavigationLink(
                                destination: UserDetailView(user: user)
                                    .onAppear { isShowingDetail = true }
                                    .onDisappear { isShowingDetail = false })
                            { UserRowView(user: user) }
                            
                        }
                        .listStyle(.inset)
                        .refreshable { // Pull to refresh!
                            viewModel.isLoading = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                viewModel.fetchUsers()
                                viewModel.isLoading = false
                            }
                        }
                    }
                }
                .navigationTitle("Users")
                .searchable(text: $searchText, prompt: "Search")
                .onAppear {
                    viewModel.fetchUsers() //when the view appears, inital fetch
                }
                .onChange(of: searchText) { newValue in
                    viewModel.search(query: newValue)
                } // listens to changes in searchText binding as the user types and updates accordingly
                .onChange(of: viewModel.sortOption) { _ in
                    viewModel.sortUsers() //listens to changes in sortOption and updates/re-sorts if an option is selected
                }

            }
            
            if !isShowingDetail {
                // show floating button menu, only when not in detail view
        
                Menu { // The Menu with 4 different buttons for each sorting option
                    Button("Name ↑") { viewModel.sortOption = .nameAsc }
                    Button("Name ↓") { viewModel.sortOption = .nameDesc }
                    Button("City ↑") { viewModel.sortOption = .cityAsc }
                    Button("City ↓") { viewModel.sortOption = .cityDesc }
                } label: {
                    Circle()
                        .fill(Color.blue)
                        .frame(width: 50, height: 50)
                        .overlay(
                            Image(systemName: "arrow.up.arrow.down")
                                .foregroundColor(.white)
                        )
                        .padding()
                        .shadow(radius: 4)
                }
            }
            
        }
    }
}


#Preview {
    UserListView()
}
