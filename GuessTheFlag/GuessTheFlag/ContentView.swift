//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Johnny Huynh on 6/6/22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var showScoreboard = false
    @State private var scoreTitle = ""
    @State private var scoreboard = ""
    @State private var score = 0
    @State private var limit = 0
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                        .font(.subheadline.weight(.heavy))
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0..<3) { number in
                    Button {
                        //Flag was tapped
                        if (limit < 7) {
                            flagTapped(number)
                        }else{
                            endGameScoreboard(number)
                        }
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .shadow(radius: 5)
                    }
                }
            }
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)/\(limit)")
        }
        .alert(scoreboard, isPresented: $showScoreboard) {
            Button("Reset", action: reset)
        } message: {
            Text("Your score is \(score)/\(limit)")
        }
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            limit += 1
        } else {
            scoreTitle = "Wrong, silly! You clicked \(countries[number])"
            limit += 1
        }
        
        showingScore = true
    }
    
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func endGameScoreboard(_ number: Int) {
        if (limit == 7) {
            if number == correctAnswer {
                scoreboard = "Correct. Game Finished!"
            } else {
                scoreboard = "Wrong, silly! You clicked \(countries[number]). Game Finished!"
            }
            
            showScoreboard = true
        }
    }
    
    func reset() {
        //Reset flags
        askQuestion()
        
        //Initalize values
        showingScore = false
        showScoreboard = false
        scoreTitle = ""
        score = 0
        limit = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
