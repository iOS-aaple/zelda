//
//  HomeView.swift
//  zelda
//
//  Created by Munira on 14/01/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Home()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
struct Home: View {
    @State var midY : CGFloat = 0
//    var image : String
//    @Binding var selectedTab : String
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                   ZStack {
                       Image("background")
                           .resizable()
                           .aspectRatio(geometry.size, contentMode: .fill)
                           .edgesIgnoringSafeArea(.all)
                       VStack {
                           ForEach(gamesImages,id: \.self){ image in
                               GeometryReader { reader in
                                   Button ( action : {} , label: {
                                       Image(image)
                                           .resizable()
                                           .renderingMode(.original)
                                           .aspectRatio( contentMode: .fit)
                                           .frame(width: 90)
                                      
                                   })
                                   .frame(width: 150, height: 110)
                                   .onAppear(perform: {
                                       if image == gamesImages.first {
                                           self.midY = reader.frame(in: .global).midY
                                       }
                               })
                               }
                             
                           }
                         
                       }
                       
                       .padding(.horizontal, 0)
                       .padding(.vertical)
                       .background(Color(red: 0.01332890149, green: 0.04810451716, blue:  0.1187042817))
                       .frame(height: 500)
                       .clipShape(CShape())
                       .padding(.trailing, 260)
                       .padding(.leading)
                       HStack {
//                            for tab bar
                           GeometryReader { reader in
                               Button( action: { }, label: {
//                                   Image(systemName: image)
                               })
                               
                               //max frame
                               .frame(maxWidth: .infinity, maxHeight: .infinity)
                           }
                           
                       }
                     
                   }
            }
        }
    }
    func getColor(image: String) -> Color{
        switch image {
        case "person.2" :
            return Color(red: 0.5178312063, green: 0.5018281341, blue: 0.6384580731)
        case "house" :
            return Color(red: 0.5178312063, green: 0.5018281341, blue: 0.6384580731)
        case "person.crop.circle" :
            return Color(red: 0.5178312063, green: 0.5018281341, blue: 0.6384580731)
        default:
            return Color.white
        }
    }
}
// get all images
var gamesImages = ["XO", "snakeandladder","puzzle","sudoku",""]

var tabBar = ["person.2","house","person.crop.circle"]

// corner shape for side bar
struct CShape : Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 25, height: 25))
        return Path(path.cgPath)
    }
}

// custom shape for tabbar
struct CustomShape: Shape {
    var midY : CGFloat
    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: rect.width , y: rect.height))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let width = rect.width
            
            path.move(to: CGPoint(x: width, y: midY - 40))
            
            let to1 = CGPoint(x: width - 80, y: midY - 50)
            let control1 = CGPoint(x: width - 30, y: midY - 60)
            let control2 = CGPoint(x: width - 80, y: midY - 50)
            
            path.addCurve(to: to1, control1: control1, control2: control2)
            
            let to2 = CGPoint(x: width , y: midY + 40)
            let control3 = CGPoint(x: width - 190, y: midY + 70)
            let control4 = CGPoint(x: width + 40, y: midY + 70)
            
            path.addCurve(to: to2 , control1: control3, control2: control4)
        }
    }
}
struct TabBar: View {
    let image: Image
    let type:String
    var numberOfProducts:Int
    var body: some View {
        if type == "ShopingCart"{
            ZStack(alignment: .topTrailing){
                image
                    .resizable()
                    .accentColor(.black)
                    .frame(width: 33,height: 30)
                    .frame(maxWidth: 150)
                
//                Text("\(myCart.count)")
                    .foregroundColor(Color.white)
                    .font(.caption2).bold()
                    .frame(width: 15,height: 15)
                    .background(
                        Circle().fill(Color.red)
                      
                    )
            }
        } else{
            HStack{
                       image
                            .resizable()
                            .accentColor(.black)
                            .frame(width: 33,height: 30)
                            .frame(maxWidth: 150)
                   }
        }
    }
}
