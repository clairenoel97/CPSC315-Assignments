//
//  TripTableViewController.swift
//  Traveler
//
//  this file represents the main table view that the user comes to
//  the table view holds reusable cells
//  each cell has information and a picture that represents a trip
//  there is an initialized trip list that contains 5 trips
//  allows for manilpulation of the table view
//  contains 2 segues
    //  add a trip and destination details
//  table view can be updated with new trips
//  CPSC315-01, Fall 2018
//  Programming Assignment #6
//  app icon: <div>Icons made by <a href="https://www.flaticon.com/authors/vectors-market" title="Vectors Market">Vectors Market</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
//
//  Created by Norman, Claire on 10/27/18.
//  Copyright © 2018 Norman, Claire. All rights reserved.
//

import UIKit

class TripTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //properties
    var trips = [Trip]()
    let dateFormatter = DateFormatter()
    @IBOutlet weak var tableView: UITableView!
    
    //call initializeTrips within the viewOnlod class
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        initializeTrips()
    }
    
    
    //initializes 5 trips and two have image files
    func initializeTrips() {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        trips.append(Trip(destination: "Hawaii", start: dateFormatter.date(from: "08/09/2018")!, end: dateFormatter.date(from: "08/23/2018")!, image: "hawaii"))
        trips.append(Trip(destination: "Carribean", start: dateFormatter.date(from: "11/08/2018")!, end: dateFormatter.date(from: "11/21/2018")!, image: nil))
        trips.append(Trip(destination: "Alaska", start: dateFormatter.date(from: "05/15/2019")!, end: dateFormatter.date(from: "07/21/2019")!, image: "alaska"))
        trips.append(Trip(destination: "Bora Bora", start: dateFormatter.date(from: "12/10/2018")!, end: dateFormatter.date(from: "01/22/2018")!, image: "borabora"))
        trips.append(Trip(destination: "Jamaica", start: dateFormatter.date(from: "01/01/2018")!, end: dateFormatter.date(from: "01/20/2018")!, image: "jamaica"))
    }

    //this keeps track of the row number
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return trips.count
        }
        return 0
    }
    
    //allows for manipulation of the cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripCell", for: indexPath) as! TripTableViewCell
        let trip = trips[indexPath.row]
        cell.update(with: trip)
        cell.imageView?.contentMode = .scaleAspectFit
        //allows us to re order the list of the trips
        cell.showsReorderControl = true
        return cell
    }
    
    //allows for insertion of a cell that has been reordered
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let trip = trips.remove(at: sourceIndexPath.row)
        trips.insert(trip, at: destinationIndexPath.row)
        tableView.reloadData()
    }
    
    //handles if a cell is deleted
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            trips.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    //this handles if the user wants to view details of a specific trip
    //also handles if the user wants to add a new trip to the list
    //takes the user to the new views
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "DetailSegue" {
                print("Looking at the trip details")
                if let detailTripVC = segue.destination as? TripDetailViewController {
                    
                    if let indexPath = tableView.indexPathForSelectedRow {
                        detailTripVC.countStr = "Trip \(indexPath.row + 1) of \(trips.count)"
                        let trip = trips[indexPath.row]
                        print("HI \(indexPath.row)")
                        detailTripVC.trip = trip
                        
                    }
                }
            }
            else if identifier == "AddSegue" {
                print("Adding a trip")
                if let addTripVC = segue.destination as? AddTripViewController {
                    addTripVC.countStr = "Add trip #\(trips.count + 1)"
                    if let indexPath = tableView.indexPathForSelectedRow {
                        addTripVC.countStr = "Add trip #\(trips.count + 1)"
                        let trip = trips[indexPath.row]
                        addTripVC.trip = trip
                    }
                }
            }
        }
    }
    
    //this allows the use to press the edit button
    //when pressed, the user will be allowed to switch the order of the list or delete rows
    @IBAction func editBarButtonPressed(_ sender: UIBarButtonItem) {
        let newEditing = !tableView.isEditing
        tableView.setEditing(newEditing, animated: true)
        
    }
    
    //takes information from the add trip page
    //then populates a new cell on the table view with the new information
    @IBAction func unwindToTripTableVC(segue: UIStoryboardSegue) {
        print("unwinding")
        
        if let identifier = segue.identifier {
            if identifier == "SaveUnwindSegue" {
                if let tripAddVC = segue.source as? AddTripViewController {
                    
                    if let trip = tripAddVC.trip {
                        trips.append(trip)
                        tableView.reloadData()
                    }
                }
            }
            else if identifier == "cancelSegue" {
                print("HI")
            }
        }
    }
    
}

