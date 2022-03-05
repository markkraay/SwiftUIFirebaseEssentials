//
//  User.swift
//  UserAuthentication
//
//  Created by M Kraay on 2/28/22.
//

import Foundation

struct User: Codable {
    var uuid: String
    var username: String
    var firstName: String
    var lastName: String
    var signUpDate = Date.now
    var keywordsForLookup: [String] {
        [self.username.generateStringSequence(), self.firstName.generateStringSequence(), self.lastName.generateStringSequence(), "\(self.firstName) \(self.lastName)".generateStringSequence()].flatMap { $0 }
    }
}

extension String {
    func generateStringSequence() -> [String] {
        /// E.g) "Mark" yields "M", "Ma", "Mar", "Mark"
        var sequences: [String] = []
        for i in 1...self.count {
            sequences.append(String(self.prefix(i)))
        }
        return sequences
    }
}
