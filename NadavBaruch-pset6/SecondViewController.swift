//
//  SecondViewController.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 06-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SecondViewController: UIViewController {
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var candleLighting: UILabel!
    @IBOutlet weak var havdalaLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var shabbatTime: String = ""
    var place: String = ""
    var havdalaTime: String = ""
    var details = [shabbatDetails]()
    
    // Firebase
    var rootRef = FIRDatabase.database().reference()
//    var placeRef = FIRDatabase.database().reference(withPath: self.place)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        candleLighting.text = shabbatTime
        placeLabel.text = place
        havdalaLabel.text = havdalaTime
        
    }
    
    @IBAction func addToFirebase(_ sender: Any) {
        
        self.details.insert(shabbatDetails(shabbatTime: self.shabbatTime, place: self.place, havdalaTime: self.havdalaTime), at: 0)
        
        let shabbatItem = shabbatDetails(shabbatTime: self.shabbatTime,
                                      place: self.place,
                                      havdalaTime: self.havdalaTime)
        let shabbatItemRef = self.rootRef.child(place.lowercased())
        
        shabbatItemRef.setValue(shabbatItem.toAnyObject())

        
        // Firebase
//        let shabbatTimeRef = self.rootRef.child("shabbat time")
//        shabbatTimeRef.setValue(self.shabbatTime)
//        let havdalaTimeRef = self.rootRef.child("havdala time")
//        havdalaTimeRef.setValue(self.havdalaTime)
//        let placeRef = self.rootRef.child("place")
//        placeRef.setValue(self.place)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "thirdVCID", sender: sender)
            // segue contents to the rawtext variable in the the next view
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // check if we go to 3rd VC
                if segue.identifier == "thirdVCID" {
                    if let destination = segue.destination as? ShabbatTableViewController {
                        destination.place = [self.place]
                        destination.details = self.details
                    }
                }
            }
        }
    }
}
