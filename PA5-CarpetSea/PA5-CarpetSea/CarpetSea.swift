//
//  CarpetSea.swift
//  PA5-CarpetSea
//
//  Created by Norman, Claire Noel on 10/9/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

import Foundation
struct CarpetSea: CustomStringConvertible {
    //properties
    var N: Int
    var S: Int
    var grid: [[Cell]]
    var availableFish = ["🦐":0, "🐟":1, "🐡":2, "🐠":3, "🦑": 4, "🐙":5, "🦀":6, "🐬":10, "🦈": 20, "🐳":100, "👢": -1]
    
    //returns a strinf representation of the carpet sea
    //returns contents in each cell
    //similar to PA2
    var description: String {
        return "\(grid)"
    }
    
    //randomly selects a cell and places a randomly selected fish from the available fish
    func randomlyPlaceFish() {
        
    }
    
    //accepts the location of the user's fishing line and marks the cell as containing a line
    func dropFishingLine() {
        
    }
    
    //if the cell containing a fish and a fishingline, then returns a fish
    func checkFishCaught() -> String {
        return "hi"
    }
    
}
