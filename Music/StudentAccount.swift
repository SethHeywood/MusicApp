//
//  StudentAccount.swift
//  Music
//
//  Created by Jacob Jorgensen on 3/31/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

import UIKit

class StudentAccount {
    
    //---------------------------------------------------//
    // Instance Variables
    //---------------------------------------------------//
    
    //var transactionHistory = Array<Transaction>()
    var lessonPrice: NSDecimalNumber!
    var currentBalance: NSDecimalNumber!
//    var totalBalance: NSDecimalNumber {
//        get {
//            var total: NSDecimalNumber = 0
//            for transaction in transactionHistory {
//                total = total.decimalNumberByAdding(MoneyUtilities.dollarStringToDecimalNumber(transaction.value))
//            }
//            return total
//        }
//    }
//    var totalBalanceString: String {
//        get {
//            return MoneyUtilities.decimalNumberToDollarString(self.totalBalance)
//        }
//    }
    
    //---------------------------------------------------//
    // Initializer
    //---------------------------------------------------//
    
    init (lessonPrice: NSDecimalNumber, currentBalance: NSDecimalNumber) {
        self.lessonPrice = lessonPrice
        self.currentBalance = currentBalance
    }
    
    //---------------------------------------------------//
    // Methods
    //---------------------------------------------------//
    
//    func deposit (amount: NSDecimalNumber) {
//        var transaction = Transaction(value: amount, balance: totalBalance.decimalNumberByAdding(amount), image: "Plus.png", errorMessage: "")
//        self.transactionHistory.append(transaction)
//    }
//    
//    
//    func withdraw (amount: NSDecimalNumber) {
//        var transaction = Transaction(value: amount, balance: totalBalance.decimalNumberByAdding(amount), image: "Minus.png", errorMessage: "")
//        self.transactionHistory.append(transaction)
//    }
//    
//    func error (errorDescription: String) {
//        var transaction = Transaction(value: NSDecimalNumber.zero(), balance: totalBalance, image: "Error.png", errorMessage: errorDescription)
//        self.transactionHistory.append(transaction)
//    }
}
