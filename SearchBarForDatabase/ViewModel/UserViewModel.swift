//
//  UserViewModel.swift
//  UserAuthentication
//
//  Created by M Kraay on 2/28/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserViewModel: ObservableObject {
    @Published var user: User?
    @Published var queryResultUsers: [User] = []
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    var uuid: String? {
        auth.currentUser?.uid
    }
    var userIsAuthenticated: Bool {
        auth.currentUser != nil
    }
    var userIsAuthenticatedAndSynced: Bool {
        user != nil && userIsAuthenticated
    }
    
    // Firebase Auth Functions
    func signIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            DispatchQueue.main.async {
                self?.sync()
            }
            
        }
    }
    
    func signUp(username: String, email: String, firstName: String, lastName: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else { return }
            DispatchQueue.main.async {
                self?.add(User(uuid: (self?.uuid)!, username: username, firstName: firstName, lastName: lastName))
                self?.sync()
            }
        }
    }
    
    func signOut() {
        do {
            try auth.signOut()
            self.user = nil
        } catch {
            print("Error signing out user: \(error)")
        }
    }
    
    // Firestore Functions for User Data
    private func sync() {
        guard userIsAuthenticated else { return }
        db.collection("users").document(self.uuid!).getDocument { (document, error) in
            guard document != nil, error == nil else { return }
            do {
                try self.user = document!.data(as: User.self)
            } catch {
                print("Sync error: \(error)")
            }
        }
    }
    
    private func add(_ user: User) {
        guard userIsAuthenticated else { return }
        do {
            let document = db.collection("users").document(self.uuid!)
            try document.setData(from: user)
            document.updateData(["keywordsForLookup": user.keywordsForLookup])
            print("Added document")
        } catch {
            print("Error adding: \(error)")
        }
    }
    
    private func update() {
        guard userIsAuthenticatedAndSynced else { return }
        do {
            let document = db.collection("users").document(self.uuid!)
            try document.setData(from: user)
            document.updateData(["keywordsForLookup": self.user!.keywordsForLookup])
        } catch {
            print("Error updating: \(error)")
        }
    }
}
