//
//  Board.swift
//  Minesweeper
//
//  Created by Matt Le Fleur on 25/06/2017.
//  Copyright © 2017 Matt. All rights reserved.
//

import Foundation

enum BoardSquare {
    case empty
    case bomb
}

class Board  {
    
    // MARK: - Variables
    var squares: [[BoardSquare]] = [] // 2d array to represent bombs
    
    
    // MARK: - Initialisers
    
    init(size: Int, bombs: String) {
        // initialise array with .empty (no bomb)
        
        self.squares = Array(repeating: Array(repeating: BoardSquare.empty, count: size), count: size)
        
        // insert bombs using json
        self.insertBombs(jsonBombs: bombs)
    }
    
    
    // MARK: - Public Functions
    
    // select square at position
    // if square is bomb, return nil
    // otherwise, return number of bombs around (above, below, left, right and diagonals)
    func selectSquare(x: Int, y: Int) -> Int? {
        switch self.isBombAt(x: x, y: y) {
        case true:
            return nil
        case false:
            let numberOfBombs = self.getSurroundingBombCount(x: x, y: y)
            return numberOfBombs
        }
    }
    
    
    // MARK: - Private Functions
    
    // insert bombs into self.squares
    private func insertBombs(jsonBombs: String) {
        guard let bombs = parseJSON(jsonBombs) else {
            return
        }
        
        for (_, bombPosition) in bombs.enumerated() {
            let x = bombPosition[0]
            let y = bombPosition[1]
            self.squares[x][y] = .bomb
        }
    }
    
    // parse json string as given in example
    // return as 2d array if Ints (coordinates)
    private func parseJSON(_ jsonString: String) -> [[Int]]? {
        if let data = jsonString.data(using: .utf8) {
            var returnArray: [[Int]] = []
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [Any]
                for i in 0..<json.count {
                    let j = json[i] as! [Int]
                    returnArray.append(j)
                }
            } catch {
                print(error.localizedDescription)
            }
            
            return returnArray
        }
        return nil
    }
    
    // test for bomb at x,y
    private func isBombAt(x: Int, y: Int) -> Bool {
        if self.squares[x][y] == .bomb {
            return true
        } else {
            return false
        }
    }
    
    // get number of bombs around (x,y)
    // can include (x,y) as we know it doesn't have bomb
    private func getSurroundingBombCount(x: Int, y: Int) -> Int {
        
        var counter = 0
        
        for posX in x-1...x+1 {
            if posX < 0 || posX >= self.squares.count { continue } // if out of X axis bounds, skip
            
            for posY in y-1...y+1 {
                if posY < 0 || posY >= self.squares[y].count { continue } // if out of Y axis bounds, skip
                
                if self.squares[posX][posY] == .bomb {
                    counter += 1
                }
            }
        }
        
        return counter
    }
    
    
}
