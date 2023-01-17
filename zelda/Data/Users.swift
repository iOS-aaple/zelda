//
//  Users.swift
//  zelda
//
//  Created by Aamer Essa on 15/01/2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import FirebaseStorage


class Users : ObservableObject {
    
    @Published var users: [User] = []
    @Published var userInfo: [User] = []
    
    init(){
        getAllUsers()
        //getUserInfo(userID: Auth.auth().currentUser?.uid ?? "")
    }
    func singup(name:String,email:String,password:String){
        
        Auth.auth().createUser(withEmail: email, password: password){ authrize , err  in
            
            if err != nil {
                
            } else {
                
                let dbRef: DatabaseReference!
                dbRef = Database.database().reference().child("Users").child("\(authrize!.user.uid)")
                dbRef.setValue(["fullName":name,"email":email,"password":password])
                
                
                
            }
        }
    }
    
    func getUserInfo(userID:String){
        
        
        let dbRef :DatabaseReference!
        dbRef = Database.database().reference().child("Users").child("\(userID)")
        dbRef.observe(.value){ resualt, err  in
            
            if err != nil {
                print("error")
            } else {
                if let user = resualt.value as? NSDictionary {
                    
                    let newUser = User(id: userID, name: user["fullName"] as! String, email: user["email"] as! String, password: user["password"] as! String, profileImage: user["profileImage"] as! String, jewelry: 100)
                    
                    self.userInfo.append(newUser)
                    
                }
                
            }
            
        }
        
    }
    
    func getAllUsers(){
        
        let dbRef: DatabaseReference!
            dbRef = Database.database().reference().child("Users")
            dbRef.observe(.value) { users, err in
            
                if let allUsers = users.value as? NSDictionary {
                    for user in allUsers {
                        let userInfo = user.value as? NSDictionary
                        
                        let newUser = User(id: "\(user.key)", name: userInfo!["fullName"] as! String, email: userInfo!["email"] as! String, password: userInfo!["password"] as! String, profileImage: "1", jewelry: 100)
                        
                        self.users.append(newUser)
                    }
                }
        }
    }
}

struct User : Codable,Identifiable {
    var id: String
    var name: String
    var email: String
    var password: String
    var profileImage :String
    var jewelry : Int
}


