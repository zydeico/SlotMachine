//
//  Extensions.swift
//  Slot Machine
//
//  Created by Daniel Vázquez on 26/05/20.
//  Copyright © 2020 Daniel Vázquez. All rights reserved.
//

import SwiftUI

extension Text {
    func scoreLabelStyle() -> Text {
        self
            .foregroundColor(Color.white)
            .font(.system(size: 10, weight: .bold, design: .rounded))
    }
    
    func scoreNumberStyle() -> Text {
        self
            .foregroundColor(Color.white)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
    }
}
