//
//  GameVM.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/18/23.
//

import Foundation

final class GameVM: ObservableObject {
    
    
    var starsQuontity: Int
    var mapGenerator: MapGenerator
    var mover: MoverService?
    
    init (points: Int) {
        self.starsQuontity = points
        self.mapGenerator = MapGenerator()
    }
    
    func getMap() -> [[MapCel]] {
        return mapGenerator.makeMap(starsQuantity: starsQuontity)
    }
}
