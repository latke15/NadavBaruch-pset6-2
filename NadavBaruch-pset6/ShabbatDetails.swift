//
//  ShabbatDetails.swift
//  NadavBaruch-pset6
//
//  Created by Nadav Baruch on 11-12-16.
//  Copyright © 2016 Nadav Baruch. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

struct shabbatDetails {
    
    let shabbatTime: String
    let place: String
    let havdalaTime: String
    let hebrewParasa: String
    let ref: FIRDatabaseReference?
    
    init(shabbatTime: String, place: String, havdalaTime: String, hebrewParasa: String){
        
        self.shabbatTime = shabbatTime
        self.place = place
        self.havdalaTime = havdalaTime
        self.hebrewParasa = hebrewParasa
        self.ref = nil
    }
    
    init(snapshot: FIRDataSnapshot) {
        let snapshotValue = snapshot.value as! [String: AnyObject]
        shabbatTime = snapshotValue["shabbatTime"] as! String
        place = snapshotValue["place"] as! String
        havdalaTime = snapshotValue["havdalaTime"] as! String
        hebrewParasa = snapshotValue["hebrewParasa"] as! String
        ref = snapshot.ref
    }
    
    func toAnyObject() -> Any {
        return [
            "shabbatTime": shabbatTime,
            "place": place,
            "havdalaTime": havdalaTime,
            "hebrewParasa": hebrewParasa
        ]
    }
}
