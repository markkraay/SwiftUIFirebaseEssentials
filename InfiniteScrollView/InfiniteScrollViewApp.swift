//
//  InfiniteScrollViewApp.swift
//  InfiniteScrollView
//
//  Created by M Kraay on 3/13/22.
//

import SwiftUI
import Firebase

@main
struct FitnessTrackerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        let posts = PostsViewModel()
        WindowGroup {
            ContentView()
                .environmentObject(posts)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
