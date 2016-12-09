//
//  ViewController.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-07.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginVC: UIViewController {
    //MARK CONTANTS
    let toPatientList = "toPatientList"
    
    
    //MARK: IBOulets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var infoLbl: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginDidTouched(sender: AnyObject) {
        FIRAuth.auth()!.createUserWithEmail(emailField.text!, password: passwordField.text!, completion: { user, error in
            if error != nil {
                self.login()
            }
            else {
                self.infoLbl.textColor = UIColor.greenColor()
                self.infoLbl.text = "User Created"
                self.login()
            }
        })
        
    }
    
    @IBAction func devLoginDidTouched(sender: AnyObject) {
        FIRAuth.auth()!.signInWithEmail("123@gmail.com", password: "123456", completion: { user,error in
            if error != nil {
                self.infoLbl.textColor = UIColor.redColor()
                self.infoLbl.text = error?.localizedDescription
            }
            else {
                self.infoLbl.textColor = UIColor.greenColor()
                self.infoLbl.text = "Success"
                self.performSegueWithIdentifier(self.toPatientList, sender: nil)
            }
        })
        
    }
    
    func login()  {
        FIRAuth.auth()!.signInWithEmail(emailField.text!, password: passwordField.text!, completion: { user,error in
            if error != nil {
                self.infoLbl.textColor = UIColor.redColor()
                self.infoLbl.text = error?.localizedDescription
            }
            else {
                self.infoLbl.textColor = UIColor.greenColor()
                self.infoLbl.text = "Success"
                self.performSegueWithIdentifier(self.toPatientList, sender: nil)
            }
        })
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}

