//
//  Login.swift
//  zelda
//
//  Created by Aamer Essa on 15/01/2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseDatabase
import Firebase
struct Login : View {
    
    @State var email = ""
    @State var pass = ""
    @Binding var index : Int
    @State var showErrorMessage = false
    @State var errorMessage = String()
    @State var forgotPassword = false
    
    var body: some View{
        
        ZStack(alignment: .bottom) {
            
            VStack{
                
                HStack{
                    
                    VStack(spacing: 10){
                        
                        Text("Login")
                            .foregroundColor(self.index == 0 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Capsule()
                            .fill(self.index == 0 ? Color.blue : Color.clear)
                            .frame(width: 100, height: 5)
                    }
                    
                    Spacer(minLength: 0)
                }
                .padding(.top, 30)
                
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
                
                HStack{
                    
                    Spacer(minLength: 0)
                    
                    NavigationLink(destination: ForgotPassword() ){
                        Text("Forget Password?")
                           .foregroundColor(Color.white.opacity(1))
                    }

                    
//                    Button(action: {
////                        login(email: self.email, passowrd: self.pass)
//                       forgotPassword = true
//                        NavigationLink(destination: ForgotPassword(), isActive: $forgotPassword) { EmptyView() }
//
//                    }) {
//
//                        Text("Forget Password?")
//                            .foregroundColor(Color.white.opacity(1))
//
//
//
//                    }
                    
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
            .padding()
            .padding(.bottom, 65)
            .background(Color("Color2"))
            .clipShape(CShape())
            .contentShape(CShape())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: -5)
            .onTapGesture {
                
                self.index = 0
                
            }
            .cornerRadius(35)
            .padding(.horizontal,20)
            
            
            Button(action: {
                login(email: self.email, password: self.pass)
            }) {
                
                Text("LOGIN")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color("Color3"))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1), radius: 5, x: 0, y: 5)
            }
            .offset(y: 25)
            .opacity(self.index == 0 ? 1 : 0)
        }
        .alert(isPresented: $showErrorMessage){
            Alert(title:
                    Text("⚠ Error")
                        .foregroundColor(Color.red)
                        .font(.system(.largeTitle)),
                  message: Text("\(errorMessage)"),
                  dismissButton: .default(Text("Ok")))

        }
        
    }
    
    func login(email:String,password:String){
        
        if email == "" || password == "" {
            
            showErrorMessage = true
            errorMessage = "Please fill all the contents "
            
        } else {
            
            Auth.auth().signIn(withEmail: email, password: password) { authorized , err in
                
                if err != nil {
                    errorMessage = "\(err!.localizedDescription)"
                    showErrorMessage = true
                    print("🔴")
                    
                } else{
                    print("🟢")
                    print("loged in")
                    
                }
            }
        }}
}

