//
//  ContentView.swift
//  Jankenpon
//
//  Created by Alex Bùi on 13/05/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var appsChoice = "Paper"
    @State private var shouldWin = false
    @State private var questionCounter = 0
    @State private var score = 0
    @State private var scoreTitle = ""
    
    @State private var showingAlert = false
    @State private var showingScore = false
    @State private var showingTotalScore = false
    
    let moves = ["Rock", "Paper", "Scissors"]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.purple, .mint]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("My Move is " + "\(appsChoice.uppercased())")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack (spacing: 15) {
                    VStack {
                        Text("You must")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text("\(shouldWin ? "WIN" : "LOSE")")
                            .font(.largeTitle.weight(.semibold))
                            .foregroundColor(.primary)
                    }
                
                    Button {
                        rockIsSelected()
                    } label: {
                        Text("✊")
                            .font(.largeTitle)
                    }
                    .buttonDesign()
                
                    Button {
                        paperIsSelected()
                    } label: {
                        Text("✋")
                            .font(.largeTitle)
                    }
                    .buttonDesign()
                
                    Button {
                        scissorsIsSelected()
                    } label: {
                        Text("✌️")
                            .font(.largeTitle)
                    }
                    .buttonDesign()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 25))
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: nextRound)
        } message: {
            Text("Your score is \(score)")
        }
        
        .alert(scoreTitle, isPresented: $showingTotalScore) {
            Button("Reset", action: reset)
        } message: {
            Text("Game Over! Your total score is \(score)")
        }
    }
    
    func nextRound() {
        appsChoice = moves[Int.random(in: 0...2)]
        shouldWin = Bool.random()
        questionCounter += 1
    }
    
    func rockIsSelected() {
        if appsChoice == moves[2] && shouldWin || appsChoice == moves[1] && !shouldWin {
            score += 1
        } else {
            score -= 1
        }
        
        showingScore = true
        if questionCounter == 10 {
            showingScore = false
            showingTotalScore = true
        }
    }
    
    func paperIsSelected() {
        if appsChoice == moves[0] && shouldWin || appsChoice == moves[2] && !shouldWin {
            score += 1
        } else {
            score -= 1
        }
        
        showingScore = true
        if questionCounter == 10 {
            showingScore = false
            showingTotalScore = true
        }
    }
    
    func scissorsIsSelected() {
        if appsChoice == moves[1] && shouldWin || appsChoice == moves[0] && !shouldWin {
            score += 1
        } else {
            score -= 1
        }
        
        showingScore = true
        if questionCounter == 10 {
            showingScore = false
            showingTotalScore = true
        }
    }

    func reset() {
            questionCounter = 0
            score = 0
            nextRound()
    }
}

struct ButtonDesign: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(width: 100, height: 100, alignment: .center)
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .background(.primary)
            .cornerRadius(15)
    }
}

extension View {
    func buttonDesign() -> some View {
        modifier(ButtonDesign())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
