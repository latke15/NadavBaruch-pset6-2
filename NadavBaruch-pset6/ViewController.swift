//
//  ViewController.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 06-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController {
    @IBOutlet weak var introduction: UITextView!
    @IBOutlet weak var countryCodeInput: UITextField!
    @IBOutlet weak var cityInput: UITextField!
    
    // variables
    var shabbatTime: String = ""
    var place: String = ""
    var havdalaTime: String = ""
    var hebrewParasa: String = ""
    var myJSON: NSDictionary = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        introduction.text = "Fill in your landcode and city and get the time shabbat starts at! Please make sure the landcode is in capital letters and the city starts with a capital letter!"
        introduction.isEditable = false
        
        // source: http://stackoverflow.com/questions/24126678/close-ios-keyboard-by-touching-anywhere-using-swift
        // Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        
        // Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        // tap.cancelsTouchesInView = false
        
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
        let city = cityInput.text
        
        let url = URL(string: "https://www.hebcal.com/shabbat/?cfg=json&city=" + countryCode! + "-" + city! + "&m=50")
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
            
            
            self.myJSON = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            
            var items: NSArray = []
            let item = self.myJSON.value(forKey: "items")
            if item != nil{
                items = self.myJSON.value(forKey: "items") as! NSArray
                let item0 = items[0] as! NSDictionary
                let item1 = items[1] as! NSDictionary
                let item2 = items[2] as! NSDictionary
                
                self.shabbatTime = item0.value(forKey: "title") as! String
                self.havdalaTime = item2.value(forKey: "title") as! String
                self.place = self.myJSON.value(forKey: "title") as! String
                self.hebrewParasa = item1.value(forKey: "hebrew") as! String
                
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "secondVCID", sender: sender)
                }
            }
            else{
                OperationQueue.main.addOperation {
                    self.showAlertView(title:"Attention!", withDescription:"Try another city!", buttonText:"Understood!")
                }
            }
        }
        task.resume()
    }

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
    
    // segue contents to the rawtext variable in the the next view
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // check if we go to 2nd VC
        if segue.identifier == "secondVCID" {
            if let destination = segue.destination as? SecondViewController {
                destination.shabbatTime = self.shabbatTime
                destination.place = self.place
                destination.havdalaTime = self.havdalaTime
                destination.hebrewParasa = self.hebrewParasa
            }
        }
    }}
//    override func encodeRestorableState(with coder: NSCoder) {
//        if let name = nameTextField.text {
//            coder.encode(name, forKey: "name")
//        }
//        super.encodeRestorableState(with: coder)
//    }
//
//    override func decodeRestorableState(with coder: NSCoder) {
//        if let imageData = coder.decodeObject(forKey: "image") as? Data {
//            profileImageView.image = UIImage(data: imageData)
//        }
//        super.decodeRestorableState(with: coder)
//    }
//}
//extension ViewController: UIViewControllerRestoration{
//    static func viewControllerWithRestorationIdentifierPath(identifierComponents: [AnyObject],
//                                                                coder: NSCoder) -> UIViewController? {
//        let vc = ViewController()
//        return vc
//        }
//    }
