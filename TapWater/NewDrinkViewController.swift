//
//  NewDrinkViewController.swift
//  TapWater
//
//  Created by Jonathan Hooper on 9/11/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import UIKit

/*
* The NewDrinkViewController is the view controller for the view where user's create drinks
*/
class NewDrinkViewController: UIViewController {
    
    @IBOutlet var drinkButton: UIButton!  // The button to create a new drink with the drink category
    @IBOutlet var glassButton: UIButton!  // The button to create a new drink with the glass category
    @IBOutlet var bottleButton: UIButton! // The button to create a new drink with the bottle category
    
    @IBOutlet var drinkCounterLabel: UILabel! // The label that displays how many drinks the user has had today
    @IBOutlet var drinkTimerLabel: UILabel!   // The label that creates the drink timer
    
    var drinkTimer: NSTimer = NSTimer() // The timer that updates the drink timer label ever second
    
    /*
    * This method initializes the view when it is loaded
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Make the navigationbar opaque
        self.navigationController!.navigationBar.translucent = false
        
        // Update the drink button color
        self.drinkButton.backgroundColor = UIColor.TWBlueColor()
        self.glassButton.backgroundColor = UIColor.TWBlueColor()
        self.bottleButton.backgroundColor = UIColor.TWBlueColor()
        
        // Start a timer to update the drink timer
        self.drinkTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateDrinkTimer"), userInfo: nil, repeats: true)
    }
    
    /*
    * This method prepares the view to be displayed
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update the drink counter
        self.updateDrinkCounter()
        self.updateDrinkTimer()
    }
    
    /*
    * This method is called every time a drink button is tapped
    * @param sender The object that initiated the action. Should correspond to one of the button for creating a drink
    */
    @IBAction func newDrinkButtonTapped(sender : UIButton) {
        // Create the drink
        if (sender == self.drinkButton) {
            Drink.newDrink()
        } else if (sender == self.glassButton) {
            Drink.newGlass()
        } else if (sender == self.bottleButton) {
            Drink.newBottle()
        }
        
        // Update the counter
        self.updateDrinkCounter()
        self.updateDrinkTimer()
    }
    
    /*
    * This method updates the drink timer.
    * This method should be called by the drinkTimer at intervals of 1 second
    */
    func updateDrinkTimer() {
        // Load the last drink date
        let lastDrinkDate: NSDate! = User.currentUser().lastDrinkDate()
        
        // Check to make sure the drink date exists
        if lastDrinkDate == nil {
            self.drinkTimerLabel.text = "00:00:00"
            return
        }
        
        // Load the components of the time label
        let timeInterval: Float = Float(NSDate().timeIntervalSinceDate(lastDrinkDate))
        let hours: Int = Int(timeInterval / 3600)
        let minutes: Int = Int(timeInterval % 3600 / 60)
        let seconds: Int = Int(timeInterval % 60)
        
        // Update the label
        self.drinkTimerLabel.text = NSString(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    /*
    * This method updates the drink counter.
    */
    func updateDrinkCounter() {
        self.drinkCounterLabel.text = NSString(format: "Drinks Today: %02d", User.currentUser().drinksToday())
    }
    
}