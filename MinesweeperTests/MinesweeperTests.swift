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
    let bombJSON = "[[0,0],[0,4],[1,1],[1,4],[1,5],[2,0],[2,2],[2,5],[3,1],[3,4],[3,5],[4,4],[4,5],[5,0],[5,3],[6,0],[6,2]]"
    
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
     |   | X | X | X | X |   |   |
     +---+---+---+---+---+---+---+
     |   |   |   |   |   |   |   |
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
    
    // Assumptions given:
    // square selected is in board dimensions
    // position is given (starting from 0 to max-1)
    func testBombs() {
        // JSON string should insert bombs into correct positions
        // based on above json - 0,0 should have bomb
        XCTAssert(self.board.squares[0][0] == .bomb)
        
        // base on above json - 1,0 should have no bomb
        XCTAssert(self.board.squares[1][0] == .empty)
        
        // single function to test bomb by position
        XCTAssertTrue(self.board.isBombAt(x: 0, y: 0))
        
        // get surrounding bombs of square
        XCTAssert(self.board.getSurroundingBombCount(x: 2, y: 4) == 5)
        
        XCTAssert(self.board.getSurroundingBombCount(x: 6, y: 6) == 0)  // also checks that can test over range of grid
        
        // select square - to indicate the user has hit a bomb, return nil
        XCTAssertNil(self.board.selectSquare(x: 3, y: 4))
        
        // otherwise, return number of surrounding bombs
        XCTAssert(self.board.selectSquare(x: 2, y: 1)! == 4)
        
    }
    
}
