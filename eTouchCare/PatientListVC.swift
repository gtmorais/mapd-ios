//
//  PatientList.swift
//  eTouchCare
//
//  Created by Wenzhong Zheng on 2016-12-07.
//  Copyright © 2016 TeamOne. All rights reserved.
//

import UIKit
import FirebaseDatabase

class PatientListVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    
    //MARK: Constants
    let patientCellIdentifier = "CellPatients"
    
    //MARK: Properties
    let basicRef = FIRDatabase.database().referenceWithPath("Basic")
    var patients = [Patient]()
    
    
    
    override func viewDidLoad() {
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
//        self.basicRef.childByAutoId().setValue(["name":"Bily","room":"114","gender":"male","diagnosis":"Flu","age":"18","date":"September 14,2016"])
//        
//        self.basicRef.childByAutoId().setValue(["name":"Pop","room":"110","gender":"female","diagnosis":"Ear Infection","age":"14","date":"March 24,2016"])
//        
//        self.basicRef.childByAutoId().setValue(["name":"Gardan","room":"10","gender":"male","diagnosis":"Headache","age":"38","date":"November 22,2016"])
//        
//        self.basicRef.childByAutoId().setValue(["name":"Plod","room":"114","gender":"male","diagnosis":"Flu","age":"18","date":"September 14,2016"])
//        
//        self.basicRef.childByAutoId().setValue(["name":"Cood","room":"204","gender":"female","diagnosis":"Broken Leg","age":"19","date":"January 14,2016"])

        
        
        fireBaseListener()
    }
    
    func fireBaseListener() {
        basicRef.observeEventType(.ChildAdded, withBlock: { snapshot in
            let patient = Patient.init(snapshot: snapshot)
            self.patients.append(patient)
//            print(patient.toString())

            self.tableView.reloadData()
        })
    }
    
    
    
    
    //MARK: tableView section
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.patients.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCellWithIdentifier(patientCellIdentifier, forIndexPath: indexPath) as! PatientListCell
        
        let patient = patients[indexPath.row]
        
        cell.name.text = patient.name
        cell.diagnosis.text = patient.diagnosis
        cell.age.text = patient.age
        cell.room.text = patient.room
//        if patient.gender == "male" {
//            cell.imageView?.image = UIImage(named: "male")
//        }
//        else{
//            cell.imageView?.image = UIImage(named: "female")
//        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        performSegueWithIdentifier("toDetail", sender: tableView.cellForRowAtIndexPath(indexPath))
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        
        
        
        
        
        let selectedCell = sender as? PatientListCell
        let indexPath = tableView.indexPathForCell(selectedCell!)
//        let des = segue.destinationViewController.childViewControllers[0] as! PatientBasicVC
//        des.mPatient = self.patients[(indexPath?.row)!]
        let des = segue.destinationViewController as! PatientDetailTabbarController
        des.mPatient = self.patients[(indexPath?.row)!]
        
        
        
        
        
    
    }
    
}
