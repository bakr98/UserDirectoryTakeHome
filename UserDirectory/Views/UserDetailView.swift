//
//  UserDetailView.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User // user data passed in via the main list

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // User's name as title, for a more modern look
                Text(user.name)
                    .font(.title).bold()
                
                // Section with email, phone, company, and full address
                VStack(alignment: .leading, spacing: 12){
                    Group {
                        Label(user.email, systemImage: "envelope")
                        Divider()
                        
                        Label(user.phone, systemImage: "phone")
                        Divider()
                        
                        Label(user.company.name, systemImage: "building.2")
                        Divider()
                        
                        Label(user.address.fullAddress, systemImage: "house")
                    }
                }
                .font(.body)
                .padding()
                .background(Color(UIColor.systemGray6)) // Light gray card background that looks good in dark mode too
                .cornerRadius(10)
                
                // Clickable website link below info VStack
                if let url = URL(string: "https://\(user.website)") {
                    Link(destination: url){
                        Image(systemName: "safari")
                        Text("Visit Website")
                            .fontWeight(.semibold)
                        
                    }
                    .font(.headline)
                    .foregroundColor(Color.primary)

                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
