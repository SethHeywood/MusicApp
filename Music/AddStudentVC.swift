//
//  AddStudentVC.swift
//  Music
//
//  Created by Jacob Jorgensen on 3/31/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

import UIKit
import Parse

class AddStudentVC: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var lessonPriceField: UITextField!
    var lessonPriceFieldValue: NSDecimalNumber {
        get {
                return NSDecimalNumber(string: self.lessonPriceField.text)
        }
    }
    var students: Students {
        get {
            return Students.sharedInstance
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.firstNameField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addStudent(sender: UIButton) {
        if (self.firstNameField.text == "" || self.lastNameField.text == "" || self.lessonPriceField.text == "") {
            
            var alert = UIAlertController(title: "All Fields Are Required", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }
        else {
            let newStudent = Student(firstName: self.firstNameField.text, lastName: self.lastNameField.text, lessonPrice: self.lessonPriceFieldValue, currentBalance: NSDecimalNumber.zero())
            students.students.append(newStudent)
            saveStudentToParse(newStudent)
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func cancelModal(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveStudentToParse(student: Student) {
        var studentData = PFObject(className:"Students")
        studentData["firstName"] = student.firstName
        studentData["lastName"] = student.lastName
        studentData["lessonPrice"] = MoneyUtilities.decimalNumberToDollarString(student.studentAccount.lessonPrice)
        studentData["currentBalance"] = MoneyUtilities.decimalNumberToDollarString(student.studentAccount.currentBalance)
        studentData.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                println("Error saving student object")
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
