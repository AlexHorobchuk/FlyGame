//
//  ShopScreen.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/25/23.
//

import SwiftUI

struct ShopScreen: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @StateObject var progress = ProgressVM()
    
    var items: [ShopingItem] = ShopItems.allCases.map { $0.getShopingItem() }
    
    var body: some View {
        VStack {
            Text("Money:\(progress.money)")
            
            ScrollView {
                HStack {
                    ForEach(items, id: \.id) { item in
                        VStack {
                            Text(item.name)
                                .padding()
                            Text("\(item.price)")
                                .padding()
                            
                            Button(action: {
                                progress.buy(item: item)
                                SoundManager.shared.playSound(for: .click)
                            }) {
                                Text("Buy")
                                    .frame(width: 150, height: 60)
                                    .background(Color.red)
                            }
                        }
                    }
                }
            }
            .padding()
            .fullScreenCover(item: $progress.alert) { alert in
                AlertView(alertItem: alert, action: {
                    progress.alert = nil
                })
                .clearModalBackground()
            }
            
            .navigationBarBackButtonHidden(true)
            
            .toolbar {
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        SoundManager.shared.playSound(for: .click)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        CloseScreenButton()
                    }
                    .offset(y: 5)
                }
            }
        }
    }
}

struct ShopScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShopScreen()
    }
}
