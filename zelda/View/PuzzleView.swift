//
//  PuzzleView.swift
//  zelda
//
//  Created by H . on 24/06/1444 AH.
//

import SwiftUI

struct PuzzleView: View {
    @ObservedObject var puzzelVM = PuzzleViewModel()
    @State private var gameOver = false
    

    var body: some View {
        ZStack{
            ZStack(alignment: .bottomTrailing){
                
                VStack{
                    
                    HStack(alignment: .center){
                        Text(" Puzzle Game ")
                            .font(.system(size: 35))
                            .monospaced()
                            .bold()
                            .foregroundColor(Color.white)
                        Image("puzzle")
                            .resizable()
                            .frame(width: 80, height: 80)
                    }
                    .padding(10)
                    .background(Color(red: 21/255, green: 50/255, blue: 89/255))
                    .cornerRadius(40)
                    
                    
                    
                    LazyVGrid(columns : [GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80)), GridItem(.fixed(80))]){
                        ForEach(puzzelVM.puzzles){ puzzle in
                            CartView(num: puzzle.content, id: puzzle.id)
                                .cornerRadius(10)
                            //                .background(puzzelVM.puzzleModel.currentState Color.green : Color.black)
                            
                                .onTapGesture{
                                    withAnimation{
                                        puzzelVM.selected(selectedPuzzle: puzzle)
                                        puzzelVM.puzzleModel.puzzleSign()
                                        //                        print(" current state \(puzzelVM.puzzleModel.currentState)")
                                        gameOver = puzzelVM.puzzleModel.isGameOver
                                        
                                    }
                                }
                        }
                    }
                    .padding(60)
                    newGameButton
                }.frame(width: UIScreen.main.bounds.width , height: UIScreen.main.bounds.height)
                    .background(Image("background") .resizable() .scaledToFill()
                        .edgesIgnoringSafeArea([.top , .bottom , .leading , .trailing]) )
                
                Image("1")
                    .resizable()
                    .frame(width: 120 , height: 180)
                    .padding(.trailing , 20)
                    .padding(.bottom , 20)
            }
            
            if self.gameOver {
                Rectangle()
                    .fill(Color.white)
                    .frame(width: 320, height: 300)
                    .cornerRadius(20)
                    .overlay(
                        VStack(spacing: 10){
                            Text("You Are Genius!")
                                .font(.largeTitle)
                                .foregroundColor(Color.black)
                            //  .padding(.bottom,110)
                            Image("winCharacter")
                                .resizable()
                                .frame(width: 70, height: 100)
                            HStack(spacing: 0){
                                Text("You got 20")
                                    .foregroundColor(Color.black)
                                Image("red")
                                    .resizable()
                                    .frame(width: 25, height: 25)
                            }
                            
                            
                            //edit score on firebase
                            HStack(spacing: 20){
                                Rectangle()
                                    .fill(Color(red: 12/255, green: 35/255, blue: 66/255))
                                    .cornerRadius(15)
                                    .frame(width: 120, height: 48)
                                    .overlay(
                                        Text("New Game")
                                            .font(.system(size: 13).bold())
                                            .foregroundColor(Color.white)
                                    ).onTapGesture {
                                        AppState.shared.gameID = UUID()
                                    }
                                
                                NavigationLink {
                                    HomeView()
                                } label: {
                                    Rectangle()
                                        .fill(Color(red: 12/255, green: 35/255, blue: 66/255))
                                        .cornerRadius(15)
                                        .frame(width: 120, height: 48)
                                        .overlay(
                                            Text("Home")
                                                .font(.system(size: 13).bold())
                                                .foregroundColor(Color.white)
                                        )
                                        .navigationBarBackButtonHidden(true)
                                        .statusBar(hidden: true)
                                }
                                
                            }
                            .padding(.top)
                            
                        }).onAppear(){
                            DBModel.shared.updateJewelry(id: DBModel.curentUserID, score: 20, operation: "+", image: "")
                        }
                    .shadow(radius: 20)
                   // .padding(.bottom, 700)
            }
        }

    }
    
    var newGameButton : some View {
        Button{
            withAnimation{
                puzzelVM.newGame()
            }
           
        }label:{
        Text("Repeat Game")
        .padding()
        .frame(width:150, height: 30 , alignment:.center)
        .background(Color.gray.opacity(0.4))
        .foregroundColor(Color.white)
        .monospaced()
        .cornerRadius(8)
            }
    }

}



struct CartView : View {
    var num : String
    var id : Int
    
    var body : some View {
        ZStack{
        if (id != 0){
            
                Rectangle()
                    .stroke(lineWidth: 0)
                    
                Text(num)
                .font(.largeTitle)
                .foregroundColor(.white)
                .fontWeight(.bold)
                .padding()
            }
        } .background(Color(red: 21/255, green: 50/255, blue: 89/255))
    }
}

/*struct GameOverView : View{

    @Binding var coinsCount : Int
    var body: some View{
        GeometryReader{
            geometry in
            ZStack{
                Image("background")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)

                VStack(alignment:.center){
                    Text("GameOver , 10 Coins added \n\n\nYour Coins now : \(coinsCount)")
                        .padding(40)
                        .background(Color(red: 21/255, green: 50/255, blue: 89/255))
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .monospaced()
                }
                .cornerRadius(40)
            }
        }
    }
}*/

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}

