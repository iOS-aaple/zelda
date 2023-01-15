//
//  Cell.swift
//  zelda
//
//  Created by Aamer Essa on 15/01/2023.
//

import SwiftUI

struct Cell: View {
     
  //  @Binding var order : Int
    var body: some View {
        
        HStack{
            Text("1")
                .foregroundColor(Color.white)
            
            Image("1")
                .resizable()
                .frame(width: 70,height: 70)
                .clipShape(Circle())
            
            ZStack{
                HStack(){
                    Text("user name")
                        .foregroundColor(Color.white)
                    Spacer()
                    Image("Awards_bronze")
                        .frame(width: 20,height: 20)
                }
            }
        }
        
        
    }
}


struct Cell_Previews: PreviewProvider {
    static var previews: some View {
        Cell()
    }
}
