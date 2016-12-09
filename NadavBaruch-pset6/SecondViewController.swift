//
//  SecondViewController.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 06-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var candleLighting: UILabel!
    @IBOutlet weak var havdalaLabel: UILabel!
    
    var shabbatTime: String = ""
    var place: String = ""
    var havdalaTime: String = ""
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
