//
//  PatientBasicVC.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-08.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import UIKit

class PatientBasicVC: UIViewController{
    
    //MARK: Properties
    var mPatient:Patient!
    
    
    //MARK: IBOutlets
    
    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var ageValue: UILabel!
    @IBOutlet weak var genderValue: UILabel!
    @IBOutlet weak var roomValue: UILabel!
    @IBOutlet weak var diagValue: UILabel!
    @IBOutlet weak var dateValue: UILabel!
    
    
    override func viewDidLoad() {
        
        if let tbc = self.tabBarController as? PatientDetailTabbarController {
            self.mPatient = tbc.mPatient
            self.nameValue.text = mPatient.name
            self.ageValue.text = mPatient.age
            self.genderValue.text = mPatient.gender
            self.roomValue.text = mPatient.room
            self.diagValue.text = mPatient.diagnosis
            self.dateValue.text = mPatient.date
            
        }
        
        
        
    }
    
    @IBAction func backDidTouched(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}
