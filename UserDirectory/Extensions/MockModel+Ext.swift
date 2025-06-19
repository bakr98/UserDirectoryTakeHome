//
//  MockModel+Ext.swift
//  UserDirectory
//
//  Created by Bakr Marouf on 6/17/25.
//

// Provides a mock Address for unit testing
extension Address {
    static func mock(city: String = "City") -> Address {
        Address(street: "123", suite: "Apt 1", city: city, zipcode: "00000")
    }
}

// Provides a mock Company for unit testing
extension Company {
    static func mock(name: String = "Company") -> Company {
        Company(name: name)
    }
}

