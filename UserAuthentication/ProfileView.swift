//
//  ProfileView.swift
//  UserAuthentication
//
//  Created by M Kraay on 2/22/22.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var user: UserViewModel
    
    var body: some View {
        VStack {
            Text("Succesfully authenticated \(user.user?.firstName ?? "") \(user.user?.lastName ?? "")")
            Button(action: {
                user.signOut()
            }) {
                Text("Sign Out")
            }
        }
    }
}

