//
//  Cell.swift
//  CarpetFishing
//  This file holds all of the information about individual cells
//      holds methods that can manipulate the contents of each cell
//  CPSC 315-01, Fall 2018
//  No sources to site
//
//  Created by Norman, Claire Noel on 10/11/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

import Foundation
struct Cell: CustomStringConvertible {
    //properties
    var row: Int
    var col: Int
    var containsLine: Bool
    var fish: String?  //this is the emoji inside the cell, like a symbol
    
    //initializing cells to given values
    init() {
        self.row = 0
        self.col = 0
        self.containsLine = false
        self.fish = "-"
    }
    
    //initializes cell with the values given
    init(row: Int, col:Int, containsLine: Bool, fish: String?, containsFish: Bool) {
        self.row = row
        self.col = col
        self.containsLine = containsLine
        self.fish = fish
    }
    
    //sets the fish string for each cell
    mutating func setFish(_ fish: String?) {
        self.fish = fish
    }
    
    //sets the boolean if the user drops a line in the cell
    mutating func setLine() {
        self.containsLine = true
    }
    
    //sets the string the each cell contains based  upon if a fish is randomly selected for that cell
    //also takes into consideration if the user drops a line into the cell
    var description: String {
        if self.containsLine && self.fish != "-" {
            return "🎣"
        } else if self.containsLine {
            return "⌇"
        } else if self.fish != nil  && self.fish != "-"{
            return self.fish!
        } else {
            return ""
        }
    }
}
