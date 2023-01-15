//
//  ContentView.swift
//  zelda
//
//  Created by Aamer Essa on 14/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State var playerName = ""
    @State var playerEmail = ""
    @State var playerPassword = ""
    @State var password = ""
    @State var editingToggle = false
    @State var playerBirthDate = Date.now
    @State var playerCoins = ""
    
    var body: some View {
        GeometryReader{
            geometry in
            ZStack{
                Image("background")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    infoView(playerName: $playerName, playerEmail: $playerEmail , playerPassword:  $playerPassword , isEditingeOn: $editingToggle, playerBirthDate: $playerBirthDate, playerCoins: $playerCoins)
                }.padding()
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct infoView : View {
    @Binding var playerName : String
    @Binding var playerEmail : String
    @Binding var playerPassword : String
    @Binding var isEditingeOn : Bool
    @Binding var playerBirthDate : Date
    @Binding var playerCoins : String
    
    var body: some View{

        ZStack(alignment: .topLeading){
            
            VStack(alignment: .leading){
            
            HStack(alignment: .center){
            Text("\(playerName) Ahmad's Account ")
            .font(.system(size: 30))
            .fontDesign(.serif)
            .foregroundColor(Color.white)
            }
            .padding(20)
            .background(Color(red: 21/255, green: 50/255, blue: 89/255))
            .cornerRadius(40)
            

                HStack(alignment: .center){
                    Image("dollar")
                    .resizable()
                    .frame(width: 30 , height: 30)
                    Text("\(playerCoins)120$")
                    .foregroundColor(Color.white)
                }.padding(20)

            Spacer()
            
            VStack{
                ZStack(alignment: .leading){
                Image(systemName:"person")

                TextField("", text: $playerName , prompt: Text("\(playerName)  ...").foregroundColor(.white.opacity(0.6))) // if the  placeeholder displayes the last stored name in db will be 👍🏻
                    .padding([.leading] , 30)
                    .disabled(!isEditingeOn)
                }.foregroundColor(.white)
                
                ZStack(alignment: .leading){
                Image(systemName:"at")
                TextField("", text: $playerEmail, prompt: Text("Email...").foregroundColor(.white.opacity(0.6)))
                    .disabled(!isEditingeOn)
                    .padding([.leading] , 30)
                }.foregroundColor(.white)
                
                ZStack(alignment: .leading){
                Image(systemName:"staroflife.circle")
                SecureField("", text: $playerPassword, prompt: Text("Password...").foregroundColor(.white.opacity(0.6)))
                    .disabled(!isEditingeOn)
                    .padding([.leading] , 30)
                }.foregroundColor(.white)
                
                VStack(alignment: .leading){
                    DatePicker(selection: $playerBirthDate, in: ...Date.now, displayedComponents: .date){
                    Text("Select a date")
                    }.disabled(!isEditingeOn)
                    .colorInvert().colorMultiply(.white)
                        
                                    
                    Text("Your Birth day:   \(playerBirthDate.formatted(date: .long, time: .omitted))")
                    .foregroundColor(Color.white)
                                    
                    
                }.padding(.top , 30)

                Toggle("Activate Editing", isOn: $isEditingeOn)
                .foregroundColor(Color.white)
                .padding(.top , 30)
                
                
               
                
                    Button {
                        //update content in db
                    } label: {
                        Text("Save Edition")
                            .frame(width:200, height: 30 , alignment:.center)
                            .background(Color.gray.opacity(0.4))
                            .foregroundColor(Color.white)
                            .cornerRadius(8)
                    }.disabled(playerName.isEmpty || playerEmail.isEmpty || playerPassword.isEmpty) // wrong opinion
                        .padding([.top] , 30)
                
                Button {
                    //signOut user
                } label: {
                    Text("SignOut")
                        .frame(width:200, height: 30 , alignment:.center)
                        .background(Color.gray.opacity(0.4))
                        .foregroundColor(Color.red)
                        .cornerRadius(8)
                }
                
            }.padding(30)
                .background(Color(red: 21/255, green: 50/255, blue: 89/255))
                .cornerRadius(40)
                
               
            }
            
            Image("1")
                .resizable()
                .frame(width: 120 , height: 180)
                .padding(.leading , 40)
                .padding(.top , 160)
        
        }
    }
}
