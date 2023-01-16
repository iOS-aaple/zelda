//
//  zeldaApp.swift
//  zelda
//
//  Created by Aamer Essa on 14/01/2023.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct zeldaApp: App {
    
    @StateObject var appState = AppState.shared
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ContentView()
           // snake().id(appState.gameID)
            
        }
    }
}

class AppState: ObservableObject{
    static let shared = AppState()
    @Published var gameID = UUID()
}
