//
//  MoneyUtilities.swift
//  Music
//
//  Created by Jacob Jorgensen on 3/31/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

import UIKit

class MoneyUtilities {
    
    // Format the NSDecimalNumber to a Dollar String
    class func decimalNumberToDollarString(amount: NSDecimalNumber) -> String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        return numberFormatter.stringFromNumber(amount)!
    }
    
    // Format the NSDecimalNumber to a String
    class func decimalNumberToString(amount: NSDecimalNumber) -> String {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        return numberFormatter.stringFromNumber(amount)!
    }
    
    // Dollar String to NSDecimalNumber
    class func dollarStringToDecimalNumber(var str: String) -> NSDecimalNumber {
        if (str == "") {
            return NSDecimalNumber.zero()
        }
        else if (str[str.startIndex] == "-") {
            str = str.substringWithRange(Range<String.Index>(start: advance(str.startIndex, 2), end: str.endIndex))
            var pos = NSDecimalNumber(string: str)
            var neg = pos.decimalNumberByMultiplyingBy(NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
            return neg
        }
        else {
            str = str.substringWithRange(Range<String.Index>(start: advance(str.startIndex, 1), end: str.endIndex))
            return NSDecimalNumber(string: str)
        }
    }
}
