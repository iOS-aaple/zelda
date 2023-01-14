//
//  FrindsView.swift
//  zelda
//
//  Created by Aamer Essa on 14/01/2023.
//

import SwiftUI

struct FrindsView: View {
    
    
    var allusers = Users.getUsers()
    var body: some View {
     
        NavigationView{
            List {
                ForEach(0 ..< allusers.count){ user in
                    Text("AAAA")
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
