//
//  AddTripViewController.swift
//  Traveler
//
//  this program provides properties and methods for the user to add a trip to the list
//  each trip represents a trip a user has taken
//  CPSC315-01, Fall 2018
//  Programming Assignment #6
//  No sources to cite

//  Created by Norman, Claire Noel on 10/27/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

//DONE
import UIKit

class AddTripViewController: UIViewController, UITextFieldDelegate {
    
    //properties
    let dateFormatter = DateFormatter()
    var trip: Trip? = nil
    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    @IBOutlet weak var endDateTextField: UITextField!
    @IBOutlet weak var tripNumberLabel: UILabel!
    var countStr = String()
    
    //when the page loads
    //1. sets the date format
    //2. sets the keyborad type for each textfield
    //3. make autocorrect for dates to no
    //4. resigns the first responder
    override func viewDidLoad() {
        super.viewDidLoad()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        startDateTextField.delegate = self
        destinationTextField.delegate = self
        endDateTextField.delegate = self
        self.tripNumberLabel.text = countStr
        self.tripNumberLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        self.startDateTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.startDateTextField.autocorrectionType = .no
        self.endDateTextField.keyboardType = UIKeyboardType.numbersAndPunctuation
        self.endDateTextField.autocorrectionType = .no
        
    }
    
    //method to resign the first responder
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //this is a method the gets rid of the keyboard if anywhere on the screen is touched
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // segue that goes from the add trip screen to the main table view list
    //if save is picked, it will transfer all information entered
    //if cancel is chosen, all information ignored and goes back to main list view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                if let destination = destinationTextField.text, let start = startDateTextField.text, let end = endDateTextField.text {
                    let newTrip = Trip(destination: destination, start: dateFormatter.date(from: start)!, end: dateFormatter.date(from: end)!, image: nil)
                    self.trip = newTrip
                }
            } else if identifier == "cancelSegue" {
                if let tripVC = segue.destination as? TripTableViewController {
                    print("Cancelling")
                }
            }
        }
    }
    
    
    //if the user wants to save the information
    //will return false if any of the fields are empty
    //will return false if the dsates do not have the correct format
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        if identifier == "SaveUnwindSegue" {
            //if the destination is empty
            //if the end date is empty
            //if start date isempyt
            if destinationTextField.text == "" {
                alertController.title = "Missing Destiantion"
                alertController.message = "Please enter the name of a Destination"
                present(alertController, animated: true, completion: nil)
                return false
            } else if endDateTextField.text == "" || startDateTextField.text == ""{
                alertController.title = "Missing Date"
                alertController.message = "Please enter a date"
                present(alertController, animated: true, completion: nil)
                return false
            } else if dateFormatter.date(from: endDateTextField.text!) == nil || dateFormatter.date(from: startDateTextField.text!) == nil {
                alertController.title = "Invalid Date"
                alertController.message = "Please enter a valid date"
                present(alertController, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
}
