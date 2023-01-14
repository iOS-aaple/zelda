//
//  Users.swift
//  zelda
//
//  Created by Aamer Essa on 14/01/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase


class Users {
    
    static func getUsers() -> [NSDictionary]{
        
        var users = [NSDictionary]()
        let dbRef : DatabaseReference!
        dbRef = Database.database().reference().child("Users")
        dbRef.observe(.value) { dataSnapshot, err in
            print(dataSnapshot)
            if dataSnapshot.value is NSDictionary {
                DispatchQueue.main.async {
                    
                    for user in users {
                        users.append(user)
                        print(user)
                    }
                }
                
               
            }
            
        }
        print("🔴")
        print(users)
        return users
    }
}


