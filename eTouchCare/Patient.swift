//
//  Patient.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-07.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct Patient {
    var name: String
    var pid: String
    var room: String
    var gender: String
    var diagnosis: String
    var age: String
    var date: String
    let ref: FIRDatabaseReference?
    
    init(snapshot: FIRDataSnapshot){
        
        self.pid = snapshot.key
        self.name = snapshot.value?["name"] as! String
        self.room = snapshot.value?["room"] as! String
        self.gender = snapshot.value?["gender"] as! String
        self.diagnosis = snapshot.value?["diagnosis"] as! String
        self.age = snapshot.value?["age"] as! String
        self.date = snapshot.value?["date"] as! String
        self.ref = snapshot.ref
        
    }
    
    func toString() -> Any {
        return [
            "pid": pid,
            "name": name,
            "room": room,
            "gender": gender,
            "diagnosis": diagnosis,
            "age": age,
            "date": date
        ]
    }
    
    
//    func snapshotCheck(snapshotValue: String?) -> String {
//        if (snapshotValue != nil) {
//            return snapshotValue as String!
//        }
//        else{
//            return ""
//        }
//    }
    
}
