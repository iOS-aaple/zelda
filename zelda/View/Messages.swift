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
    
    init(){
        getMessage(chatID: "12345")
    }
  static func sendMessage(text:String,senderID:String){
        
      let dbRef : DatabaseReference!
      dbRef = Database.database().reference().child("Chats").child("12345").child("Messages").child("\(UUID())")
      dbRef.updateChildValues(["text":text,"senderID":senderID,"time":"\(Date())"])
    
    }
    
     func getMessage(chatID:String){
        
        
        let dbRef: DatabaseReference!
        dbRef = Database.database().reference().child("Chats").child("\(chatID)").child("Messages")
        dbRef.observe(.childAdded) { dataSnapshot, err in
            
            if let allMessages = dataSnapshot.value as? NSDictionary {
 
                let dateFormater = DateFormatter()
                dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ssZ"
               let time =  dateFormater.date(from: "\(allMessages["time"] as! String)")
                
                let newMessage = Message(id: dataSnapshot.key, text: allMessages["text"] as! String, resivserID: allMessages["senderID"] as! String,time: time!)
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
    var time:Date
}

