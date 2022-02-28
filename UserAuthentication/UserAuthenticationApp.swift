//
//  UserAuthenticationApp.swift
//  UserAuthentication
//
//  Created by M Kraay on 2/21/22.
//

import SwiftUI
import UIKit
import Firebase

@main
struct UserAuthenticationApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            let user = UserViewModel()
            
            ContentView()
                .environmentObject(user)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions:
                   [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
