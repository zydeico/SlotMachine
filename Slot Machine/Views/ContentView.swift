//
//  ContentView.swift
//  Slot Machine
//
//  Created by Daniel Vázquez on 26/05/20.
//  Copyright © 2020 Daniel Vázquez. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    // Images array
    let symbols = ["gfx-bell", "gfx-cherry", "gfx-coin", "gfx-grape", "gfx-seven", "gfx-strawberry"]
    let haptics = UINotificationFeedbackGenerator()
    
    // MARK: - Properties
    @State private var showingInfoView: Bool = false
    @State private var reels: Array = [0, 1, 2]
    @State private var highscore: Int = UserDefaults.standard.integer(forKey: "HighScore")
    @State private var coins: Int = 100
    @State private var betAmount: Int = 10
    @State private var isActiveBet10: Bool = true
    @State private var isActiveBet20: Bool = false
    @State private var showingModal: Bool = false
    @State private var animatingSymbol: Bool = false
    @State private var animatingModal: Bool = false
    
    // MARK: - Functions
    // Spin the reels
    func spinReels() {
        reels = reels.map({ _ in
            Int.random(in: 0...symbols.count - 1)
        })
        playSound(sound: "spin", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    // MARK: - Check if user win
    
    func checkWining() {
        if reels[0] == reels[1] && reels[1] == reels[2] && reels[0] == reels[2] {
            // Player Wins
            playerWins()
            // New HighScore
            if coins > highscore {
                newHighScore()
            } else {
                playSound(sound: "win", type: "mp3")
            }
        } else {
            // Player loses!
            playerLoses()
        }
    }
    
    // MARK: - Player Wins
    func playerWins() {
        coins += betAmount * 10
    }
    
    // MARK: - NewHighscore
    func newHighScore() {
        highscore = coins
        // Adding functionality for save the data locally
        UserDefaults.standard.set(highscore, forKey: "HighScore")
        playSound(sound: "high-score", type: "mp3")
    }
    
    // MARK: - Player Loses
    func playerLoses() {
        coins -= betAmount
    }
    
    // MARK: - ActivateBeta20
    func activateBet20() {
        betAmount = 20
        isActiveBet20 = true
        isActiveBet10 = false
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    // MARK: - ActivateBeta10
    func activateBet10() {
        betAmount = 10
        isActiveBet10 = true
        isActiveBet20 = false
        playSound(sound: "casino-chips", type: "mp3")
        haptics.notificationOccurred(.success)
    }
    
    // MARK: - Game Over
    func isGameOver() {
        if coins <= 0 {
            showingModal = true
            playSound(sound: "game-over", type: "mp3")
        }
    }
    
    // MARK: - Reset Game
    func resetGame() {
        UserDefaults.standard.set(0, forKey: "HighScore")
        highscore = 0
        coins = 100
        activateBet10()
        playSound(sound: "chimeup", type: "mp3")
    }
        
    // MARK: BODY
    var body: some View {
        ZStack {
            // MARK: - Background
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - Interface
            
            VStack(alignment: .center, spacing: 5) {
                
                // MARK: Header
                LogoView()
                
                Spacer()
                
                // MARK: - Score
                HStack {
                    HStack {
                        Text("Your\ncoins")
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(coins)")
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                    }
                        // Adding reuzable code
                        .modifier(ScoreContainerModifier())
                    
                    // Adding spacer
                    Spacer()
                    
                    // Second HStack
                    HStack {
                        Text("200")
                            // Adding reuzable code
                            .scoreNumberStyle()
                            .modifier(ScoreNumberModifier())
                        
                        Text("High\nScore".uppercased())
                            // Adding reuzable code
                            .scoreLabelStyle()
                            .multilineTextAlignment(.leading)
                    }
                        // Adding reuzable code
                        .modifier(ScoreContainerModifier())
                }
                
                // MARK: - Slot Machine
                VStack(alignment: .center, spacing: 0) {
                    
                    // MARK: - REEL #1
                    ZStack {
                        ReelView()
                        Image(symbols[reels[0]])
                            .resizable()
                            .modifier(ImageModifier())
                            .opacity(animatingSymbol ? 1 : 0)
                            .offset(y: animatingSymbol ? 0 : -50)
                            .animation(.easeOut(duration: Double.random(in: 0.5...0.7)))
                            .onAppear(perform: {
                                self.animatingSymbol.toggle()
                                playSound(sound: "riseup", type: "mp3")
                            })
                    }
                    
                    // MARK: - REELS
                    HStack(alignment: .center, spacing: 0) {
                        
                        // MARK: - REEL #2
                        ZStack {
                            ReelView()
                            Image(symbols[reels[1]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                        
                        Spacer()
                        
                        // MARK: - REEL # 3
                        ZStack {
                            ReelView()
                            Image(symbols[reels[2]])
                                .resizable()
                                .modifier(ImageModifier())
                                .opacity(animatingSymbol ? 1 : 0)
                                .offset(y: animatingSymbol ? 0 : -50)
                                .animation(.easeOut(duration: Double.random(in: 0.9...1.1)))
                                .onAppear(perform: {
                                    self.animatingSymbol.toggle()
                                })
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: - Spin Button
                    Button(action: {
                        // 1. Set the default State: No animation
                        withAnimation {
                            self.animatingSymbol = false
                        }
                        
                        // 2. Spin the reels with changing the symbols
                        self.spinReels()
                        
                        // 3. Trigger the animation after changing the symbols
                        withAnimation {
                            self.animatingSymbol = true
                        }
                        
                        // 4. Check Wining
                        self.checkWining()
                        
                        // 5. Game is Over
                        self.isGameOver()
                    }) {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }
                .layoutPriority(2)
                
                // MARK: - Footer
                Spacer()
                HStack {
                    // MARK: - BET 20
                    HStack(alignment: .center
                    , spacing: 10) {
                        Button(action: {
                            self.activateBet20()
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet20 ? Color("ColorYellow") : Color.white)
                                .modifier(BetNumberModifier())
                        }
                            // Adding aspect modifier
                            .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet20 ? 0 : 20)
                            .opacity(isActiveBet20 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    Spacer()
                    
                    // MARK: - BET 10
                    HStack(alignment: .center
                    , spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .offset(x: isActiveBet10 ? 0 : -20)
                            .opacity(isActiveBet10 ? 1 : 0)
                            .modifier(CasinoChipsModifier())
                        // Second Button
                        Button(action: {
                            self.activateBet10()
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(isActiveBet10 ? Color("ColorYellow") : Color.white)
                                .modifier(BetNumberModifier())
                        }
                            // Adding aspect modifier
                            .modifier(BetCapsuleModifier())
                    }
                }
            }
                // MARK: - Buttons
                .overlay(
                    // Reset
                    Button(action: {
                        self.resetGame()
                    }) {
                        Image(systemName: "arrow.2.circlepath.circle")
                    }
                    .modifier(ButtonModifier()), alignment: .topLeading
            )
                .overlay(
                    // Info
                    Button(action: {
                        self.showingInfoView = true
                    }) {
                        Image(systemName: "info.circle")
                    }
                    .modifier(ButtonModifier()), alignment: .topTrailing
            )
                .padding()
                .frame(maxWidth: 720)
                
                // MARK: - Blur efect
                .blur(radius: $showingModal.wrappedValue ? 5 : 0, opaque: false)
            
            // MARK: - Pop Up
            if $showingModal.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    // Modal
                    VStack(spacing: 0) {
                        // Title
                        Text("Game Over")
                            .font(.system(.title, design: .rounded))
                            .fontWeight(.heavy)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("ColorPink"))
                            .foregroundColor(Color.white)
                        
                        Spacer()
                        
                        VStack(alignment: .center
                        , spacing: 16) {
                            Image("gfx-seven-reel")
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 72)
                            Text("Bad luck! You lost all of the coins. \nLet's play again!")
                                .font(.system(.body, design: .rounded))
                                .lineLimit(2)
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color.gray)
                                .layoutPriority(1)
                            
                            Button(action: {
                                self.showingModal = false
                                self.animatingModal = false
                                self.activateBet10()
                                self.coins = 100
                            }) {
                                Text("New Game".uppercased())
                                    .font(.system(.body, design: .rounded))
                                    .fontWeight(.semibold)
                                    .accentColor(Color("ColorPink"))
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .frame(minWidth: 128)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorPink"))
                                )
                            }
                        }
                        Spacer()
                    }
                    .frame(minWidth: 280, idealWidth: 280, maxWidth: 320, minHeight: 260, idealHeight: 280, maxHeight: 320, alignment: .center)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 6, x: 0, y: 8)
                    .opacity($animatingModal.wrappedValue ? 1 : 0)
                    .offset(y: $animatingModal.wrappedValue ? 0 : -100)
                    .animation(Animation.spring(response: 0.6, dampingFraction: 1.0, blendDuration: 1.0))
                    .onAppear(perform: {
                        self.animatingModal = true
                    })
                }
            }
        }
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

// MARK: - PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
