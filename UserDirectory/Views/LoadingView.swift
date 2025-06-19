//
//  LoadingView.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            //Default Spinner to show the user that the list is loading
            ProgressView()
            
            //Text under the spinner
            Text("Loading...")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
    }
}


#Preview {
    LoadingView()
}
