//
//  ButtonMenu.swift
//  SlotMachine
//
//  Created by Jan Kott on 24.02.21.
//

import SwiftUI

//MARK:- Button Menu
struct ButtonMenu: View{
    var buttonMenuAmount: ButtonMenuClass
    var buttonMenuType: ButtonMenuClass
    @Binding var coins: Double
    @Binding var bet: Double
    @Binding var isShowingBet: Bool
    
    func checkIfEnoughCoins(amount: Double) -> Bool{
        if coins < amount && buttonMenuType.buttonMenuType == "Stake" {
            return true
        }
        return false
    }
    
    func processButtonAmount(){
        if buttonMenuType.buttonMenuType == "Stake" {
            bet = buttonMenuAmount.buttonMenuAmount
            isShowingBet = false
        } else if buttonMenuType.buttonMenuType == "Capital"{
            coins += buttonMenuAmount.buttonMenuAmount
        }
    }
    
    var body: some View {
        Button(action: {
            processButtonAmount()
            playSound(name: "casino-chips", format: "mp3")
        }, label: {
            Text("\(buttonMenuAmount.buttonMenuAmount)0 CHF".uppercased())
                .font(.system(.title2, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor((checkIfEnoughCoins(amount: buttonMenuAmount.buttonMenuAmount)) ? Color.red : Color("ColorBlue"))
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .frame(maxWidth: 145)
                .background(
                    Capsule()
                        .strokeBorder(lineWidth: 1.75)
                        .foregroundColor((checkIfEnoughCoins(amount: buttonMenuAmount.buttonMenuAmount)) ? Color.red : Color("ColorBlue"))
                )
        })
        .disabled(checkIfEnoughCoins(amount: buttonMenuAmount.buttonMenuAmount))
    }
}

class ButtonMenuClass{
    var buttonMenuAmount: Double
    var buttonMenuType: String
    init(buttonMenuAmount: Double, buttonMenuType: String) {
        self.buttonMenuAmount = buttonMenuAmount
        self.buttonMenuType = buttonMenuType
    }
}
