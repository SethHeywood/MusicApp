//
//  AddStudentVC.swift
//  Music
//
//  Created by Jacob Jorgensen on 3/31/15.
//  Copyright (c) 2015 ASU. All rights reserved.
// Code for camera modified from Steve Lipton tutorial http://makeapppie.com/2014/12/04/swift-swift-using-the-uiimagepickercontroller-for-a-camera-and-photo-library/
// and from http://tjsander.github.io/swift-camera/
//

import UIKit
import Parse
import MobileCoreServices

class AddStudentVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var lessonPriceField: UITextField!
    @IBOutlet weak var image: UIImageView!
    var picker = UIImagePickerController()
    var studentPhoto: UIImage!
   
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
        picker.delegate = self
        self.firstNameField.delegate = self
        self.lastNameField.delegate = self
        self.lessonPriceField.delegate = self
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
        if (self.firstNameField.text == "" || self.lastNameField.text == "" || self.lessonPriceField.text == "" || studentPhoto == nil) {
            
            var alert = UIAlertController(title: "All Fields Are Required", message: "", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
                
            }))
            presentViewController(alert, animated: true, completion: nil)
            
        }
        else {
            let newStudent = Student(firstName: self.firstNameField.text, lastName: self.lastNameField.text, lessonPrice: self.lessonPriceFieldValue, currentBalance: NSDecimalNumber.zero(), studentPhoto: studentPhoto)
            students.students.append(newStudent)
 //           saveStudentToParse(newStudent)
            NSNotificationCenter.defaultCenter().postNotificationName("StudentTable", object: nil)
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
 //       studentData["studentPhoto"] = student.studentPhoto
        studentData.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                // The object has been saved.
            } else {
                println("Error saving student object")
            }
        }
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    
    func noCamera(){
        let alertVC = UIAlertController(title: "No Camera", message: "Sorry, this device has no camera", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "OK", style:.Default, handler: nil)
        alertVC.addAction(okAction)
        presentViewController(alertVC, animated: true, completion: nil)
    }

    @IBAction func photoFromLibrary(sender: UIButton) {
        picker.allowsEditing = false
        picker.sourceType = .PhotoLibrary
        picker.modalPresentationStyle = .Popover
        presentViewController(picker, animated: true, completion: nil)
    //    picker.popoverPresentationController?. = sender
    }

    
    @IBAction func takePhoto(sender: UIButton) {
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [kUTTypeImage]
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else{
            noCamera()
        }
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        studentPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        image.contentMode = .ScaleAspectFit
        image.image = studentPhoto
        dismissViewControllerAnimated(true, completion: nil)
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
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
