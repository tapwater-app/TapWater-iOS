//
//  CoreDataExtensions.swift
//  TapWater
//
//  Created by Jonathan Hooper on 11/6/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import Foundation
import UIKit
import CoreData

/**
* The extension of NSManagedObjectContext provides a means loading and saving the application context
* without passing it to the view controllers from the AppDelegate
*/
extension NSManagedObjectContext {
    
    /*
    * Loads the application context from the AppDelegate and returns it.
    */
    class func applicationContext() -> NSManagedObjectContext {
        return (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    }
    
    /*
    * Loads the application context and saves it.
    * If this method encounters an error it logs the error and attempts to continue execution.
    */
    class func saveApplicationContext() {
        var error: NSError?
        self.applicationContext().save(&error)
        
        if error != nil {
            println("Error Saving Application Context: \(error)")
        }
    }
    
}
