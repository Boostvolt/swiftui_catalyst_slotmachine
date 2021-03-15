//
//  HeaderMenu.swift
//  SlotMachine
//
//  Created by Jan Kott on 24.02.21.
//

import SwiftUI

//MARK:- Header Menu
struct HeaderMenu: View{
    var headerMenuTitle: HeaderMenuClass
    @Binding var isShowingInfo: Bool
    @Binding var isShowingAccount: Bool
    @Binding var isShowingBet: Bool
    @Binding var isShowingModal: Bool
    
    func changeIsShowing(name: String){
        if headerMenuTitle.headerMenuTitle == "Info" {
            isShowingInfo = false
        } else if headerMenuTitle.headerMenuTitle == "Capital" {
            isShowingAccount = false
        } else if headerMenuTitle.headerMenuTitle == "Stake" {
            isShowingBet = false
        } else if headerMenuTitle.headerMenuTitle == "GameOver" {
            isShowingModal = false
        }
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Text("\(headerMenuTitle.headerMenuTitle)".uppercased())
                .font(.system(.title, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(.white)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
            Spacer()
            if headerMenuTitle.headerMenuTitle != "Game Over" {
                Button(action: {
                    changeIsShowing(name: headerMenuTitle.headerMenuTitle)
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.white)
                        .padding()
                        .font(.system(size: 22))
                })
            }
        }
        .background(
            Color("ColorBlue"))
        Spacer()
    }
}

class HeaderMenuClass{
    var headerMenuTitle: String
    init(headerMenuTitle: String) {
        self.headerMenuTitle = headerMenuTitle
    }
}
