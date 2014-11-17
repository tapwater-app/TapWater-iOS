//
//  Drink.swift
//  TapWater
//
//  Created by Jonathan Hooper on 11/6/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import Foundation
import CoreData

/*
* DrinkCategory provides an enum for identifying what button was used to create the drink and its quantity in ounces.
*/
enum DrinkCategory: Int {
    case Drink = 4
    case Glass = 8
    case Bottle = 16
}

/*
* The Drink class represent a drink object.
*/
@objc(Drink)
class Drink: NSManagedObject {

    @NSManaged var drinkDate: NSDate  // The date the drink was created
    @NSManaged var uuid: String       // A globally unique identifier for the drink
    @NSManaged var category: NSNumber // The DrinkCategory of the drink
    @NSManaged var removed: NSNumber  // Whether or not the drink has been removed from the database
    @NSManaged var user: User         // The user the drink belongs to
    
    /*
    * The primary factory method for a drink.
    * This method creates a drink and inserts it into the database.
    * @param category: The drink's category
    * @param drinkDate: The drink's drinkDate
    * @param user: The drink's user
    * @return A Drink object with the specified parameters
    */
    class func insertDrinkWithCategory(category: DrinkCategory, drinkDate: NSDate, user: User) -> Drink {
        // Insert the drink into the curent context
        let drink: Drink = NSEntityDescription.insertNewObjectForEntityForName("Drink", inManagedObjectContext: NSManagedObjectContext.applicationContext()) as Drink
        
        // Update the drinks fields
        drink.category = category.rawValue
        drink.drinkDate = drinkDate
        drink.user = user
        drink.uuid = NSUUID().UUIDString
        drink.removed = NSNumber(bool: false)
        
        // Save the context with the drink
        NSManagedObjectContext.saveApplicationContext()
        
        // Return the created drink
        return drink
    }
    
    /*
    * The factory method for a drink with the category Drink
    * This method creates the drink with the drink date set to the current date and the user set to the current user
    * @return A new drink object with the category set to Drink
    */
    class func newDrink() -> Drink {
        return self.insertDrinkWithCategory(DrinkCategory.Drink, drinkDate: NSDate(), user: User.currentUser())
    }
    
    /*
    * The factory method for a drink with the category Glass
    * This method creates the drink with the drink date set to the current date and the user set to the current user
    * @return A new drink object with the category set to Glass
    */
    class func newGlass() -> Drink {
        return self.insertDrinkWithCategory(DrinkCategory.Glass, drinkDate: NSDate(), user: User.currentUser())
    }
    
    /*
    * The factory method for a drink with the category Bottle
    * This method creates the drink with the drink date set to the current date and the user set to the current user
    * @return A new drink object with the category set to Bottle
    */
    class func newBottle() -> Drink {
        return self.insertDrinkWithCategory(DrinkCategory.Bottle, drinkDate: NSDate(), user: User.currentUser())
    }
    
    /*
    * Finds all of the drinks for a given user
    * @param user The user whose drinks we are loading
    * @return An array of drink objects related to the given user
    */
    class func drinksForUser(user: User) -> [Drink] {
        // Create a fetch request to querey for the user's drinks
        var fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Drink")
        fetchRequest.predicate = NSPredicate(format: "user == %@ && removed == false", user)!
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "drinkDate", ascending: false)]
        
        // Execute the querey
        var error: NSError?
        let drinks: [Drink] = NSManagedObjectContext.applicationContext().executeFetchRequest(fetchRequest, error: &error) as [Drink]
        
        // Log an error
        if (error != nil) {
            println("Error loading drinks for {User:\(user)} with {NSFetchRequest:\(fetchRequest)} \(error)")
        }
        
        // Return the results
        return drinks
    }
    
    /*
    * Delete the drink
    * This method does not actually delete the drink from the database. It just toggles the 'removed' field.
    */
    func delete() {
        // Toggle the deleted field
        self.removed = true
        
        // Save the context
        NSManagedObjectContext.saveApplicationContext()
    }

}
