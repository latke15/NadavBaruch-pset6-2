//
//  ShabbatTableViewController.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 09-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit
import Firebase
import EventKit

class ShabbatTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var shabbatTable: UITableView!

    // variable
    var details = [shabbatDetails]()
    
    // Firebase
    var rootRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating references ordered by place
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

    // Table functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.shabbatTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShabbatCell
        let shabbatDetails = self.details[indexPath.row]
        
        cell.cityLabel.text = shabbatDetails.place
        cell.shabbatTime.text = shabbatDetails.shabbatTime
        cell.havdalaTime.text = shabbatDetails.havdalaTime
        cell.hebrewParasa.text = shabbatDetails.hebrewParasa
      
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
}
