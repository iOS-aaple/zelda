//
//  MemoryGameView.swift
//  zelda
//
//  Created by admin on 1/16/23.
//

import SwiftUI

struct MemoryGameView: View {
    private var fourColumnGrid = [GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible())]
    
    private var sixColumnGrid = [GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible()),
                                  GridItem(.flexible())]
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    @State var cards = createCardList().shuffled()
    @State var matchedCards = [GameCard]()
    @State var userChoices = [GameCard]()
    @State var isGameOver = false
    
    var body: some View {
            GeometryReader { geo in
                        ZStack{
                            Image("background")
                                .resizable()
                                .ignoresSafeArea()
                            
                            VStack{
                                Text("Universe Memory")
                                    .foregroundColor(.white)
                                    .font(.largeTitle.monospaced().bold())
                                
                                LazyVGrid(columns: fourColumnGrid, spacing: 20){
                                    ForEach (cards){ card in
                                        CardView(card: card,
                                                 width: Int(geo.size.width/4 - 20),
                                                 matchedCards: $matchedCards,
                                                 userChoices: $userChoices)
                                    }
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 790)
                            
                            Text("Match these cards to win:")
                                .foregroundColor(.white)
                                .font(.title3.monospaced().bold())
                                .padding(.bottom, 98)
                            VStack{
                                    LazyVGrid(columns: sixColumnGrid, spacing: 5){
                                        ForEach(cardValues, id:\.self){ cardValue in
                                            if !matchedCards.contains(where: {$0.text == cardValue}){
                                                Image(cardValue)
                                                    .resizable()
                                                    .frame(width: geo.size.width/6 - 30 ,height: geo.size.width/6 - 30)
                                            }
                                        }
                                    }
                                }
                                .padding(.top, 40)
                                .padding(.horizontal)
                            
                            //handel end of the game option
                            if self.isGameOver {
                                Rectangle()
                                    .fill(Color.white)
                                    .frame(width: 200, height: 200)
                                    .overlay(
                                VStack(spacing: 10){
                                    Text("Game Over")
                                        .font(.largeTitle)
                                        .foregroundColor(Color.black)
                                    
                                    //edit score on firebase
                                    Button(action:{AppState.shared.gameID = UUID()}){
                                        Text("New Game")
                                    }
                                    //add button to go back home
                                })
                            }
                        }
            }.onReceive(timer) { (_) in
                gameOver()
            }
           }
    func gameOver(){
        if matchedCards.count == 24{
            isGameOver = true
            //alert to end of the game
            
        }
    }
    }

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView()
    }
}

