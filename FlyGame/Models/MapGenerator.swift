//
//  MapGenerator.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/19/23.
//

import Foundation

enum MapCell {
    case empty , star, labirint,  wall, road, end, start
}

struct MapGenerator {
    
    private func getMatrixSize(starsQuantity: Int) -> Int {
        let size = Int(ceil(sqrt(Double(starsQuantity + 1))))
        return (size % 2 == 0 ? size + 1 : size)
    }
    
    private func configureCellFillig(size: Int, starsQuantity: Int) -> [MapCell] {
        let starsArray = Array(repeating: MapCell.star, count: starsQuantity)
        let emptyArray = Array(repeating: MapCell.empty, count: (size * size) - 1 - starsQuantity)
        return starsArray + emptyArray
    }
    
    private func generateMatrix(size: Int, cellFilling: inout [MapCell]) -> [[MapCell]] {
        var map: [[MapCell]] = Array(repeating: [], count: size)
        for row in 0..<size {
            for column in 0..<size {
                guard row != size / 2 || column != size / 2 else { map[row].append(MapCell.labirint); continue }
                
                let randomIndex = Int.random(in: 0..<cellFilling.count)
                let cell = cellFilling.remove(at: randomIndex)
                map[row].append(cell)
            }
        }
        return map
    }
    
    func makeMap(starsQuantity: Int) -> [[MapCell]] {
        let size = getMatrixSize(starsQuantity: starsQuantity)
        var cellFilling = configureCellFillig(size: size, starsQuantity: starsQuantity)
        
        return generateMatrix(size: size, cellFilling: &cellFilling)
    }
}
