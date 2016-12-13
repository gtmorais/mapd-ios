//
//  PatientTreatmentVC.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-12.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PatientTreatmentVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var mPatient: Patient!
    let TreatmentCellIdentifier = "TreatmentCell"
    var treatRef: FIRDatabaseReference!
    var treatments = [Treatment]()
    
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
        des.mTitle = "Add New Treatment"
        des.baseRef = treatRef
    }
    
    
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        if let tbc = self.tabBarController as? PatientDetailTabbarController{
            self.mPatient = tbc.mPatient
            treatRef = FIRDatabase.database().referenceWithPath("Treatments/"+mPatient.pid)
            
            
//                        self.treatRef.childByAutoId().setValue(["name":"Rest","description":"2 weeks","date":"September 14,2016"])
//                        self.treatRef.childByAutoId().setValue(["name":"Drink water","description":"3 L/Day","date":"November 22,2016"])
//                        self.treatRef.childByAutoId().setValue(["name":"antibiotic","description":"5 days","date":"January 14,2016"])
//                        self.treatRef.childByAutoId().setValue(["name":"MIT","description":"Fine","date":"March 24,2016"])
            
            
            treatRef!.observeEventType(.ChildAdded, withBlock: {snapshot in
                
                self.treatments.append(Treatment.init(snapshot: snapshot))
                self.tableView.reloadData()
                
                
            })
            
            treatRef.observeEventType(.ChildRemoved, withBlock: { snapshot in
                for treat in self.treatments {
                    if treat.treatId == snapshot.key {
                        //have to define model Patient as class instead of struct inorder to find the index
                        self.treatments.removeAtIndex(self.treatments.indexOf(treat)!)
                        self.tableView.reloadData()
                    }
                }
                
                
            })


        
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treatments.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(TreatmentCellIdentifier, forIndexPath: indexPath) as! TreatmentCell
        
        cell.nameValue.text = treatments[indexPath.row].name
        cell.desValue.text = treatments[indexPath.row].des
        cell.dateValue.text = treatments[indexPath.row].date
        
        
        return cell
        
        
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            
            //remove all related detail values from the targeted pid
            let targetRecordId = treatments[indexPath.row].treatId
            let deleteRef = FIRDatabase.database().referenceWithPath("Treatments/"+mPatient.pid+"/"+targetRecordId)
            deleteRef.removeValue()
            
        }
    }
}
