//
//  BodyMenu.swift
//  SlotMachine
//
//  Created by Jan Kott on 24.02.21.
//

import SwiftUI

//MARK:- Body Menu
struct BodyMenu: View{
    var bodyMenuImage: BodyMenuClass
    var bodyMenuText: BodyMenuClass
    
    var body: some View {
        Image("\(bodyMenuImage.bodyMenuImage)")
            .resizable()
            .scaledToFit()
            .frame(height: 72)
            .padding()
        Text("\(bodyMenuText.bodyMenuText)")
            .font(.system(.body, design: .rounded))
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .foregroundColor(.gray)
            .lineLimit(2)
            .padding()
        Spacer()
    }
}

class BodyMenuClass{
    var bodyMenuImage: String
    var bodyMenuText: String
    init(bodyMenuImage: String, bodyMenuText: String) {
        self.bodyMenuImage = bodyMenuImage
        self.bodyMenuText = bodyMenuText
    }
}
