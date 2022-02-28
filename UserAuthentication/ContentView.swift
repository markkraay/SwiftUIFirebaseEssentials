//
//  ContentView.swift
//  UserAuthentication
//
//  Created by M Kraay on 2/21/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        NavigationView {
            if user.userIsAuthenticatedAndSynced {
                ProfileView()
            } else {
                AuthenticationView()
            }
        }
    }
}


