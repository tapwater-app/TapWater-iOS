//
//  Drink.swift
//  TapWater
//
//  Created by Jonathan Hooper on 11/6/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import Foundation
import CoreData

enum DrinkCategory: Int {
    case Drink = 4
    case Glass = 8
    case Bottle = 16
}

@objc(Drink)
class Drink: NSManagedObject {

    @NSManaged var drinkDate: NSDate
    @NSManaged var uuid: String
    @NSManaged var category: NSNumber
    @NSManaged var removed: NSNumber
    @NSManaged var user: User
    
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
    
    class func newDrink() -> Drink {
        return self.insertDrinkWithCategory(DrinkCategory.Drink, drinkDate: NSDate(), user: User.currentUser())
    }
    
    class func newGlass() -> Drink {
        return self.insertDrinkWithCategory(DrinkCategory.Glass, drinkDate: NSDate(), user: User.currentUser())
    }
    
    class func newBottle() -> Drink {
        return self.insertDrinkWithCategory(DrinkCategory.Bottle, drinkDate: NSDate(), user: User.currentUser())
    }
    
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
    
    func delete() {
        // Toggle the deleted field
        self.removed = true
        
        // Save the context
        NSManagedObjectContext.saveApplicationContext()
    }

}
