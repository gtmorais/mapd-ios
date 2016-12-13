//
//  PatientDiagnosisVC.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-12.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PatientDiagnosisVC: UIViewController,UITableViewDelegate,UITableViewDataSource {

    let DiagnosisCellIdentifier = "DiagnosisCell"
    var mPatient:Patient!
    var diagRef:FIRDatabaseReference!
    var diagnosises = [Diagnosis]()
    @IBAction func navBackDidTouched(sender: AnyObject) {
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
        des.mTitle = "Add New Diagnosis"
        des.baseRef = diagRef
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        

        
        
        if let tbc = self.tabBarController as? PatientDetailTabbarController{
            self.mPatient = tbc.mPatient
            diagRef = FIRDatabase.database().referenceWithPath("Diagnosis/"+mPatient.pid)
            
//            self.diagRef.childByAutoId().setValue(["name":"Flu","description":"very bad","date":"September 14,2016"])
//            self.diagRef.childByAutoId().setValue(["name":"Headache","description":"since one week ago","date":"November 22,2016"])
//            self.diagRef.childByAutoId().setValue(["name":"Cold","description":"two weeks ago","date":"January 14,2016"])
//            self.diagRef.childByAutoId().setValue(["name":"Plod","description":"Ear Infection","date":"March 24,2016"])
//            
//            
            
            
            diagRef!.observeEventType(.ChildAdded, withBlock: {snapshot in
                
                self.diagnosises.append(Diagnosis.init(snapshot: snapshot))
                self.tableView.reloadData()
            
            
            })
            
            
            
        }
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diagnosises.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(DiagnosisCellIdentifier, forIndexPath: indexPath) as! DiagnosisCell
        
        cell.nameValue.text = diagnosises[indexPath.row].name
        cell.desValue.text = diagnosises[indexPath.row].des
        cell.dateValue.text = diagnosises[indexPath.row].date
        
        return cell
    }
    
}
