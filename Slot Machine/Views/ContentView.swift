//
//  ContentView.swift
//  Slot Machine
//
//  Created by Daniel Vázquez on 26/05/20.
//  Copyright © 2020 Daniel Vázquez. All rights reserved.
//

import SwiftUI

// MAKR: PROPERTIES

struct ContentView: View {
    
    // MARK: - Properties
    @State private var showingInfoView: Bool = false
    
    // MARK: BODY
    var body: some View {
        ZStack {
            // MARK: Background
            LinearGradient(gradient: Gradient(colors: [Color("ColorPink"), Color("ColorPurple")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            // MAKR: Interface
            
            VStack(alignment: .center, spacing: 5) {
                
                // MARK: Header
                LogoView()
                
                Spacer()
                
                // MARK: Score
                HStack {
                    HStack {
                        Text("Your\nCoins".uppercased())
                            // Adding reuzable code
                            .scoreLabelStyle()
                            .multilineTextAlignment(.trailing)
                        
                        Text("100")
                            // Adding reuzable code
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
                
                // MARK: Slot Machine
                VStack(alignment: .center, spacing: 0) {
                    // MARK: - REEL #1
                    ZStack {
                        ReelView()
                        Image("gfx-bell")
                            .resizable()
                            .modifier(ImageModifier())
                    }
                    
                    HStack(alignment: .center, spacing: 0) {
                        // MARK: REEL #2
                        ZStack {
                            ReelView()
                            Image("gfx-seven")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                        
                        Spacer()
                        
                        // MARK: REEL # 3
                        ZStack {
                            ReelView()
                            Image("gfx-cherry")
                                .resizable()
                                .modifier(ImageModifier())
                        }
                    }
                    .frame(maxWidth: 500)
                    
                    // MARK: Spin Button
                    Button(action: {
                        print("Spin the reels")
                    }) {
                        Image("gfx-spin")
                            .renderingMode(.original)
                            .resizable()
                            .modifier(ImageModifier())
                    }
                }
                .layoutPriority(2)
                
                // MARK: Footer
                Spacer()
                HStack {
                    // MAKR: - BET 20
                    HStack(alignment: .center
                    , spacing: 10) {
                        Button(action: {
                            print("Bet 20 coins")
                        }) {
                            Text("20")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.white)
                                .modifier(BetNumberModifier())
                        }
                            // Adding aspect modifier
                            .modifier(BetCapsuleModifier())
                        
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(0)
                            .modifier(CasinoChipsModifier())
                    }
                    
                    // MAKR: - BET 10
                    HStack(alignment: .center
                    , spacing: 10) {
                        Image("gfx-casino-chips")
                            .resizable()
                            .opacity(1)
                            .modifier(CasinoChipsModifier())
                        // Second Button
                        Button(action: {
                            print("Bet 10 coins")
                        }) {
                            Text("10")
                                .fontWeight(.heavy)
                                .foregroundColor(Color.yellow)
                                .modifier(BetNumberModifier())
                        }
                            // Adding aspect modifier
                            .modifier(BetCapsuleModifier())
                    }
                }
            }
                // MARK: Buttons
                .overlay(
                    // RESET
                    Button(action: {
                        print("Reset the game")
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
            
            // MARK: PopUp
        }
        .sheet(isPresented: $showingInfoView) {
            InfoView()
        }
    }
}

// MARK: PREVIEW

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 11 Pro")
    }
}
