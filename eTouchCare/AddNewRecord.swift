//
//  AddNewRecord.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-12.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddNewRecord: UIViewController {

    var mPatient:Patient!
    var mTitle = "Title"
    var baseRef: FIRDatabaseReference?
    
    @IBOutlet weak var navTitle: UINavigationItem!
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        navTitle.title = mTitle
        
    }
    
    @IBAction func backDidTouched(sender: AnyObject) {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveDidTouched(sender: AnyObject) {
//        self.treatRef.childByAutoId().setValue(["name":"Rest","description":"2 weeks","date":"September 14,2016"])

        let name = nameField.text ?? "No Input"
        let des = descriptionField.text ?? "No Input"
        let newDate = NSDateFormatter.localizedStringFromDate(datePicker.date, dateStyle: .FullStyle, timeStyle: .ShortStyle)
        
        self.baseRef?.childByAutoId().setValue(["name":name,"description":des,"date":newDate])
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
