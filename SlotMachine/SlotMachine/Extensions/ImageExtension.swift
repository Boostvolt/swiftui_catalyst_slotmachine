//
//  ImageExtension.swift
//  SlotMachine
//
//  Created by Jan Kott on 24.02.21.
//

import SwiftUI

struct ImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .scaledToFill()
            .frame(minWidth: 100, maxWidth: 200, minHeight: 100, maxHeight: 200, alignment: .center)
            .shadow(color: Color("ColorTransparentBlack"), radius: 4, x: 0.0, y: 6)
    }
}
