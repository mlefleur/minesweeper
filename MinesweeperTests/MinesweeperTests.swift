//
//  MinesweeperTests.swift
//  MinesweeperTests
//
//  Created by Matt Le Fleur on 25/06/2017.
//  Copyright © 2017 Matt. All rights reserved.
//

import XCTest
@testable import Minesweeper

class MinesweeperTests: XCTestCase {
    
    var board: Board!
    let size = 7
    let bombJSON = "[[0,0],[0,4],[1,1],[1,4],[1,5],[2,0],[2,2],[2,5],[3,1],[3,4],[3,5],[4,4],[4,5],[5,0],[5,3],[5,6],[6,0],[6,2],[6,5]]"
    
    /*
     +---+---+---+---+---+---+---+
     | X |   | X |   |   | X | X |
     +---+---+---+---+---+---+---+
     |   | X |   | X |   |   |   |
     +---+---+---+---+---+---+---+
     |   |   | X |   |   |   | X |
     +---+---+---+---+---+---+---+
     |   |   |   |   |   | X |   |
     +---+---+---+---+---+---+---+
     | X | X |   | X | X |   |   |
     +---+---+---+---+---+---+---+
     |   | X | X | X | X |   | X |
     +---+---+---+---+---+---+---+
     |   |   |   |   |   | X |   |
     +---+---+---+---+---+---+---+
     */
    
    
    override func setUp() {
        super.setUp()
        
        self.board = Board(size: self.size, bombs: bombJSON)
    }
    
    override func tearDown() {
        super.tearDown()
        self.board = nil
    }
    
    
    // Assumptions given:
    // size is non negative
    // board is square
    func testBoardInit() {
        // Board should be created correctly
        XCTAssertNotNil(board)
        
        // Width should equal size given for init
        let width = self.board.squares.count
        XCTAssert(width == self.size)
        
        // Height should equal size given for init
        let height = self.board.squares[0].count
        XCTAssert(height == self.size)
        
        // Width should equal height
        XCTAssert(width == height)
        
        // Total squares
        var counter = 0
        for x in 0..<self.board.squares.count {
            for _ in 0..<self.board.squares[x].count {
                counter += 1
            }
        }
        
        XCTAssert(counter == self.size * self.size) // eg size = 7, therefore counter = 49
    }
    
    func testBombs() {
        // JSON string should insert bombs into correct positions
        // based on above json - 0,0 should have bomb
        XCTAssert(self.board.squares[0][0] == 1)
        
        // base on above json - 1,0 should have no bomb
        XCTAssert(self.board.squares[1][0] == 0)
    }
    
}
