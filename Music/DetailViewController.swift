//
//  DetailViewController.swift
//  Music
//
//  Created by Jacob Jorgensen on 3/31/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

import UIKit
import Parse

class DetailViewController: UIViewController {

    var student: Student!
    var currentBalance: NSDecimalNumber! {
        get {
            return self.student.studentAccount.currentBalance
        }
    }
    @IBOutlet weak var lessonBalanceLabel: UILabel!
    @IBOutlet weak var lessonsRemainingLabel: UILabel!
    @IBOutlet weak var lessonCostLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateBalance()
        self.lessonCostLabel.text = "Note: \(student.firstName)'s Lessons Cost \(MoneyUtilities.decimalNumberToDollarString(student.studentAccount.lessonPrice))"
    }
    
    override func viewWillDisappear(animated: Bool) {
        saveCurrentBalance()
    }
    
    func updateBalance() {
        self.lessonBalanceLabel.text = MoneyUtilities.decimalNumberToDollarString(student.studentAccount.currentBalance)
        var lessonsRemaining = student.studentAccount.currentBalance.decimalNumberByDividingBy(student.studentAccount.lessonPrice)
        self.lessonsRemainingLabel.text = MoneyUtilities.decimalNumberToString(lessonsRemaining)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addPayment(sender: UIButton) {
        
        var alertController = UIAlertController(title: "Add Funds to Account", message: "", preferredStyle: .Alert)
        
        alertController.addTextFieldWithConfigurationHandler(
            {(textField: UITextField!) in
                textField.placeholder = "Enter dollar amount"
                textField.keyboardType = UIKeyboardType.NumberPad
        })
        
        let action = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {[weak self] (paramAction:UIAlertAction!) in
            if let textFields = alertController.textFields{
                var theTextFields = textFields as! [UITextField]
                let enteredText = theTextFields[0].text
                self?.student.studentAccount.currentBalance = self?.currentBalance.decimalNumberByAdding(NSDecimalNumber(string: enteredText))
                self?.updateBalance()
            }
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: {[weak self] (paramAction:UIAlertAction!) in

        })
        
        alertController.addAction(action)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func lessonTaught(sender: UIButton) {
        self.student.studentAccount.currentBalance = self.currentBalance.decimalNumberBySubtracting(self.student.studentAccount.lessonPrice)
        updateBalance()
    }
    
    // Save to Parse
    func saveCurrentBalance() {
        // Save to Parse
        var query = PFQuery(className:"Students")
        query.whereKey("firstName", equalTo: self.student.firstName)
        query.whereKey("lastName", equalTo: self.student.lastName)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        object["currentBalance"] = MoneyUtilities.decimalNumberToDollarString(self.currentBalance!)
                        object.saveInBackgroundWithBlock(nil)
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error!.userInfo!)")
            }
        }
    }
}

