//
//  PatientTestsVC.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-12.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PatientTestsVC: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    var mPatient: Patient!
    let TestCellIdentifier = "TestCell"
    var testRef: FIRDatabaseReference!
    var tests = [Test]()
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func backDidTouched(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    @IBAction func addDidTouched(sender: AnyObject) {
        
        performSegueWithIdentifier("toAdd", sender: self)
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        //        let selectedCell = sender as? DiagnosisCell
        //        let indexPath = tableView.indexPathForCell(selectedCell!)
        let des = segue.destinationViewController as! AddNewRecord
        des.mPatient = self.mPatient
        des.mTitle = "Add New Test"
        des.baseRef = testRef
        
    }
    
    
    override func viewDidLoad() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        if let tbc = self.tabBarController as? PatientDetailTabbarController{
            self.mPatient = tbc.mPatient
            testRef = FIRDatabase.database().referenceWithPath("Tests/"+mPatient.pid)
        
//            
//            self.testRef.childByAutoId().setValue(["name":"Blood Pressure","description":"very bad","date":"September 14,2016"])
//            self.testRef.childByAutoId().setValue(["name":"Heart Rate","description":"70 / min","date":"November 22,2016"])
//            self.testRef.childByAutoId().setValue(["name":"CT","description":"Fine","date":"January 14,2016"])
//            self.testRef.childByAutoId().setValue(["name":"MIT","description":"Fine","date":"March 24,2016"])
            
            
            testRef!.observeEventType(.ChildAdded, withBlock: {snapshot in
                
                self.tests.append(Test.init(snapshot: snapshot))
                self.tableView.reloadData()
                
                
            })
            
            testRef.observeEventType(.ChildRemoved, withBlock: { snapshot in
                for test in self.tests {
                    if test.testId == snapshot.key {
                        //have to define model Patient as class instead of struct inorder to find the index
                        self.tests.removeAtIndex(self.tests.indexOf(test)!)
                        self.tableView.reloadData()
                    }
                }
                
                
            })

            
        
        }
        
        
        
        
    }
    
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tests.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TestCellIdentifier, forIndexPath: indexPath) as! TestCell
        
        cell.nameValue.text = tests[indexPath.row].name
        cell.desValue.text = tests[indexPath.row].des
        cell.dateValue.text = tests[indexPath.row].date
        
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            
            //remove all related detail values from the targeted pid
            let targetRecordId = tests[indexPath.row].testId
            let deleteRef = FIRDatabase.database().referenceWithPath("Tests/"+mPatient.pid+"/"+targetRecordId)
            deleteRef.removeValue()
            
        }
    }

}
