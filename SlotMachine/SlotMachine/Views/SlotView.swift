//
//  SlotView.swift
//  SlotMachine
//
//  Created by Jan Kott on 24.02.21.
//

import SwiftUI

struct SlotView: View {
    var body: some View {
        Image("reel")
            .resizable()
            .scaledToFill()
            .modifier(ImageModifier())
            .shadow(color: Color("ColorTransparentBlack"), radius: 4, x: 0.0, y: 6)
    }
}

struct SlotView_Previews: PreviewProvider {
    static var previews: some View {
        SlotView()
    }
}
