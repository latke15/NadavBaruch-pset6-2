//
//  ShabbatCell.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 09-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import UIKit

class ShabbatCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var shabbatTime: UILabel!
    @IBOutlet weak var havdalaTime: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
