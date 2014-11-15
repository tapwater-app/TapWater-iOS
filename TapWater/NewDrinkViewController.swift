//
//  NewDrinkViewController.swift
//  TapWater
//
//  Created by Jonathan Hooper on 9/11/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import UIKit

class NewDrinkViewController: UIViewController {
    
    @IBOutlet var drinkButton: UIButton!
    @IBOutlet var glassButton: UIButton!
    @IBOutlet var bottleButton: UIButton!
    
    @IBOutlet var drinkCounterLabel: UILabel!
    @IBOutlet var drinkTimerLabel: UILabel!
    
    var drinkTimer: NSTimer = NSTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.translucent = false
        
        // Update the drink button color
        self.drinkButton.backgroundColor = UIColor.TWBlueColor()
        self.glassButton.backgroundColor = UIColor.TWBlueColor()
        self.bottleButton.backgroundColor = UIColor.TWBlueColor()
        
        // Start a timer to update the drink timer
        self.drinkTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("updateDrinkTimer"), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Update the drink counter
        self.updateDrinkCounter()
        self.updateDrinkTimer()
    }
    
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
    
    func updateDrinkCounter() {
        self.drinkCounterLabel.text = NSString(format: "Drinks Today: %02d", User.currentUser().drinksToday())
    }
    
}