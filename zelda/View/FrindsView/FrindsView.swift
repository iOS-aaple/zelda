//
//  FrindsView.swift
//  zelda
//
//  Created by Aamer Essa on 14/01/2023.
//

import SwiftUI

struct FrindsView: View {
    var body: some View {
        NavigationView {
    
            ZStack{
                Image("background")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    
                    List{
                        ForEach(1..<10){ i in
                            NavigationLink(destination: ChatsView() ){
                                Cell()
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
