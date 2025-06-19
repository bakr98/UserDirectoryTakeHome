//
//  String+Ext.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/18/25.
//

import Foundation

extension String {
    func initials() -> String { 
        //To get the user's initials for use in UserRowView's contact circle, made reusable via String extension
        
        let components = self.split(separator: " ")
        let firstInitial = components.first?.first.map(String.init) ?? ""
        let secondInitial = components.dropFirst().first?.first.map(String.init) ?? ""
        return (firstInitial + secondInitial).uppercased()
    }
}
