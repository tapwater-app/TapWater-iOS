//
//  User.swift
//  TapWater
//
//  Created by Jonathan Hooper on 11/6/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import Foundation
import CoreData

/*
* The user class represents a user of the application
*/
@objc (User)
class User: NSManagedObject {

    @NSManaged var username: String        // The user's username
    @NSManaged var deviceToken: String     // The last device token from the user's most recent session
    @NSManaged var isCurrentUser: NSNumber // A boolean for whether or not the user is the user that is currently authenticated
    @NSManaged var drinks: NSSet           // The user's drinks
    
    /*
    * Loads the current user
    * @return The user that is currently authenticated
    */
    class func currentUser() -> User {
        // Create a query to find the current user
        var fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "User")
        fetchRequest.predicate = NSPredicate(format: "isCurrentUser == true")
        
        // Execute the query
        var error: NSError?
        let users: [User] = NSManagedObjectContext.applicationContext().executeFetchRequest(fetchRequest, error: &error) as [User]
        
        // Log an error
        if error != nil {
            println("Error looking for current user with {NSFetchRequest:\(fetchRequest)}: \(error)")
        }
        
        // Check to see if there is a current user
        if users.count > 0 {
            // If there is a user, return them
            return users[0]
        } else {
            // If there is not a user, create one
            var user: User = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: NSManagedObjectContext.applicationContext()) as User
            user.isCurrentUser = true
            
            // Save the context
            NSManagedObjectContext.saveApplicationContext()
            
            // Return the new user
            return user
        }
    }
    
    /*
    * Loads the number of drinks the user has had today
    * @return An int whose value corresponds to the number of drinks the user has had today
    */
    func drinksToday() -> Int {
        // Load the users drinks from today
        let drinks: [Drink] = Drink.drinksForUser(self).filter({ (drink: Drink) -> Bool in
            return drink.drinkDate.isToday()
        })
        
        // Return the number of drinks in the array
        return drinks.count
    }
    
    /*
    * Returns the date of the last drink the user had
    * @return The date of the user's last drink. This method returns nil if the user has no drinks.
    */
    func lastDrinkDate() -> NSDate? {
        // Load the user's drinks
        let drinks: [Drink] = Drink.drinksForUser(self).filter({ (drink: Drink) -> Bool in
            return drink.drinkDate.isToday()
        })
        
        // Return the most recent drink
        if drinks.count > 0 {
            return drinks[0].drinkDate
        } else {
            return nil
        }
    }

}
