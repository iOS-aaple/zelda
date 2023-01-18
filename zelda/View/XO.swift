//
//  XO.swift
//  zelda
//
//  Created by Munira on 17/01/2023.
//

import SwiftUI

struct XOgame: View {
    var body: some View {
        XOButton(letter: .constant("X"))
    }
}
struct XOButton : View {
    @Binding var letter : String
    @State private var degree = 0.0
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("")
                    .resizable()
                    .aspectRatio(geometry.size, contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                ZStack{
                    Circle()
                        .frame(width: 120,height: 120)
                        .foregroundColor(Color(red: 65/255, green: 67/255, blue: 125/255))
                    Circle()
                        .frame(width: 100,height: 100)
                        .foregroundColor(Color(red: 213/255, green: 213/255, blue: 245/255))
                    Text(letter)
                        .font(.system(size: 50)).monospaced()
                        .bold()
                        .foregroundColor(Color(red: 0.01332890149, green: 0.04810451716, blue:  0.1187042817))
                }
                .rotation3DEffect(.degrees(degree), axis: (x: 0, y: 1, z: 0))
                .simultaneousGesture(TapGesture()
                    .onEnded{ _ in
                        withAnimation(.easeIn(duration: 0.25)) {
                            self.degree -= 180
                        }
                    
                })
            }
        }
    }
}
struct Moves : View {
    @State var moves = ["","","","","","","","",""]
    @State var endGame = "Tic Tac Toe"
    @State var gameEnded = false
    @State var score : Int
    var ranges = [(0..<3),(3..<6),(6..<9)]
    var body: some View {
        NavigationView{
            GeometryReader { geometry in
                ZStack {
                    Image("background")
                        .resizable()
                        .aspectRatio(geometry.size, contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        HStack {
                            Button(action : {
                                
                            }) {
                                Image("red")
                                    .resizable()
                                    .font(.title)
                                    .foregroundColor(.white)
                                    .frame(width: 20, height: 20)
                                
                            }
                            Text("\(score)")
                                .foregroundColor(Color(red: 0.01332890149, green: 0.04810451716, blue:  0.1187042817))
                        }
                        .padding(.trailing)
                        .background(Color(red: 0.8374180198, green: 0.8374378085, blue: 0.8374271393))
                        .cornerRadius(10)
                        .padding(.leading, 270)
                        Text("")
                            .alert(endGame, isPresented: $gameEnded){
                                Button( "Reset", role: .destructive, action: resetGame)
                            }
                        Spacer()
                            .padding()
                        Text("Tic Tac Toe")
                            .foregroundColor(.white)
                            .font(.largeTitle.monospaced().bold())
                        Spacer()
                        //                        .padding(.top)
                        ForEach(ranges, id: \.self) { range in
                            HStack{
                                ForEach(range, id: \.self) { i in
                                    XOButton(letter: $moves[i])
                                    //                                    .frame(width: 120,height: 320)
                                        .simultaneousGesture(TapGesture()
                                            .onEnded { _ in
                                                PlayerTap(index:i)
                                            })
                                }
                            }
                        }
                        //                    .padding(.top, -200)
                        Spacer()
                        HStack{
                            Button(action: resetGame, label: {
                                Text("Reset")
                                    .font(.system(size: 15))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 25)
                                    .background(Capsule().stroke(Color.white, lineWidth: 2))
                                
                            })
                            NavigationLink(destination: HomeView(score: score)) {
                                Text("Home")
                                    .font(.system(size: 15))
                                    .foregroundColor(.white)
                                    .padding(.vertical, 12)
                                    .padding(.horizontal, 25)
                                    .background(Capsule().stroke(Color.white, lineWidth: 2))
                                
                            }
                        }
                        
                    }
                }
            }
        }
    }
    func resetGame(){
        endGame = "Tic Tac Toe"
        moves = ["","","","","","","","",""]
    }
    func PlayerTap(index: Int){
        if moves[index] == "" {
            moves[index] = "X"
            btnMove()
        }
        for letter in ["X", "O"] {
            if checkWinner(list: moves, letter: letter) {
                endGame = "\(letter) has won!"
                gameEnded = true
                if letter == "X" {
                    score += 100
                }
                break
            }
        }
    }
    func btnMove(){
        var availbleMoves : [Int] = []
        var mpvesLeft = 0
        for move in moves {
            if move == "" {
                availbleMoves.append(mpvesLeft)
            }
            mpvesLeft += 1
        }
        if availbleMoves.count != 0 {
            moves[availbleMoves.randomElement()!] = "O"
        }
    }
}
func checkWinner(list: [String], letter: String) -> Bool{
    let winningSequences = [
    [0,1,2] , [3,4,5], [6,7,8],
    [0,4,8] , [2,4,6],
    [0,3,6] , [1,4,7], [2,5,8]
    ]
    for sequence in winningSequences {
        var score = 0
        for match in sequence {
            if list[match] == letter {
                score += 1
                if score == 3 {
                    return true
                }
            }
        }
    }
    return false
}

struct XO_Previews: PreviewProvider {
    static var previews: some View {
        Moves(score: Int())
    }
}
