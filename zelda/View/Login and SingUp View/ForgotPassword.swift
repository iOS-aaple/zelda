//
//  ForgotPassword.swift
//  zelda
//
//  Created by Aamer Essa on 15/01/2023.
//

import SwiftUI
import Firebase
import FirebaseAuth
struct ForgotPassword: View {
    @State var email = ""
    @State var showMessage = false
    @State var messageContent = String()
    @State var messageType = String()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        NavigationView{
            
            ZStack{
                
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    HStack{
                        Text("Forgot Password")
                            .font(.system(.title).bold())
                            .foregroundColor(Color.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    HStack{
                        Text("Enter the email associated with your account and we'll send an email to reast your password ")
                            .foregroundColor(Color.white)
                            .font(.system(.caption))
                            .padding(.top,20)
                    }
                    
                    HStack{
                        TextField("Email Address", text: self.$email)
                            .textFieldStyle(.roundedBorder)
                            .previewLayout(.sizeThatFits)
                            .padding()
                            
                        
                    }
                    
                    HStack{
                        Button(action:{forgotPassowrd(email: self.email)}){
                            Text("Send Email")
                                .frame(maxWidth: 200)
                                .padding(5)
                                .foregroundColor(Color.black)
                                .background(Color.white)
                        }
                        .background(Color.white)
                        .clipShape(Capsule())
                    }
                    Spacer()
                }
                .padding()
                
            }
            .alert(isPresented: $showMessage){
                Alert(title:
                        Text("\(messageType)")
                    .foregroundColor(Color.red)
                    .font(.system(.largeTitle)),
                      message: Text("\(messageContent)"),
                      dismissButton: .default(Text("Ok"),action: {
                    if messageType != "Error"{
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }))
                
            }
        }
        }
    
    func forgotPassowrd(email:String){
        if email == "" {
            messageType = "Error"
            showMessage = true
            messageContent = "Please fill all the contents "
        } else {
            
            Auth.auth().sendPasswordReset(withEmail: email){ err in
                
                if err != nil {
                    messageType = "Error"
                    showMessage = true
                    messageContent = "\(err!.localizedDescription) "
                } else{
                    messageType = "Check Your email"
                    showMessage = true
                    messageContent = "We have sent a link to rest the password"
                }
            }
        }
        
    }

        
    }
    



struct ForgotPassword_Previews: PreviewProvider {
   
    static var previews: some View {
        
        ForgotPassword()
    }
}
