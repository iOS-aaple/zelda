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
    
    @State var coinsCount = 0
    
    var body: some View {
        
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
                            
                            if gameOver == true {
                                coinsCount += 10
                                print("\(coinsCount)")
                            }
                        }
                    }.sheet(isPresented: $gameOver){
                        GameOverView(coinsCount: $coinsCount)


                        
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

struct GameOverView : View{

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
}

struct PuzzleView_Previews: PreviewProvider {
    static var previews: some View {
        PuzzleView()
    }
}

