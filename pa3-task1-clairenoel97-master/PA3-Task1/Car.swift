//
//  Car.swift
//  PA3-Task1
//
//  Created by Norman, Claire Noel on 9/14/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

import Foundation

// define the car class
// a protocol: a set of state and behavior that a class or a struct can implement
// 
struct Car: CustomStringConvertible, Driveable, Comparable {
    mutating func drive(miles: Int) {
        odometerReading = odometerReading + miles
        print("Driving \(make) \(model). \(make) \(model) now has \(odometerReading) miles")
    }
    
    //properties
    var make: String
    var model: String
    var bodyStyle: BodyStyle
    var year: Int
    var odometerReading: Int
    
    //initializing values to the given values of the parameter
    init(make: String, model: String, bodyStyle: BodyStyle, year: Int, odometerReading: Int) {
        self.make = make
        self.model = model
        self.bodyStyle = bodyStyle
        self.year = year
        self.odometerReading = odometerReading
        
    }
    
    //making a 'dummy' car
    init() {
        self.make = "Toyota"
        self.model = "Highlander"
        self.bodyStyle = .suv
        self.year = 2010
        self.odometerReading = 10000
    }
    
    //prints the information about the car
    //stub for the custom string convertiable
    var description: String {
        return "\(year) \(make) \(model) \(bodyStyle) with \(odometerReading) miles."
    }
    
    //comparing cars
    //first by year
    //then by make
    //then by model
    //then by odometerReading
    static func < (lhs: Car, rhs: Car) -> Bool {
        if lhs.year != rhs.year {
            return lhs.year < rhs.year
        } else if lhs.make != rhs.make {
            return lhs.make < rhs.make
        } else if lhs.model < rhs.model {
            return lhs.model < rhs.model
        }
        return lhs.odometerReading < rhs.odometerReading
    }
    
    //if two cars are exactly the same
    static func ==(lhs: Car, rhs: Car) -> Bool {
        return lhs.year == rhs.year && lhs.make == rhs.make && lhs.model == rhs.model && lhs.odometerReading == rhs.odometerReading
    }
}
