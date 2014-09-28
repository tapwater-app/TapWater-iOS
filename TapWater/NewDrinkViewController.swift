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
        println("Button Tapped! \(sender)")
        
        if (sender == self.drinkButton) {
            println("New 4oz Drink")
        } else if (sender == self.glassButton) {
            println("New 8oz Drink")
        } else if (sender == self.bottleButton) {
            println("New 16oz Drink")
        }
    }
    
}