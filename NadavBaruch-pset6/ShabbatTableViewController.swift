//
//  ShabbatTableViewController.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 09-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit
import Firebase

class ShabbatTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var shabbatTable: UITableView!

    // variables
    var shabbatTime: String = ""
    var place: [String] = []
    var havdalaTime: String = ""
    var hebrewParasa: String = ""
    var details = [shabbatDetails]()
    
    // Firebase
    var rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        rootRef.queryOrdered(byChild: "place").observe(.value, with: { snapshot in
            var shabbatItems: [shabbatDetails] = []
            
            for item in snapshot.children {
                let shabbatItem = shabbatDetails(snapshot: item as! FIRDataSnapshot)
                shabbatItems.append(shabbatItem)
            }
            
            self.details = shabbatItems
            self.shabbatTable.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.shabbatTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShabbatCell
        let shabbos = self.details[indexPath.row]
        
        cell.cityLabel.text = shabbos.place
        cell.shabbatTime.text = shabbos.shabbatTime
        cell.havdalaTime.text = shabbos.havdalaTime
        cell.hebrewParasa.text = shabbos.hebrewParasa
      
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            let shabbatItem = details[indexPath.row]
            shabbatItem.ref?.removeValue()
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
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
