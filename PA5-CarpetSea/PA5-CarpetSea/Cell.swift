//
//  Cell.swift
//  PA5-CarpetSea
//
//  Created by Norman, Claire Noel on 10/9/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

import Foundation
struct Cell: CustomStringConvertible {
    var row: Int
    var col: Int
    var containsLine: Bool
    var fish: String?
    
    var description: String {
        return "\(fish)"
    }
}
