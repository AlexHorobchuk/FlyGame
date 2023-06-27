//
//  MazeMapView.swift
//  FlyGame
//
//  Created by Olha Dzhyhirei on 6/22/23.
//

import SwiftUI

struct MazeMapView: View {
    
    var maze: [[MapCell]]
    var correctmaze: [(Int, Int)]
    
    var body: some View {
        
        VStack(spacing: 0) {
            ForEach(maze.indices, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(maze[row].indices, id: \.self) { col in
                        let mapCell = maze[row][col]
                        
                        ZStack {
                            Rectangle()
                                .fill( mapCell == .wall ? Color.black : Color.clear)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            
                            if correctmaze.contains(where: { $0 == (row, col) } ) {
                                Rectangle()
                                    .fill(Color.green)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxWidth: 250,
               maxHeight: 250)
        .rotationEffect(Angle(degrees: 90))
    }
}

struct MazeMapView_Previews: PreviewProvider {
    static var previews: some View {
        let maze = MazeGenerator()
        MazeMapView(maze: maze.maze, correctmaze: maze.findPathFromStartToFinish()!)
    }
}
