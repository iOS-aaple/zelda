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
    
    @State var cards = createCardList().shuffled()
    @State var matchedCards = [GameCard]()
    @State var userChoices = [GameCard]()
    
    var body: some View {
            GeometryReader { geo in
                Image("background")
                    .resizable()
                    .ignoresSafeArea()
                    .overlay(
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
                        VStack{
                            Text("Match thesr cards to win:")
                                .foregroundColor(.white)
                                .font(.title3.monospaced().bold())
                            
                            LazyVGrid(columns: sixColumnGrid, spacing: 5) {
                                ForEach(cardValues, id:\.self){ cardValue in
                                    if cardValues.count == 0{
                                        //alert to end of the game
                                    }
                                    if !matchedCards.contains(where: {$0.text == cardValue}){
                                        Image(cardValue)
                                            .resizable()
                                            .frame(width: geo.size.width/6 - 30 ,height: geo.size.width/6 - 30)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                        .padding(.horizontal)
                    )
                }
    }
}

struct MemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        MemoryGameView()
    }
}

