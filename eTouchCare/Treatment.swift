//
//  Treatment.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-12.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Treatment {
    var name: String
    var treatId: String
    var des: String
    var date: String
    var ref: FIRDatabaseReference?
    
    init(snapshot: FIRDataSnapshot){
        self.treatId = snapshot.key
        self.name = snapshot.value?["name"] as! String
        self.des = snapshot.value?["description"] as! String
        self.date = snapshot.value?["date"] as! String
        self.ref = snapshot.ref
    }
    
    func toString() -> Any {
        return [
            "testId": treatId,
            "name": name,
            "description": des,
            "date": date
        ]
    }
}