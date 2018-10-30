//
//  ViewController.swift
//  Tip Calculator
//  this file uses user input to calculate the bill
//  PA4- Programming Assignment #4
//  CPSC 312-01
//  Created by Norman, Claire on 9/25/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//
//using <div>Icons made by <a href="https://www.flaticon.com/authors/smashicons" title="Smashicons">Smashicons</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>



import UIKit

class ViewController: UIViewController {

    //instantiate a tip calculator object
    var tipCalculator = TipCalculator()
    
    //reference to the labels
    @IBOutlet var tipAmount: UILabel!
    @IBOutlet var totalBill: UILabel!
    
    //reference text fields
    @IBOutlet var billAmount: UITextField!
    @IBOutlet var tipPercent: UITextField!
    
    //variables
    let numberFormatter = NumberFormatter()
    let dotString = "."
    //actions for the buttons
    @IBAction func calculatePressed(_ sender: UIButton) {
        print("Print button pressed")
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.current
        if let bill = Double(billAmount.text!) {
            //checks for negative values in the bill stub
            if billAmount.text!.contains("-"){
                let alertController = UIAlertController(title: "Invalid Input", message: "\(billAmount.text!)", preferredStyle: .actionSheet)
                alertController.addAction(UIAlertAction(title: "Change", style: .destructive, handler: nil))
                present(alertController, animated: true, completion: nil)
                totalBill.text = "Total Bill:      $0.00"
            }
            //checks to see if there are a proper amount of decimal points in dollar value
            if billAmount.text!.contains(dotString) {
                if billAmount.text!.components(separatedBy: dotString)[1].count != 2 {
                    let alertController = UIAlertController(title: "Invalid Input", message: "\(billAmount.text!)", preferredStyle: .actionSheet)
                    alertController.addAction(UIAlertAction(title: "Change", style: .destructive, handler: nil))
                    present(alertController, animated: true, completion: nil)
                    totalBill.text = "Total Bill:      $0.00"
                }
            }
            //then goes into the tip loop
            if let tip = Double(tipPercent.text!) {
                if tipPercent.text!.contains("-"){
                    let alertController = UIAlertController(title: "Invalid Input", message: "\(tipPercent.text!)", preferredStyle: .actionSheet)
                    alertController.addAction(UIAlertAction(title: "Change", style: .destructive, handler: nil))
                    present(alertController, animated: true, completion: nil)
                    tipAmount.text = "Tip Amount:  $0.00"
                    totalBill.text = "Total Bill:      $0.00"
                }
                let value = tipCalculator.calculateTipAmount(b: bill, tp: Int(tip)) as NSNumber
                let tipString = numberFormatter.string(from: value)!
                
                let value2 = tipCalculator.calculateTotalBill(b: bill, tp: Int(tip)) as NSNumber
                let billString = numberFormatter.string(from: value2)!
                
                tipAmount.text = "Tip Amount:  \(tipString)"
                totalBill.text = "Total Bill:       \(billString)"
            } else {
                let tip = bill as NSNumber
                let tipString = numberFormatter.string(from: tip)!
                tipAmount.text = "Tip Amount:  $0.00"
                totalBill.text = "Total Bill:       \(tipString)"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipAmount.text = "Tip Amount:  $0.00"
        totalBill.text = "Total Bill:       $0.00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
