//
//  ContentView.swift
//  SlotMachine
//
//  Created by Jan Kott on 24.02.21.
//

import SwiftUI

struct ContentView: View {
    
    //MARK:- Properties
    var items: Array = ["strawberry", "seven", "grape", "coin", "cherry", "bell"]
    @State private var slots: Array = [0, 1, 2]
    @State private var bet: Double = 0.00
    @State private var multiply: Double = 0.00
    @State private var score: Double = UserDefaults.standard.double(forKey: "score")
    @State private var coins: Double = 0.00
    @State private var isShowingModal: Bool = false
    @State private var isShowingAccount: Bool = true
    @State private var isShowingBet: Bool = false
    @State private var isShowingInfo: Bool = false
    @State private var isSlotsAnimated: Bool = false
    @State private var sleepAmount: Double = 8.00
    
    //Header Menu
    var headerMenuInfo: HeaderMenuClass = HeaderMenuClass(headerMenuTitle: "Info")
    var headerMenuGameOver: HeaderMenuClass = HeaderMenuClass(headerMenuTitle: "Game Over")
    var headerMenuKapital: HeaderMenuClass = HeaderMenuClass(headerMenuTitle: "Capital")
    var headerMenuEinsatz: HeaderMenuClass = HeaderMenuClass(headerMenuTitle: "Stake")
    
    //Body Menu
    var bodyMenuInfo: BodyMenuClass = BodyMenuClass(bodyMenuImage: "reel", bodyMenuText: "Copyright © 2021 Jan Kott. All rights reserved.")
    var bodyMenuGameOver: BodyMenuClass = BodyMenuClass(bodyMenuImage: "strawberry-reel", bodyMenuText: "Game Over! You have lost everything.\nTry again.")
    var bodyMenuKapital: BodyMenuClass = BodyMenuClass(bodyMenuImage: "coin-reel", bodyMenuText: "You need more capital?\nJust choose an amount.")
    var bodyMenuEinsatz: BodyMenuClass = BodyMenuClass(bodyMenuImage: "seven-reel", bodyMenuText: "You want to win more?\nJust bet a higher amount.")
    
    //Button Menu
    var buttonMenuK05: ButtonMenuClass = ButtonMenuClass(buttonMenuAmount: 0.50, buttonMenuType: "Capital")
    var buttonMenuK1: ButtonMenuClass = ButtonMenuClass(buttonMenuAmount: 1.00, buttonMenuType: "Capital")
    var buttonMenuK2: ButtonMenuClass = ButtonMenuClass(buttonMenuAmount: 2.00, buttonMenuType: "Capital")
    var buttonMenuK5: ButtonMenuClass = ButtonMenuClass(buttonMenuAmount: 5.00, buttonMenuType: "Capital")
    var buttonMenuE05: ButtonMenuClass = ButtonMenuClass(buttonMenuAmount: 0.5, buttonMenuType: "Stake")
    var buttonMenuE1: ButtonMenuClass = ButtonMenuClass(buttonMenuAmount: 1.00, buttonMenuType: "Stake")
    var buttonMenuE2: ButtonMenuClass = ButtonMenuClass(buttonMenuAmount: 2.00, buttonMenuType: "Stake")
    var buttonMenuE5: ButtonMenuClass = ButtonMenuClass(buttonMenuAmount: 5.00, buttonMenuType: "Stake")
    
    //MARK:- Fucntions
    func spinSlots() {
        slots = slots.map({_ in
            Int.random(in: 0...items.count - 1)
        })
        playSound(name: "spin", format: "mp3")
    }
    
    func winnersChecking() {
        // 3x Seven
        if slots[0] == 1 && slots[1] == 1 && slots[2] == 1 {
            multiply = 4.0
            newCoinsBalance()
            newScoresBalance()
            playSound(name: "win", format: "mp3")
        // 3x Same item
        } else if slots[0] == slots[1] && slots[0] == slots[2] && slots[1] == slots[2] {
            multiply = 2.0
            newCoinsBalance()
            newScoresBalance()
        // 2x Seven
        } else if slots[0] == 1 && slots[1] == 1 || slots[1] == 1 && slots[2] == 1 || slots[0] == 1 && slots[2] == 1 {
            multiply = 2.0
            newCoinsBalance()
            newScoresBalance()
            playSound(name: "high-score", format: "mp3")
        // 1x Seven
        } else if slots[0] == 1 || slots[1] == 1  || slots[2] == 1 {
            multiply = 1.0
            newCoinsBalance()
            newScoresBalance()
        } else {
            multiply = 0.0
        }
    }
    
    func newCoinsBalance() {
        coins += bet * multiply
    }
    
    func newScoresBalance() {
        if coins > score {
            // playSound(name: "high-score", format: "mp3")
            score = coins
            UserDefaults.standard.set(score, forKey: "score")
        }
    }
    
    func devGame() {
        coins = 100.00
        bet = 10.00
        playSound(name: "chimeup", format: "mp3")
    }
    
    func resetGame() {
        coins = 0.00
        bet = 0.00
        UserDefaults.standard.set(0, forKey: "score")
        playSound(name: "chimeup", format: "mp3")
    }
    
    //MARK:- Body
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("ColorBlue"), Color("ColorDarkBlue")]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 260, maxHeight: 200, alignment: .center)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 2, x: 0.0, y: 6)
                
                //MARK: - Kapital
                HStack(spacing: 50) {
                    HStack {
                        Button(action: {
                            isShowingAccount = true
                        }, label: {
                            Text("CAPITAL\nCHF")
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                                .multilineTextAlignment(.trailing)
                            
                            Text("\(String(format: "%.2f", coins))")
                                .textExtension()
                                .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                        })
                    }//HStack
                    .padding(.horizontal, 24)
                    .padding(.vertical, 4)
                    .frame(width: 220)
                    
                    .background(
                        Capsule()
                            .fill(Color("ColorDarkBlue"))
                            .opacity(0.4)
                    )
                    Spacer()
                    
                    //MARK:- High Score
                    HStack {
                        Text("HIGH\nSCORE")
                            .font(.system(size: 10, weight: .bold, design: .rounded))
                            .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                            .multilineTextAlignment(.trailing)
                        
                        Text("\(String(format: "%.2f", score))")
                            .textExtension()
                            .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                    }//HStack
                    .padding(.horizontal, 24)
                    .padding(.vertical, 4)
                    .frame(width: 220)
                    
                    .background(
                        Capsule()
                            .fill(Color("ColorDarkBlue"))
                            .opacity(0.4)
                    )
                    Spacer()
                    
                    //MARK:- Einsatz
                    HStack {
                        Button(action: {
                            isShowingBet = true
                        }, label: {
                            Text("STAKE\nCHF")
                                .font(.system(size: 10, weight: .bold, design: .rounded))
                                .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                                .multilineTextAlignment(.trailing)
                            Text("\(String(format: "%.2f", bet))")
                                .textExtension()
                                .shadow(color: Color("ColorTransparentBlack"), radius: 1, x: -3, y: 3)
                        })
                    }//HStack
                    .padding(.horizontal, 24)
                    .padding(.vertical, 4)
                    .frame(width: 220)
                    
                    .background(
                        Capsule()
                            .fill(Color("ColorDarkBlue"))
                            .opacity(0.4)
                    )
                }//HStack
                
                .foregroundColor(.white)
                .padding(.horizontal, 30)
                Spacer()
                //MARK:- SLOTS
                VStack(spacing: 10) {
                    HStack(spacing: 70) {
                        
                        //MARK:- Slot 0
                        ZStack {
                            SlotView()
                            Image(items[slots[0]])
                                .resizable()
                                .frame(minWidth: 180, minHeight: 180)
                                .scaledToFit()
                                .opacity(isSlotsAnimated ? 1 : 0)
                                .offset(x: 0, y: isSlotsAnimated ? 0 : -70)
                                .animation(.easeInOut(duration: Double.random(in: 0.4...0.6)))
                                .onAppear(perform: {
                                    isSlotsAnimated = true
                                    playSound(name: "riseup", format: "mp3")
                                })
                            
                        }
                        Spacer()
                        //MARK:- Slot 1
                        ZStack {
                            SlotView()
                            Image(items[slots[1]])
                                .resizable()
                                .frame(minWidth: 180, minHeight: 180)
                                .scaledToFit()
                                .opacity(isSlotsAnimated ? 1 : 0)
                                .offset(x: 0, y: isSlotsAnimated ? 0 : -70)
                                .animation(.easeInOut(duration: Double.random(in: 0.6...0.8)))
                                .onAppear(perform: {
                                    isSlotsAnimated = true
                                })
                        }
                        Spacer()
                        //MARK:- Slot 2
                        ZStack {
                            SlotView()
                            Image(items[slots[2]])
                                .resizable()
                                .frame(minWidth: 180, minHeight: 180)
                                .scaledToFit()
                                .opacity(isSlotsAnimated ? 1 : 0)
                                .offset(x: 0, y: isSlotsAnimated ? 0 : -70)
                                .animation(.easeInOut(duration: Double.random(in: 0.7...0.9)))
                                .onAppear(perform: {
                                    isSlotsAnimated = true
                                })
                        }
                    }//HStack
                    .padding(.horizontal, 30)
                    
                    //MARK:- Spin Button
                    Button(action: {
                        if bet > 0 {
                            //Step 1
                            withAnimation() {
                                isSlotsAnimated = false
                            }
                            
                            //Step 2
                            spinSlots()
                            
                            //Step 3
                            coins -= bet
                            if coins <= 0 {
                                isShowingModal = true
                                playSound(name: "game-over", format: "mp3")
                            }
                            //Step 4
                            winnersChecking()
                            
                            //Step 5
                            withAnimation() {
                                isSlotsAnimated = true
                            }
                        } else {
                            isShowingBet = true
                        }
                    }, label: {
                        Image("spin")
                            .resizable()
                            .frame(maxWidth: 110, maxHeight: 100)
                            .modifier(ImageModifier())
                    })
                }//VStack
                .frame(maxWidth: 1000, maxHeight: 700)
                .padding(.vertical, 30)
                Spacer()
                
            }//Vstack
            .frame(maxWidth: 720, maxHeight: 960)
            .blur(radius: isShowingModal ? 5 : 0)
            
            //MARK: - Reset and Info Button
            .overlay(
                VStack {
                    HStack{
                        Text("Slot Machine")
                            .font(.system(size: 40, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity)
                    }
                    
                    HStack{
                        Button(action: {
                            resetGame()
                            withAnimation(.easeIn(duration: 1)) {
                                isSlotsAnimated = false
                            }
                            withAnimation() {
                                isSlotsAnimated = true
                            }
                        }, label: {
                            Image(systemName: "repeat.circle")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                        })
                        
                        Button(action: {
                            isShowingInfo = true
                        }, label: {
                            Image(systemName: "info.circle")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                        })
                        
                        Button(action: {
                            devGame()
                            withAnimation(.easeIn(duration: 1)) {
                                isSlotsAnimated = false
                            }
                            withAnimation() {
                                isSlotsAnimated = true
                            }
                        }, label: {
                            Image(systemName: "command.circle")
                                .font(.system(size: 35))
                                .foregroundColor(.white)
                        })
                    }
                }
                .padding(.horizontal, 0)
                .padding(.top, 30)
                , alignment: .topTrailing
                
            )
            
            //MARK:- Menu Game Over
            if $isShowingModal.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        HeaderMenu(headerMenuTitle: headerMenuGameOver, isShowingInfo: self.$isShowingInfo, isShowingAccount: self.$isShowingAccount, isShowingBet: self.$isShowingBet, isShowingModal: self.$isShowingModal)
                        
                        VStack {
                            BodyMenu(bodyMenuImage: bodyMenuGameOver, bodyMenuText: bodyMenuGameOver)
                            
                            VStack(spacing: 16) {
                                Button(action: {
                                    isShowingModal = false
                                    resetGame()
                                    withAnimation(.easeIn(duration: 1)) {
                                        isSlotsAnimated = false
                                    }
                                    withAnimation() {
                                        isSlotsAnimated = true
                                    }
                                }, label: {
                                    Text("New game".uppercased())
                                        .font(.system(.title2, design: .rounded))
                                        .fontWeight(.heavy)
                                        .foregroundColor(Color("ColorBlue"))
                                        .padding(.vertical, 8)
                                        .padding(.horizontal, 12)
                                        .frame(minWidth: 128)
                                        .background(
                                            Capsule()
                                                .strokeBorder(lineWidth: 1.75)
                                                .foregroundColor(Color("ColorBlue"))
                                        )
                                })
                            }
                            Spacer()
                        }//Vstack
                    }//VStack
                    .frame(minWidth: 280, idealWidth: 320, maxWidth: 345, minHeight: 320, idealHeight: 320, maxHeight: 380, alignment: .center)
                    .background(
                        Color(.white))
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 2, x: 0, y: 8)
                }
            }
            
            //MARK: -Menu Info
            if $isShowingInfo.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        HeaderMenu(headerMenuTitle: headerMenuInfo, isShowingInfo: self.$isShowingInfo, isShowingAccount: self.$isShowingAccount, isShowingBet: self.$isShowingBet, isShowingModal: self.$isShowingModal)
                        
                        VStack {
                            BodyMenu(bodyMenuImage: bodyMenuInfo, bodyMenuText: bodyMenuInfo)
                        }//Vstack
                    }//VStack
                    .frame(minWidth: 280, idealWidth: 320, maxWidth: 345, minHeight: 250, idealHeight: 270, maxHeight: 270, alignment: .center)
                    .background(
                        Color(.white))
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 2, x: 0, y: 8)
                }
            }
            
            //MARK:- Menu Kapital
            if $isShowingAccount.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        HeaderMenu(headerMenuTitle: headerMenuKapital, isShowingInfo: self.$isShowingInfo, isShowingAccount: self.$isShowingAccount, isShowingBet: self.$isShowingBet, isShowingModal: self.$isShowingModal)
                        
                        VStack {
                            BodyMenu(bodyMenuImage: bodyMenuKapital, bodyMenuText: bodyMenuKapital)
                            
                            VStack(spacing: 16) {
                                HStack {
                                    Stepper(value: $coins) {
                                        Text("\(String(format: "%.2f", coins)) CHF")
                                    }
                                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                                    .foregroundColor(Color.blue)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .frame(maxWidth: 300)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorBlue"))
                                    )
                                }
                                
                                HStack{
                                    //Kapital + 0.50 CHF
                                    ButtonMenu(buttonMenuAmount: buttonMenuK05, buttonMenuType: buttonMenuK05, coins: self.$coins, bet: self.$bet, isShowingBet: self.$isShowingBet)
                                    //Kapital + 1.00 CHF
                                    ButtonMenu(buttonMenuAmount: buttonMenuK1, buttonMenuType: buttonMenuK1, coins: self.$coins, bet: self.$bet, isShowingBet: self.$isShowingBet)
                                }
                                HStack{
                                    //Kapital + 2.00 CHF
                                    ButtonMenu(buttonMenuAmount: buttonMenuK2, buttonMenuType: buttonMenuK2, coins: self.$coins, bet: self.$bet, isShowingBet: self.$isShowingBet)
                                    //Kapital + 5.00 CHF
                                    ButtonMenu(buttonMenuAmount: buttonMenuK5, buttonMenuType: buttonMenuK5, coins: self.$coins, bet: self.$bet, isShowingBet: self.$isShowingBet)
                                }
                            }
                            Spacer()
                        }//Vstack
                    }//VStack
                    .frame(minWidth: 280, idealWidth: 320, maxWidth: 345, minHeight: 320, idealHeight: 320, maxHeight: 470, alignment: .center)
                    .background(
                        Color(.white))
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 2, x: 0, y: 8)
                }
            }
            
            //MARK:- Menu Einsatz
            if $isShowingBet.wrappedValue {
                ZStack {
                    Color("ColorTransparentBlack")
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack(spacing: 0) {
                        HeaderMenu(headerMenuTitle: headerMenuEinsatz, isShowingInfo: self.$isShowingInfo, isShowingAccount: self.$isShowingAccount, isShowingBet: self.$isShowingBet, isShowingModal: self.$isShowingModal)
                        
                        VStack {
                            BodyMenu(bodyMenuImage: bodyMenuEinsatz, bodyMenuText: bodyMenuEinsatz)
                            
                            VStack(spacing: 16) {
                                HStack {
                                    Stepper(value: $bet) {
                                        Text("\(String(format: "%.2f", bet)) CHF")
                                    }
                                    .font(.system(size: 22, weight: .heavy, design: .rounded))
                                    .foregroundColor(Color.blue)
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .frame(maxWidth: 300)
                                    .background(
                                        Capsule()
                                            .strokeBorder(lineWidth: 1.75)
                                            .foregroundColor(Color("ColorBlue"))
                                    )
                                }
                                
                                HStack{
                                    //Einsatz 0.50 CHF
                                    ButtonMenu(buttonMenuAmount: buttonMenuE05, buttonMenuType: buttonMenuE05, coins: self.$coins, bet: self.$bet, isShowingBet: self.$isShowingBet)
                                    //Einsatz 1.00 CHF
                                    ButtonMenu(buttonMenuAmount: buttonMenuE1, buttonMenuType: buttonMenuE1, coins: self.$coins, bet: self.$bet, isShowingBet: self.$isShowingBet)
                                }
                                HStack{
                                    //Einsatz 2.00 CHF
                                    ButtonMenu(buttonMenuAmount: buttonMenuE2, buttonMenuType: buttonMenuE2, coins: self.$coins, bet: self.$bet, isShowingBet: self.$isShowingBet)
                                    //Einsatz 5.00 CHF
                                    ButtonMenu(buttonMenuAmount: buttonMenuE5, buttonMenuType: buttonMenuE5, coins: self.$coins, bet: self.$bet, isShowingBet: self.$isShowingBet)
                                }
                            }
                            Spacer()
                        }//Vstack
                    }//VStack
                    .frame(minWidth: 280, idealWidth: 320, maxWidth: 345, minHeight: 320, idealHeight: 320, maxHeight: 470, alignment: .center)
                    .background(
                        Color(.white))
                    .cornerRadius(20)
                    .shadow(color: Color("ColorTransparentBlack"), radius: 2, x: 0, y: 8)
                }
            }
        }//ZStack
    }
}

//MARK:- Preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


