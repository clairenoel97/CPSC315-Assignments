//
//  TipCalculator.swift
//  Tip Calculator
//  this file has the constructor and functions for the tip calculator class
//  PA4- Programming Assignment #4
//  CPSC 312-01
//  Created by Norman, Claire on 9/25/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import Foundation

struct TipCalculator: CustomStringConvertible {
    //properties
    var bill: Double
    var tipPercent: Int
    var totalBill: Double
    var tipAmount: Double
    
    //initialized the values for the bill
    init() {
        bill = 0
        tipPercent = 20 //20%
        totalBill = 0.00
        tipAmount = 0.00
    }
    
    //initializing the values according to user input
    init(bill: Double, tipPercent: Int, totalBill: Double, tipAmount: Double) {
        self.bill = bill
        self.tipPercent = tipPercent
        self.tipAmount = tipAmount
        self.totalBill = totalBill
    }
    
    //actively calculates the tip amount according to the parameters
    //takes user input
    mutating func calculateTipAmount(b: Double, tp: Int) -> Double {
        tipAmount = b * (Double(tp)/100)
        return tipAmount
    }
    
    //calculates the total bill amount accroding to the parameters
    mutating func calculateTotalBill(b: Double, tp: Int) -> Double {
        totalBill = calculateTipAmount(b: b, tp: tp) + b
        return totalBill
    }
    
    //prints label for the label
    var description: String {
        return "Your total: $\(totalBill)"
    }
}
