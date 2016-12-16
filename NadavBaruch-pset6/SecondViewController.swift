//
//  SecondViewController.swift
//  NadavBaruch-pset6
//
//  A view where the results from the ViewController are shown.
//
//  Created by Nadav Baruch on 06-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class SecondViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var candleLighting: UILabel!
    @IBOutlet weak var havdalaLabel: UILabel!
    @IBOutlet weak var hebrewParasaLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    // Variables
    var shabbatTime: String = ""
    var place: String = ""
    var havdalaTime: String = ""
    var hebrewParasa: String = ""
    var details = [shabbatDetails]()
    
    // User defaults
    let defaults = UserDefaults.standard
    
    // Firebase
    var rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        shabbatTime = defaults.string(forKey: "shabbesTime")!
        havdalaTime = defaults.string(forKey: "havdalaTime")!
        place = defaults.string(forKey: "place")!
        hebrewParasa = defaults.string(forKey: "hebrewParasa")!
        
        // Do any additional setup after loading the view.
        candleLighting.text = shabbatTime
        placeLabel.text = place
        havdalaLabel.text = havdalaTime
        hebrewParasaLabel.text = hebrewParasa
    }
    
    @IBAction func addToFirebase(_ sender: Any) {
        
        self.details.insert(shabbatDetails(shabbatTime: self.shabbatTime, place: self.place, havdalaTime: self.havdalaTime, hebrewParasa: self.hebrewParasa), at: 0)
        
        let shabbatItem = shabbatDetails(shabbatTime: self.shabbatTime,
                                      place: self.place,
                                      havdalaTime: self.havdalaTime,
                                      hebrewParasa: self.hebrewParasa)
        let shabbatItemRef = self.rootRef.child(place.lowercased())

        shabbatItemRef.setValue(shabbatItem.toAnyObject())
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "thirdVCID", sender: sender)
            // segue contents to the rawtext variable in the the next view
            func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                // check if we go to 3rd VC
                if segue.identifier == "thirdVCID" {
                    if let destination = segue.destination as? ShabbatTableViewController {
                        destination.details = self.details
                    }
                }
            }
        }
    }
}
