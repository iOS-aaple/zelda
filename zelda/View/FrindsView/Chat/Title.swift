//
//  Title.swift
//  zelda
//
//  Created by Aamer Essa on 15/01/2023.
//

import SwiftUI

struct Title: View {
    
    var imageUrl = URL(string: "https://www.w3schools.com/howto/img_avatar.png")
    var name = "Amer essa"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        HStack(spacing:20){
            
            VStack{
                Button(action: {
                    self.presentationMode.wrappedValue.dismiss()
                }){
                    Image("back")
                        .frame(width:30,height:30)
                }
            }
            AsyncImage(url: imageUrl) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width:40,height: 40)
                    .cornerRadius(50)
            } placeholder: {
                ProgressView()
            }
            
            VStack(alignment: .leading){
                Text(name)
                    .font(.system(size: 20,design: .rounded))
                
                    
            }.frame(maxWidth:.infinity,alignment: .leading)
            

        }.padding()
            .background(.thinMaterial)
    }
}

struct Title_Previews: PreviewProvider {
    static var previews: some View {
        Title()
    }
}
