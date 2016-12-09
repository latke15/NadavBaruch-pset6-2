//
//  SecondViewController.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 06-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit
import Firebase

class SecondViewController: UIViewController {
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var candleLighting: UILabel!
    @IBOutlet weak var havdalaLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    var shabbatTime: String = ""
    var place: String = ""
    var havdalaTime: String = ""
    
    // Firebase
    var rootRef = FIRDatabase.database().reference()
    var placeRef = FIRDatabase.database().reference(withPath: self.place)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        candleLighting.text = shabbatTime
        placeLabel.text = place
        havdalaLabel.text = havdalaTime
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addToFirebase(_ sender: Any) {
        // Firebase
        let shabbatTimeRef = self.rootRef.child("shabbat time")
        shabbatTimeRef.setValue(self.shabbatTime)
        let havdalaTimeRef = self.rootRef.child("havdala time")
        havdalaTimeRef.setValue(self.havdalaTime)
        let placeRef = self.rootRef.child("place")
        placeRef.setValue(self.place)
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "thirdVCID", sender: sender)
        }
    }
    
    // check if we go to 3rd VC
    if segue.identifier == "thirdVCID" {
        if let destination = segue.destination as? ShabbatTableViewController {
        destination.place = self.place
    }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
