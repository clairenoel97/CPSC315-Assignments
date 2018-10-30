//
//  CarpetSea.swift
//  CarpetFishing
//  This file holds all of the information about the carpet sea
//      holds methods that can manipulate an instance of the carpet sea
//  CPSC 315-01, Fall 2018
//  No sources to site
//
//  Created by Norman, Claire Noel on 10/11/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

import Foundation
struct CarpetSea: CustomStringConvertible {
    //properties
    var N: Int
    var S: Int
    var grid = [[Cell]]()  //empty
    var availableFish = Dictionary<String?, Int>() //symbol and corresponding point value
    var lineRow: Int
    var lineCol: Int
    
    //initialize values for a carpet sea object
    init() {
        self.N = 2
        self.S = 60
        self.lineCol = 0
        self.lineRow = 0
        self.availableFish = ["🦐":1, "🐟":2, "🐡":3, "🐠":4, "🦑": 5, "🐙":10, "🦀":15, "🐬":20, "🦈": 50, "🐳":100]
        self.grid = Array(repeating: Array(repeating: Cell(), count: N), count: N)
    }
    
    //returns a strinf representation of the carpet sea
    //returns contents in each cell
    //similar to PA2
    var description: String {
        var gridString = ""
        for i in 0..<N {
            
            for j in 0..<N {
                gridString += "\(i)\(j): " + self.grid[i][j].fish! + " "
            }
            gridString += "\n"
        }
        return "\(gridString)"
    }
    
    //reseting the board after each click
    mutating func reset() {
        self.grid = Array(repeating: Array(repeating: Cell(), count: N), count: N)
    }
    
    //randomly selects a cell and places a randomly selected fish from the available fish
    mutating func randomlyPlaceFish() {
        //randomly picking the cell on the board
        let randRow = Int(arc4random_uniform(UInt32(grid.count)))
        let randCol = (Int(arc4random_uniform(UInt32(grid[randRow].count))))
        
        //select a random fish
        let randNum = Int(arc4random_uniform(UInt32(availableFish.count)))
        _ = Array(availableFish.values)[randNum]
        let fish = Array(availableFish.keys)[randNum]
        
        //put the fish onto the grid
        self.grid[randRow][randCol].setFish(fish)
    }
    
    //accepts the location of the user's fishing line and marks the cell as containing a line
    mutating func dropFishingLine(tag: Int) {
        //taking in a tag to account for the button being clicked
        lineRow = tag / 10
        lineCol = tag - (lineRow * 10)
        self.grid[lineRow][lineCol].containsLine = true

    }
    
    //if the cell containing a fish and a fishingline, then returns a fish
    mutating func checkFishCaught() -> (String?) {
        if(self.grid[lineRow][lineCol].fish != nil && self.grid[lineRow][lineCol].containsLine) {
            return grid[lineRow][lineCol].fish!
        } else {
            return nil
        }
    }
}
