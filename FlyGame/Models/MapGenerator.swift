//
//  MapGenerator.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import Foundation

enum MapCel {
    case empty , star, labirint
}

struct MapGenerator {
    
    private func getMatrixSize(starsQuantity: Int) -> Int {
        let size = Int(ceil(sqrt(Double(starsQuantity + 1))))
        return (size % 2 == 0 ? size + 1 : size)
    }
    
    private func configureCellFillig(size: Int, starsQuantity: Int) -> [MapCel] {
        let starsArray = Array(repeating: MapCel.star, count: starsQuantity)
        let emptyArray = Array(repeating: MapCel.empty, count: (size * size) - 1 - starsQuantity)
        return starsArray + emptyArray
    }
    
    private func generateMatrix(size: Int, cellFilling: inout [MapCel]) -> [[MapCel]] {
        var map: [[MapCel]] = Array(repeating: [], count: size)
        for row in 0..<size {
            for column in 0..<size {
                guard row != size / 2 || column != size / 2 else { map[row].append(MapCel.labirint); continue }
                
                let randomIndex = Int.random(in: 0..<cellFilling.count)
                let cell = cellFilling.remove(at: randomIndex)
                map[row].append(cell)
            }
        }
        return map
    }
    
    func makeMap(starsQuantity: Int) -> [[MapCel]] {
        let size = getMatrixSize(starsQuantity: starsQuantity)
        var cellFilling = configureCellFillig(size: size, starsQuantity: starsQuantity)
        
        return generateMatrix(size: size, cellFilling: &cellFilling)
    }
}
