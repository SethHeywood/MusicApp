//
//  Student.swift
//  Music
//
//  Created by Jacob Jorgensen on 3/31/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

import UIKit

class Student {
    
    let firstName: String!
    let lastName: String!
    var fullName: String {
        get {
            return "\(self.firstName) \(self.lastName)"
        }
    }
    let studentAccount: StudentAccount!
    let studentPhoto: UIImage!
    
    
    init (firstName: String, lastName: String, lessonPrice: NSDecimalNumber, currentBalance: NSDecimalNumber, studentPhoto: UIImage) {
        self.firstName = firstName
        self.lastName = lastName
        self.studentAccount = StudentAccount(lessonPrice: lessonPrice, currentBalance: currentBalance)
        self.studentPhoto = studentPhoto
    }
    
}
