//
//  ShopScreen.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import SwiftUI

struct ShopScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var progress = ProgressVM()
    
    
    var items: [ShopingItem] = ShopItems.allCases.map { $0.getShopingItem() }
    
    var body: some View {
        ZStack {
            
            Image(progress.currentBackground)
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack {
                ZStack {
                    HStack(alignment: .center) {
                        Button(action: {
                            SoundManager.shared.playSound(for: .click)
                            presentationMode.wrappedValue.dismiss()
                        } ) {
                            CustomView(image: ImageGenerator.goBack.rawValue)
                                .frame(width: 45, height: 45)
                        }
                        
                        Spacer()
                        
                        Text("\(progress.money)")
                            .font(.custom("GlassAntiqua-Regular", size: 22))
                            .foregroundColor(.white)
                        
                        CustomView(image: ImageGenerator.chest.rawValue)
                            .frame(width: 40, height: 40)
                    }
                    .padding(.top, 10)
                    
                    VStack {
                        Text("SHOP")
                            .font(.custom("GlassAntiqua-Regular", size: 32))
                            .foregroundColor(.white)
                            .padding(.top, UIScreen.main.bounds.height * 0.1)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 60) {
                    ForEach(items, id: \.id) { item in
                        ZStack {
                            CustomView(image: item.image)
                                .frame(width: UIScreen.main.bounds.width * 0.2)
                            VStack {
                                Spacer()
                                
                                Button(action: {
                                    progress.buy(item: item)
                                    SoundManager.shared.playSound(for: .click)
                                }) {
                                    if !progress.allBackgrounds.contains(where: { $0 == item.name }) {
                                        CustomView(image: ImageGenerator.buy.rawValue)
                                            .frame(height: UIScreen.main.bounds.height * 0.15)
                                            .offset(y: -UIScreen.main.bounds.width * 0.01)
                                    }
                                }
                            }
                            VStack {
                                Spacer()
                                
                                if !progress.allBackgrounds.contains(where: { $0 == item.name }) {
                                    Text("\(item.price)")
                                        .font(.custom("GlassAntiqua-Regular", size: 22))
                                        .foregroundColor(.white)
                                        .offset(y: UIScreen.main.bounds.height * 0.15 / 3)
                                }
                            }
                        }
                        .onTapGesture {
                            if progress.allBackgrounds.contains(where: { $0 == item.name }) {
                                progress.buy(item: item)
                            }
                        }
                    }
                }
                .padding()
                
                Spacer()
                
                .fullScreenCover(item: $progress.alert) { alert in
                    AlertView(alertItem: alert, action: {
                        progress.alert = nil
                    })
                    .clearModalBackground()
                }
                
                .navigationBarBackButtonHidden(true)
            }
            .frame(width: UIScreen.main.bounds.width * 0.9,
                   height: UIScreen.main.bounds.height * 0.9)
        }
    }
}

struct ShopScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShopScreen()
    }
}
