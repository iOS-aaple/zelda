//
//  HomeView.swift
//  zelda
//
//  Created by Munira on 14/01/2023.
//

import SwiftUI

struct HomeView: View {
    @State var userJewerly = 0
    var body: some View {
        Home(userJewerly: $userJewerly ).onAppear(){
            fetchJewerly()
        }
    }
    
    func fetchJewerly(){
        DBModel.shared.getUserInfo(id: DBModel.curentUserID) { user in
            userJewerly = user.jewelry
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
      }
    }

struct Home: View {
    @Binding var userJewerly: Int

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
                            HStack{
                                Button(action : {
                                    
                                }) {
                                    Image("red")
                                        .resizable()
                                        .font(.title)
                                        .foregroundColor(.white)
                                        .frame(width: 20, height: 20)
                                    
                                }
                                Text("\(userJewerly)")
                                    .font(.system(size: 15))
                                    .foregroundColor(Color(red: 0.01332890149, green: 0.04810451716, blue:  0.1187042817))
                                
                            }
                            .padding(.trailing)
                            .background(Color(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393))
                            .cornerRadius(10)
                        } // head view
                        .padding(.horizontal)
                        .padding(.top)
                        
                        // for side bar and the details
                        ScrollView(.vertical, showsIndicators: false){
                            VStack(spacing: 20){
                                ForEach(games) { i in
                                    //                                       GamesCards(gamesData: i)
                                }
                                XO()
                                ThePuzzle()
                                Snake()
                                UniverseMemory()
                                    .padding(.bottom, -50)
                            }
                        }
                        .padding(.bottom, -400)
                        
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
                                    StoreView().navigationBarBackButtonHidden(true)
                                , label : {
                                    ButtonTabBar(image: Image("shop")) {}
                                }
                            )
                            NavigationLink (
                                destination :
                                    AccountView().navigationBarBackButtonHidden(true)
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
                    //                       .edgesIgnoringSafeArea(.bottom)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct XO : View {
    var body: some View {
        HStack {
            HStack{
                Image("XO")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 4)
                    .frame(width: 50, height: 100)
                Spacer()
            } .padding(.leading, 20)
            
            Text("Tic Tac Toe")
                .multilineTextAlignment(.center)
                .font(.system(size: 25, design: .monospaced))
                .frame(maxWidth: 200)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.9), radius: 8, x: 2, y: 6)
                .padding(.leading, -26)
            VStack(spacing: 20){
                Spacer(minLength: 0)
                HStack{
                    NavigationLink(destination:  Moves()) {
                        Text("Play")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 25)
                            .background(Capsule().stroke(Color.white, lineWidth: 2))
                    }
                    .offset(x: -20, y: -50)
                }
                
               
            }
        }
        .frame(height: 200)
        .background(
            Color.white.opacity(0.2)
                .cornerRadius(25)
            
                .rotation3DEffect(.init(degrees: 10), axis : (x:0, y: -1, z: 0))
            // trim view
                .padding(.vertical, 50)
                .padding(.trailing, 25)
            )
        .padding(.horizontal)
        .padding(.bottom, -90)
    }
}
struct ThePuzzle : View {
    var body: some View {
        HStack {
            HStack{
                Image("puzzle")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 4)
                    .frame(width: 60, height: 100)
                Spacer()
            } .padding(.leading, 20)
            
            Text("Puzzle")
                .multilineTextAlignment(.center)
                .font(.system(size: 25, design: .monospaced))
                .frame(maxWidth: 200)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.9), radius: 8, x: 2, y: 6)
                .padding(.leading, -26)
            VStack(spacing: 20){
                Spacer(minLength: 0)
                HStack{
                    NavigationLink(destination: PuzzleView()) {
                        Text("Play")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 25)
                            .background(Capsule().stroke(Color.white, lineWidth: 2))
                    }
                    .offset(x: -20, y: -50)
                }
                
               
            }
        }
        .frame(height: 200)
        .background(
            Color.white.opacity(0.2)
                .cornerRadius(25)
            
                .rotation3DEffect(.init(degrees: 10), axis : (x:0, y: -1, z: 0))
            // trim view
                .padding(.vertical, 50)
                .padding(.trailing, 25)
            )
        .padding(.horizontal)
        .padding(.bottom, -90)
    }
}
struct Snake : View {
    @StateObject var appState = AppState.shared
    var body: some View {
        
        HStack {
            HStack{
                Image("snake")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 3)
                    .frame(width: 180, height: 160)
                    .rotation3DEffect(.init(degrees: 180), axis : (x:0, y: -1, z: 0))
                Spacer()
            } .padding(.leading, -50)
            
            Text("Snake")
                .multilineTextAlignment(.center)
                .font(.system(size: 25, design: .monospaced))
                .frame(maxWidth: 200)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.9), radius: 8, x: 2, y: 6)
                .padding(.leading, -26)
            VStack(spacing: 20){
                Spacer(minLength: 0)
                HStack{
                    NavigationLink(destination: snake().id(appState.gameID)) {
                        Text("Play")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 25)
                            .background(Capsule().stroke(Color.white, lineWidth: 2))
                    }
                    .offset(x: -20, y: -50)
                }
                
               
            }
        }
        .frame(height: 200)
        .background(
            Color.white.opacity(0.2)
                .cornerRadius(25)
            
                .rotation3DEffect(.init(degrees: 10), axis : (x:0, y: -1, z: 0))
            // trim view
                .padding(.vertical, 50)
                .padding(.trailing, 25)
            )
        .padding(.horizontal)
        .padding(.bottom, -90)
    }
}
struct UniverseMemory : View {
//    var gamesData : HomeData
//    let image : Image
    var body: some View {
        HStack {
            HStack{
                Image("universe")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width / 3)
                    .frame(width: 50, height: 80)
                Spacer()
            } .padding(.leading, 20)
            
            Text("Universe Memory")
                .multilineTextAlignment(.center)
                .font(.system(size: 25, design: .monospaced))
                .frame(maxWidth: 200)
                .padding(.horizontal)
                .shadow(color: Color.black.opacity(0.9), radius: 8, x: 2, y: 6)
                .padding(.leading, -26)
            VStack(spacing: 20){
                Spacer(minLength: 0)
                HStack{
                    NavigationLink(destination:  MemoryGameView()) {
                        Text("Play")
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 25)
                            .background(Capsule().stroke(Color.white, lineWidth: 2))
                    }
                    .offset(x: -20, y: -50)
                }
                
               
            }
        }
        .frame(height: 200)
        .background(
            Color.white.opacity(0.2)
                .cornerRadius(25)
            
                .rotation3DEffect(.init(degrees: 10), axis : (x:0, y: -1, z: 0))
            // trim view
                .padding(.vertical, 50)
                .padding(.trailing, 25)
            )
        .padding(.horizontal)
        .padding(.bottom, -90)
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


var games = [HomeData(id: 0, image: "XO", name: "XO", description: ""),
            HomeData(id: 1, image: "snake", name: "Snake", description: ""),
            HomeData(id: 3, image: "puzzle", name: "Puzzle", description: ""),
            HomeData(id: 4, image: "", name: "Universe Memory", description: "")]
