//
//  AppDelegate.swift
//  Music
//
//  Created by Jacob Jorgensen on 3/31/15.
//  Copyright (c) 2015 ASU. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?
    var students: Students {
        get {
            return Students.sharedInstance
        }
    }


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Initialize Parse.
        Parse.setApplicationId("JSx0hiLkwWyhpyRbvbz3iP4No6EG7jdBYdA0krfJ", clientKey: "z52kecmobq2C6iN2E3MuTx7XuApzDmqf3iLo3FEv")
        
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController {
                if topAsDetailController.student == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }
    
//        func saveAccounts() {
//            var query = PFQuery(className: "BankAccount")
//            query.getObjectInBackgroundWithId("JJdStces0m") {
//                (bank: PFObject!, error: NSError!) -> Void in
//                if error == nil {
//                    bank.setObject(self.bankAccount1.string, forKey: "accountName")
//                    var count = self.bankAccount1.transactionHistory.count
//                    var dateArray = [String]()
//                    var valueArray = [String]()
//                    var balanceArray = [String]()
//                    var imageArray = [String]()
//                    var errorMessageArray = [String]()
//                    for (var i = 0; i < count; i++) {
//                        dateArray.append(self.bankAccount1.transactionHistory[i].date)
//                        valueArray.append(self.bankAccount1.transactionHistory[i].value)
//                        balanceArray.append(self.bankAccount1.transactionHistory[i].balance)
//                        imageArray.append(self.bankAccount1.transactionHistory[i].image)
//                        errorMessageArray.append(self.bankAccount1.transactionHistory[i].errorMessage)
//                    }
//                    bank.setObject(dateArray, forKey: "date")
//                    bank.setObject(valueArray, forKey: "value")
//                    bank.setObject(balanceArray, forKey: "balance")
//                    bank.setObject(imageArray, forKey: "image")
//                    bank.setObject(errorMessageArray, forKey: "errorMessage")
//    
//                    bank.saveInBackgroundWithBlock {
//                        (success: Bool!, error: NSError!) -> Void in
//                        if (success != nil) {
//                            // Nothing
//                        } else {
//                            println(error)
//                        }
//                    }
//                } else {
//                    println(error)
//                }
//            }
//        }

}

