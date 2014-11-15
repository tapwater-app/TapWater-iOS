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

extension NSManagedObjectContext {
    
    class func applicationContext() -> NSManagedObjectContext {
        return (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    }
    
    class func saveApplicationContext() {
        var error: NSError?
        self.applicationContext().save(&error)
        
        if error != nil {
            println("Error Saving Application Context: \(error)")
        }
    }
    
}
