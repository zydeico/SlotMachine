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
                
                // MARK: Footer
                Spacer()
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
                        print("Info View")
                    }) {
                        Image(systemName: "info.circle")
                    }
                    .modifier(ButtonModifier()), alignment: .topTrailing
            )
                .padding()
                .frame(maxWidth: 720)
            
            // MARK: PopUp
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
