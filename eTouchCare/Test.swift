//
//  Tests.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-12.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Test {
    var name: String
    var testId: String
    var des: String
    var date: String
    var ref: FIRDatabaseReference?
    
    init(snapshot: FIRDataSnapshot){
        self.testId = snapshot.key
        self.name = snapshot.value?["name"] as! String
        self.des = snapshot.value?["description"] as! String
        self.date = snapshot.value?["date"] as! String
        self.ref = snapshot.ref
    }
    
    func toString() -> Any {
        return [
            "testId": testId,
            "name": name,
            "description": des,
            "date": date
        ]
    }
}