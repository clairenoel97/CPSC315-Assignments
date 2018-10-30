//
//  main.swift
//  PA3-Task1
//
//  Created by Norman, Claire Noel on 9/14/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

import Foundation

//task 1: create a driver program that tests the car class
func carTester() {
    //create 10 instances of a car
    var car1 = Car()
    var car2 = Car(make:"Acura", model: "MDX", bodyStyle: .suv, year: 2016, odometerReading: 13000)
    var car3 = Car(make: "Buick", model: "LaCrosse", bodyStyle: .sedan, year: 2013, odometerReading: 93000)
    var car4 = Car(make: "Chevrolet", model: "Cruz LS", bodyStyle: .sedan, year: 2016, odometerReading: 39000)
    var car5 = Car(make: "Chevrolet", model: "Cruz LS", bodyStyle: .sedan, year: 2016, odometerReading: 14000)
    var car6 = Car(make: "Honda", model: "Odyssey", bodyStyle: .minivan, year: 2015, odometerReading: 15000)
    var car7 = Car(make: "Dodge", model: "Grand Caravan", bodyStyle: .minivan, year: 2017, odometerReading: 17000)
    var car8 = Car(make: "Dodge", model: "Challenger", bodyStyle: .sedan, year: 2014, odometerReading: 30000)
    var car9 = Car(make: "Dodge", model: "Ram 1500", bodyStyle: .truck, year: 2014, odometerReading: 37000)
    var car10 = Car(make: "Subaru", model: "Outback", bodyStyle: .stationWagon, year: 2014, odometerReading: 72000)
    
    //make an array of the car objects
    let cars = [car1,car2,car3,car4,car5,car6,car7,car8,car9,car10]
    
    //display the cars in the array
    print("Here is a list view of the cars in the array:\n")
    for (index, car) in cars.enumerated() {
        print("#\(index + 1): \(car.description)")
    }
    
    //sort the array according to the comparable protocol
    //by year, then make, then model, then odometerReading
    let sortedCars = cars.sorted(by: <)
    
    //printing the sorted array
    print("\n\nHere is the sorted array:\n")
    for (index, car) in sortedCars.enumerated() {
        print("#\(index + 1): \(car)")
    }
    
    //driving a few cars
    print("\n\nDriving cars\n")
    car1.drive(miles: 10)
    car3.drive(miles: 10000)
    car5.drive(miles: 50000)
    
    //make array of cars after driving
    var sortedAgain = [car1, car2, car3, car4, car5, car6, car7, car8, car9, car10]
    
    //sorting the list that has cars that were driven
    sortedAgain = sortedAgain.sorted(by: <)
    print("\n\nHere is the final sorted Cars array\n")
    for (index, car) in sortedAgain.enumerated() {
        print("#\(index + 1): \(car)")
    }
}

carTester()
