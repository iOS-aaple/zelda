//
//  Messages.swift
//  zelda
//
//  Created by Aamer Essa on 15/01/2023.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore


class Messages:ObservableObject  {
    
    @Published var message: [Message] = []
    @Published var lastMessageId : String = ""
    @Published var chatID : String = ""
    let receiverUser : User?
    init(receiverUser:User){
        self.receiverUser = receiverUser
        getMessage()
    }
     func sendMessage(text:String,senderID:String,chatID:String,receiverID:String){
        
        
      let dbRef : DatabaseReference!
        dbRef = Database.database().reference().child("Chats").child("\(UUID())").child("Messages").child("\(UUID())")
          dbRef.updateChildValues(["text":text,"senderID":senderID,"receiverID":receiverID,"time":"\(Date())"])
    
    }
    
     func getMessage(){
        
        
        let dbRef: DatabaseReference!
         dbRef = Database.database().reference().child("Chats").child("\(receiverUser!.id)\(Auth.auth().currentUser!.uid)").child("Messages")
            dbRef.observe(.childAdded) { dataSnapshot, err in
            
            if let allMessages = dataSnapshot.value as? NSDictionary {
 
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
               let time =  dateFormater.date(from: "\(allMessages["time"] as! String)")
                
                let newMessage = Message(id: dataSnapshot.key, text: allMessages["text"] as! String, resivserID: allMessages["receiverID"] as! String, senderID: allMessages["senderID"] as! String,time: time!)
                self.message.append(newMessage)
            }
            self.message.sort {$0.time < $1.time}
            if let id = self.message.last?.id {
                self.lastMessageId = id
            }
           
        }
        
    }
}


struct Message: Identifiable , Codable{
    var id : String
    var text:String
    var resivserID : String
    var senderID : String
    var time:Date
}

