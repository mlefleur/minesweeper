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
    
    override func setUp() {
        super.setUp()
        
        self.board = Board(size: self.size, bombs: "")
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
    
}
