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
        
        // insert bombs using json
        self.insertBombs(jsonBombs: bombs)
    }
    
    // insert bombs into self.squares
    func insertBombs(jsonBombs: String) {
        guard let bombs = parseJSON(jsonBombs) else {
            return
        }
        
        for (_, bombPosition) in bombs.enumerated() {
            let x = bombPosition[0]
            let y = bombPosition[1]
            self.squares[x][y] = 1
        }
    }
    
    // parse json string as given in example
    // return as 2d array if Ints (coordinates)
    func parseJSON(_ jsonString: String) -> [[Int]]? {
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
}
