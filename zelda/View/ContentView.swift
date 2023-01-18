//
//  ContentView.swift
//  zelda
//
//  Created by Aamer Essa on 14/01/2023.
//

import SwiftUI
import FirebaseAuth
import Firebase

struct ContentView: View {
    @State var showHomeView = false
    var body: some View {
       Login_signupView()
            .onAppear{
                Auth.auth().addStateDidChangeListener { auth, user in
                    if user != nil {
                        guard let userID = user?.uid else { return }
                        DBModel.curentUserID = userID
                        showHomeView = true
                    }
                }
            }
            .fullScreenCover(isPresented: $showHomeView) {
                HomeView()
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

