//
//  ErrorView.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

import SwiftUI

struct ErrorView: View {
    let message: String //Error message shown
    let retryAction: () -> Void //retry closure

    var body: some View {
        VStack(spacing: 12) {
            Text("Oops!")
                .font(.title2)
                .bold()
            Text(message)
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            Button("Retry", action: retryAction)
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

