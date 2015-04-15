//
//  Students.swift
//  Music
//
//  Created by Jacob Jorgensen on 3/31/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

import UIKit

private let _StudentsSharedInstance = Students()

class Students {
    
    class var sharedInstance: Students {
        return _StudentsSharedInstance
    }
    
    var students = Array<Student>()
    
}

