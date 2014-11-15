//
//  DrinkHistoryViewController.swift
//  TapWater
//
//  Created by Jonathan Hooper on 9/11/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import UIKit

class DrinkHistoryViewController: UITableViewController {
    
    var drinks: [Drink] {
        return Drink.drinksForUser(User.currentUser())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.translucent = false;
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refresh the tableview
        self.tableView.reloadData()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Dequeue a TableViewCell
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("DrinkCell", forIndexPath: indexPath) as UITableViewCell
        
        // Manually load the cell the cell if it is not loaded properly
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "DrinkCell")
        }
        
        // Find the drink
        let drink: Drink = self.drinks[indexPath.row]
        
        // Wrtie the drink category to the cell
        switch drink.category {
        case DrinkCategory.Drink.rawValue:
            cell.textLabel.text = "Drink"
        case DrinkCategory.Glass.rawValue:
            cell.textLabel.text = "Glass"
        case DrinkCategory.Bottle.rawValue:
            cell.textLabel.text = "Bottle"
        default:
            cell.textLabel.text = "A Drink"
        }
        
        // write the drink date to the cell
        cell.detailTextLabel!.text = drink.drinkDate.toHumanReadableIntervalString()
        
        return cell
    }
}