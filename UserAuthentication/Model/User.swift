//
//  User.swift
//  UserAuthentication
//
//  Created by M Kraay on 2/21/22.
//

import Foundation

struct User: Codable {
    var firstName: String
    var lastName: String
    var signUpDate = Date.now
}
