//
//  FrindsView.swift
//  zelda
//
//  Created by Aamer Essa on 14/01/2023.
//

import SwiftUI

struct FrindsView: View {
    
    @ObservedObject var usersManger = Users()
    var body: some View {
        NavigationView {
    
            ZStack{
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    List{
                        ForEach(usersManger.users){ user in
                            NavigationLink(destination: ChatsView(resUser: user, messagesManger: Messages(receiverUser: user)) ){
                                Cell(user: user)
                            }
                            
                        }.listRowBackground(Color.clear)
                    }.background(.clear)
                        .scrollContentBackground(.hidden)
                }
               
            }
        }
    }
}

struct FrindsView_Previews: PreviewProvider {
    static var previews: some View {
        FrindsView()
    }
}
