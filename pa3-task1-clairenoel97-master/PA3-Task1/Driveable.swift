//
//  Driveable.swift
//  PA3-Task1
//
//  Created by Norman, Claire Noel on 9/14/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

import Foundation

protocol Driveable {
    //this will be where the protocol will be
    //functions for the car
    
    //represents driving a certain number of miles
    //all cars should be able to drive
    //this represents that amount of miles a car has driven
    mutating func drive(miles: Int) -> Void
    
}
