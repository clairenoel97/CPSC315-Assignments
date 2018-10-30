//
//  TripTableViewCell.swift
//  Traveler
//  this program provides properties and methods for a trip cell
//  each cell has a destination, dates, and an image
//  CPSC315-01, Fall 2018
//  Programming Assignment #6
//  No sources to cite
//
//  Created by Norman, Claire Noel on 10/27/18.
//  Copyright © 2018 Norman, Claire Noel. All rights reserved.
//

//DONE
import UIKit

//this updates all the information in a given cell
class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var tripImageView: UIImageView!
    @IBOutlet weak var tripNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    let dateFormatter = DateFormatter()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //initialize the labels to show the trip information
    //sets the labels and images to user input
    //doesn't allow for users to add pictures
    func update(with trip: Trip) {
        dateFormatter.dateFormat = "MM/dd/yyyy"
        tripNameLabel.text = trip.destinationName
        let dateStr = "\(dateFormatter.string(from: trip.startDate)) - \(dateFormatter.string(from: trip.endDate))"
        dateLabel.text = dateStr
        if let image = trip.imageFileName {
            tripImageView.image = UIImage(named: image)
        } else {
            tripImageView.image = nil
        }
    }

}
