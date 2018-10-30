//
//  Trip.swift
//  Traveler
//
//  this program provides properties and methods for a trip instance
//  each trip represents a trip a user has taken
//  CPSC315-01, Fall 2018
//  Programming Assignment #6
//  No sources to cite
//
//  Created by Norman, Claire on 10/27/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

//DONE
import Foundation

class Trip: Codable, CustomStringConvertible {
    // Properties
    var destinationName: String
    var startDate: Date
    var endDate: Date
    var imageFileName: String?
    
    //prints a string instance of a trip
    var description: String {
        return "You took a trip to \(destinationName): \t\(startDate) - \(endDate)"
    }
    
    // Initializers
    init(destination: String, start: Date, end: Date, image: String?) {
        self.destinationName = destination
        self.startDate = start
        self.endDate = end
        self.imageFileName = image
    }
}
