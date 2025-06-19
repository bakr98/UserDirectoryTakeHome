//
//  UserRowView.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

import SwiftUI

struct UserRowView: View {
    let user: User

    var body: some View {
        HStack {
            //a contacts circle similar to Apple's Contacts/Phone app for cosmetic purposes
            Circle()
                .fill(Color(UIColor.lightGray).opacity(1))
                .frame(width: 45, height: 45)
                .overlay(
                    Text(user.name.initials())
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                )
            
            //User details for the row (name, email, city)
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(user.address.city)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            .padding(.vertical, 4)
        }
    }
}
