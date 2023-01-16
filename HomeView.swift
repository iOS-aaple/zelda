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
    @State var selectedTab = "person.3.sequence.fill"
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                   ZStack {
                       Image("background")
                           .resizable()
                           .aspectRatio(geometry.size, contentMode: .fill)
                           .edgesIgnoringSafeArea(.all)
                       VStack {
                           HStack {
                               Text("Let's play!")
                                   .font(.title)
                                   .fontWeight(.bold)
                                   .foregroundColor(.white)
                               
                               Spacer()
                           }
                               // for side bar and the details
                           VStack(spacing: 20){
                               ForEach(games) { i in
                                   GamesView(gamesData: i)
                               }
                               }
                           HStack {
                               // for tab bar
                               NavigationLink (
                                   destination :
                                   FrindsView()
                                   , label : {
                                       ButtonTabBar(image: Image(systemName: "person.3.sequence.fill")) {}
                                   }
                              )
                               NavigationLink (
                                   destination :
                                    HomeView()
                                   , label : {
                                       ButtonTabBar(image: Image(systemName: "house")) {}
                                   }
                              )
                               NavigationLink (
                                   destination :
                                   AccountView()
                                   , label : {
                                       ButtonTabBar(image: Image(systemName: "person.crop.circle")) {}
                                   }
                              )
                              

                             
                           } // tab bar
                           .padding()
                           .background(Color(red: 0.01332890149, green: 0.04810451716, blue:  0.1187042817))
                           .clipShape(Capsule())
                           .frame(maxWidth: 250)
                           .padding(.horizontal)
                           .shadow(color: Color.black.opacity(0.9), radius: 8, x: 2, y: 6)
                           .frame(maxHeight: .infinity, alignment: .bottom)
                       }
                     
                   }
            }
        }
    }
    
   
    
    var games = [HomeData(id: 0, image: "XO", name: "Tic Tac Toe", description: ""),
                HomeData(id: 1, image: "snakeandladder", name: "snake and ladder", description: ""),
                HomeData(id: 3, image: "puzzle", name: "puzzle", description: "")]
    
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


struct HomeData : Identifiable{
    let id : Int
    let image : String
    let name : String
    let description : String
}

struct ButtonTabBar: View {
    let image : Image
    let action : () -> Void
    var body: some View {
        HStack{
            image
                .resizable()
                .frame(width: 27, height: 23)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                
        }
    }
}

struct GamesView : View {
    var gamesData : HomeData
    var body: some View {
        HStack {
            Image(self.gamesData.image)
                .resizable()
                .frame(width: 130,height: 130)
            Spacer()
        }
    }
}
