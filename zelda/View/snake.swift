//
//  snake.swift
//  zelda
//
//  Created by admin on 1/16/23.
//

import SwiftUI


struct snake: View {
    //MARK: - Constaint
    enum direction {
        case up, down, left, right
    }
    let minX = UIScreen.main.bounds.minX + 45
    let maxX = UIScreen.main.bounds.maxX - 43
    let minY = UIScreen.main.bounds.minY + 108
    let maxY = UIScreen.main.bounds.maxY - 80
    let snakeSize:CGFloat = 12
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

    //MARK: - Vars
    @State var startPos:CGPoint = .zero
    @State var isStarted = true
    @State var gameOver = false
    @State var dir = direction.down
    @State var posArray = [CGPoint(x: 0, y: 0)]
    @State var foodPos = CGPoint(x: 0, y: 0)
    

    //MARK: - View
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .ignoresSafeArea()
            ZStack{
                Rectangle()
                    .foregroundColor(Color(red: 213/255, green: 213/255, blue: 245/255))
                    .cornerRadius(20)
                    .padding(.top, UIScreen.main.bounds.minY + 80)
                    .padding(.bottom, UIScreen.main.bounds.maxY - 800)
                    .padding(.leading, UIScreen.main.bounds.minX + 23)
                    .padding(.trailing, UIScreen.main.bounds.maxX - 370)
            }
            .cornerRadius(30)
            
            ZStack{
                ForEach(0..<posArray.count, id:\.self){ index in
                    //snake
                    Rectangle()
                        .frame(width: self.snakeSize,height: self.snakeSize)
                        .position(self.posArray[index])
                }
                Rectangle()
                    .fill(Color.red)
                    .frame(width: snakeSize, height: snakeSize)
                    .position(foodPos)
            }
            
            if self.gameOver {
                VStack(spacing: 10){
                    Text("Game Over")
                        .font(.largeTitle)
                    Text("Score: \(posArray.count-1)")
                    //edit score on firebase
                    Button(action:{AppState.shared.gameID = UUID()}){
                        Text("New Game")
                    }
                    //add button to go back home
                }
            }
        
                }.onAppear(){
                    self.foodPos = changeRecPosition()
                    self.posArray[0] = changeRecPosition()
                }
                .gesture(DragGesture()
                    .onChanged{ gesture in
                        if self.isStarted{
                            self.startPos = gesture.location
                            self.isStarted.toggle()
                        }
                    }
                    .onEnded{ gesture in
                        let xDist = abs(gesture.location.x - self.startPos.x)
                        let yDist = abs(gesture.location.y - self.startPos.y)
                        
                        if self.startPos.y < gesture.location.y && yDist > xDist{
                            self.dir = direction.down
                        } else if self.startPos.y > gesture.location.y && yDist > xDist{
                            self.dir = direction.up
                        } else if self.startPos.x > gesture.location.x && yDist < xDist{
                            self.dir = direction.right
                        } else if self.startPos.x < gesture.location.x && yDist < xDist{
                            self.dir = direction.left
                        }
                        self.isStarted.toggle()
                    }
                )
                .onReceive(timer){ (_) in
                    if !self.gameOver{
                        self.changeDirection()
                        if self.posArray[0] == self.foodPos {
                            self.posArray.append(self.posArray[0])
                            self.foodPos = self.changeRecPosition()
                        }
                    }
                }
                .edgesIgnoringSafeArea(.all)
           
    }
    
    func changeDirection(){
        var prev = posArray[0]
        
        if self.posArray[0].x < minX || self.posArray[0].x > maxX && !gameOver{
            gameOver.toggle()
        } else if self.posArray[0].y < minY || self.posArray[0].y > maxY && !gameOver{
            gameOver.toggle()
        }
        
        if dir == .down {
            self.posArray[0].y += snakeSize
        } else if dir == .up {
            self.posArray[0].y -= snakeSize
        } else if dir == .left {
            self.posArray[0].x += snakeSize
        } else {
            self.posArray[0].x -= snakeSize
        }
        
        for index in 1..<posArray.count {
            let current = posArray[index]
            posArray[index] = prev
            prev = current
        }
        
    }
    
    func changeRecPosition() -> CGPoint{
        let rows = Int(maxX / snakeSize)
        
        let columns = Int(maxY / snakeSize)
        
        var randomX = Int.random(in: 1..<rows) * Int(snakeSize)
        var randomY = Int.random(in: 1..<columns) * Int(snakeSize)
        let Xmax = Int(maxX)
        let Xmin = Int(minX)
        let Ymax = Int(maxY)
        let Ymin = Int(minY)
        if randomX > Xmax {
            randomX -= Xmax
        } else if randomX < Xmin {
            randomX += Xmin
        }
        if randomY > Ymax{
            randomY -= Ymax
        } else if randomY < Ymin{
            randomY += Ymin
        }
        return CGPoint(x: randomX, y: randomY)
        
    }
}

struct snake_Previews: PreviewProvider {
    static var previews: some View {
        snake()
        
    }
}