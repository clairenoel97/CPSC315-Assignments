//
//  TripDetailViewController.swift
//  Traveler
//
//  this class represents the detail page for a trip
//  shows the destination, dates, and photo
//  CPSC315-01, Fall 2018
//  Programming Assignment #6
//  No sources to cite
//
//  Created by Norman, Claire Noel on 10/27/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

//DONE
import UIKit

class TripDetailViewController: UIViewController {
    
    //properties
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var endDateLabel: UILabel!
    var trip : Trip? = nil
    let dateFormatter = DateFormatter()
    var countStr = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        displayTrip()
        countLabel.text = countStr
    }

    //controls how the information will be displayed
    //shows an image if there is one connected
    func displayTrip() {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        if let trip = trip {
            
            destinationLabel.text = "\(trip.destinationName)"
            startDateLabel.text = "\(dateFormatter.string(from: trip.startDate))"
            endDateLabel.text = "\(dateFormatter.string(from: trip.endDate))"
            if let image = trip.imageFileName {
                imageView.image = UIImage(named: image)
            } else {
                imageView.image = nil
            }
        }
    }
}
