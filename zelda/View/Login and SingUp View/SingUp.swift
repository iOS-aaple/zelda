//
//  SingUp.swift
//  zelda
//
//  Created by Aamer Essa on 15/01/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import FirebaseFirestore
import FirebaseStorage

struct SignUP : View {
    
    @State var fullName = ""
    @State var email = ""
    @State var pass = ""
    @State var Repass = ""
    @Binding var index : Int
    let userOp = Users()
    @State var showErrorMessage = true
    @State  var errorMessage = String()
    
    var body: some View{
        
        ZStack(alignment: .bottom) {
            
            VStack{
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    VStack(spacing: 10){
                        
                        Text("SignUp")
                            .foregroundColor(self.index == 1 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 1 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                }
                .padding(.top, 30)
                
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "person.fill")
                            .foregroundColor(Color("Color4"))
                        
                        TextField("Full Name", text: self.$fullName)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color("Color4"))
                        
                        TextField("Email Address", text: self.$email)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Color4"))
                        
                        SecureField("Password", text: self.$pass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
                
                
                VStack{
                    
                    HStack(spacing: 15){
                        
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(Color("Color4"))
                        
                        SecureField("Password", text: self.$Repass)
                    }
                    
                    Divider().background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                
             
                if !showErrorMessage {
                    HStack(spacing: 15){
                        
                        Text(errorMessage)
                            .padding(.horizontal)
                            .padding(.top, 30)
                    }
                    
                }
                
            }
            .padding()
            .padding(.bottom, 65)
            .background(Color("Color2"))
            .clipShape(CShape1())
            .contentShape(CShape1())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
                
                self.index = 1
                
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            // Button
            
            Button(action: {
                singup(name: self.fullName, email: self.email, password: self.pass)
            }) {
                
                Text("SIGNUP")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color("Color3"))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }
            .offset(y: 25)
            
            .opacity(self.index == 1 ? 1 : 0)
        }
        //    .offset(y: 50)
    }
    
     func singup(name:String,email:String,password:String){
        
        Auth.auth().createUser(withEmail: email, password: password){ authrize , err  in
            
            if err != nil {
                
                
                
                .alert(isPresented: $showErrorMessage) {
                           Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
                       }
                
            } else {
                
                let dbRef: DatabaseReference!
                dbRef = Database.database().reference().child("Users").child("\(authrize!.user.uid)")
                dbRef.setValue(["fullName":name,"email":email,"password":password])
                
                
                
            }
        }
        
    }
    
}
//struct SingUp_Previews: PreviewProvider {
//    static var previews: some View {
//        SingUp()
//    }
//}
