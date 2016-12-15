//
//  AddNewPatientVC.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-13.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddNewPatientVC: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate {
    
    var name: String?
    var room: String?
    var gender: String?
    var diagnosis: String?
    var age: String?
    var date: String!
    //Mark: Contants
    let genderOption = ["Male","Female","Other"]
    
    let basicRef = FIRDatabase.database().referenceWithPath("Basic")
    
    
    //Mark: IBOutlets
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var ageTF: UITextField!

    @IBOutlet weak var genderTF: UITextField!
    
    @IBOutlet weak var roomTF: UITextField!
    @IBOutlet weak var diagTF: UITextField!
    
    @IBOutlet weak var mPicker: UIPickerView!
    
    override func viewDidLoad() {
        
        self.mPicker.delegate = self
        self.mPicker.dataSource = self
        
        
    }
    
    //Mark: ACTIONS
    
    @IBAction func cancelDidTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveDidTouched(sender: AnyObject) {
        self.name = nameTF.text
        self.age = ageTF.text
        self.gender = genderTF.text
        self.diagnosis = diagTF.text
        self.room = roomTF.text
        let tempDate = NSDate()
        self.date = NSDateFormatter.localizedStringFromDate(tempDate, dateStyle: .MediumStyle, timeStyle: .NoStyle)
        
        basicRef.childByAutoId().setValue(["name":name,"age":age,"gender":gender,"room":room,"diagnosis":diagnosis,"date":date])
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Mark: Picker View section
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderOption.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        self.view.endEditing(true)
        return genderOption[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.genderTF.text = self.genderOption[row]
        self.mPicker.hidden = true
    }
    
    
    //Mark: TextField manage
    func textFieldDidBeginEditing(textField: UITextField) {
        
        if textField == self.genderTF{
            textField.endEditing(true)
            self.mPicker.hidden = false
//
//            self.nameTF.endEditing(true)
//            self.ageTF.endEditing(true)
//            self.diagTF.endEditing(true)
        }
    }

    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.mPicker.hidden = true
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    
}
