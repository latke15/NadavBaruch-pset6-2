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
    var details = [shabbatDetails]()
    
    // Firebase
    var databaseRef = FIRDatabase.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.shabbatTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ShabbatCell
        
//        cell.cityLabel = databaseRef.queryOrderedByKey().observe(.childAdded, with: {
//            snapshot in
//            
//            cell.cityLabel = snapshot.value![details[indexPath.row]]
//        })
      
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
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
