//
//  LogoView.swift
//  Slot Machine
//
//  Created by Daniel Vázquez on 26/05/20.
//  Copyright © 2020 Daniel Vázquez. All rights reserved.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        Image("gfx-slot-machine")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 256, idealWidth: 300, maxWidth: 320, minHeight: 112, idealHeight: 130, maxHeight: 140, alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
            .modifier(ShadowModifier())
    }
}

struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
            .previewDevice("iPhone 11 Pro")
    }
}
