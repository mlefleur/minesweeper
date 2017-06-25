//
//  Board.swift
//  Minesweeper
//
//  Created by Matt Le Fleur on 25/06/2017.
//  Copyright © 2017 Matt. All rights reserved.
//

import Foundation

class Board  {
    var squares: [[Int]] = [] // 2d array to represent bombs
    
    init(size: Int, bombs: String) {
        // initialise array with 0s (no bomb)
        
        // Rows
        let row: [Int] = []
        for _ in 0..<size {
            self.squares.append(row)
        }
        
        // Columns
        for x in 0..<size {
            for _ in 0..<size {
                self.squares[x].append(0)
            }
        }
    }
}
