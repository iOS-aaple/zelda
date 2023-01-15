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


class Users {
    
    
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
}
