//
//  UserDefaults.swift
//  PayTabsClient
//
//  Created by Mohamed Adly on 6/3/20.
//  Copyright © 2020 Mohamed Adly. All rights reserved.
//

import Foundation

extension UserDefaults {
    static func saveToken(token: String) {
        UserDefaults.standard.set(token, forKey: "Token")
    }
    
    static func saveCustomerEmail(email: String) {
        UserDefaults.standard.set(email, forKey: "Email")
    }
    
    static func saveCustomerPassword(password: String) {
        UserDefaults.standard.set(password, forKey: "Password")
    }

    static var token: String? {
        return UserDefaults.standard.value(forKey: "Token") as? String ?? ""
    }

    static var CustomerEmail: String? {
        return UserDefaults.standard.value(forKey: "Email") as? String ?? ""
    }
    
    static var password: String? {
        return UserDefaults.standard.value(forKey: "Password") as? String ?? ""
    }
}
