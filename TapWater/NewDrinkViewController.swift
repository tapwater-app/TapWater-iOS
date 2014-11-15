//
//  NewDrinkViewController.swift
//  TapWater
//
//  Created by Jonathan Hooper on 9/11/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import UIKit

class NewDrinkViewController: UIViewController {
    
    @IBOutlet var drinkButton : UIButton!
    @IBOutlet var glassButton : UIButton!
    @IBOutlet var bottleButton : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.translucent = false
        
        self.drinkButton.backgroundColor = UIColor.TWBlueColor()
        self.glassButton.backgroundColor = UIColor.TWBlueColor()
        self.bottleButton.backgroundColor = UIColor.TWBlueColor()
    }
    
    @IBAction func newDrinkButtonTapped(sender : UIButton) {
        if (sender == self.drinkButton) {
            Drink.newDrink()
        } else if (sender == self.glassButton) {
            Drink.newGlass()
        } else if (sender == self.bottleButton) {
            Drink.newBottle()
        }
    }
    
}