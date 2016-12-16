//
//  ViewController.swift
//  NadavBaruch-pset6
//
//  The controller where you can look for a place or go to ShabbatTableViewController.
//
//  Created by Nadav Baruch on 06-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    
    // User defaults
    let defaults = UserDefaults.standard
    
    // Outlets
    @IBOutlet weak var countryCodeInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    
    // Variables
    var myJSON: NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // source: http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
        // Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // source: http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
    // Calls this function when the tap is recognized.
    func dismissKeyboard() {
        // Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    @IBAction func checkShabbat(_ sender: Any) {
        if countryCodeInput.text == "" || cityInput.text == "" {
            showAlertView(title: "Attention!", withDescription: "You forgot your input!", buttonText: "Understood!")
        }
        
        let countryCode = countryCodeInput.text
        let countryCodeNoSpace = countryCode?.replacingOccurrences(of: " ", with: "")
        let city = cityInput.text
        let cityNoSpace = city?.replacingOccurrences(of: " ", with: "")
        
        
        // Load the JSON
        let url = URL(string: "https://www.hebcal.com/shabbat/?cfg=json&city=" + (countryCodeNoSpace?.uppercased())! + "-" + cityNoSpace! + "&m=50")
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard error == nil else {
                self.showAlertView(title:"Attention!", withDescription:"Error occured!", buttonText:"Understood!")
                print("error!")
                return
            }
            guard let data = data else {
                self.showAlertView(title:"Attention!", withDescription:"No data could be found!", buttonText:"Understood!")
                print("Data is empty")
                return
            }
            
            // Get status code
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 400{
                self.showAlertView(title:"Attention!", withDescription:"Bad request, please contact the administrator.", buttonText:"Understood!")
            }
            if httpResponse.statusCode == 500{
                self.showAlertView(title:"Attention!", withDescription:"Internal server error, please contact the administrator.", buttonText:"Understood!")
            }
            
            if httpResponse.statusCode == 200{
                print("Succeed to maintain data!")
            }
            
            // Get the JSON
            self.myJSON = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            var items: NSArray = []
            let item = self.myJSON.value(forKey: "items")
            if item != nil{
                items = self.myJSON.value(forKey: "items") as! NSArray
                let item0 = items[0] as! NSDictionary
                let item1 = items[1] as! NSDictionary
                let item2 = items[2] as! NSDictionary
                
                self.defaults.set(item0.value(forKey: "title"), forKey: "shabbesTime")
                self.defaults.set(item2.value(forKey: "title"), forKey: "havdalaTime")
                self.defaults.set(self.myJSON.value(forKey: "title"), forKey: "place")
                self.defaults.set(item1.value(forKey: "hebrew"), forKey: "hebrewParasa")
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "secondVCID", sender: sender)
                }
            }
            else{
                OperationQueue.main.addOperation {
                    self.showAlertView(title:"Attention!", withDescription:"Try different input! The country code or the city is not available.", buttonText:"Understood!")
                }
            }
        }
        task.resume()
    }

    // Check if JSON returns required data
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if myJSON.value(forKey: "error") != nil{
            return false
        }
        return true
    }
    
    // Show an alert
    func showAlertView(title: String, withDescription description: String, buttonText text: String) {
        let alertController = UIAlertController(title: title, message: description, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: text, style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
