//
//  DrinkHistoryViewController.swift
//  TapWater
//
//  Created by Jonathan Hooper on 9/11/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import UIKit

/*
* The DrinkHistoryViewController represents a view controller where users view their drink history
*/
class DrinkHistoryViewController: UITableViewController {
    
    /*
    * The array of drinks being displayed
    */
    var drinks: [Drink] {
        return Drink.drinksForUser(User.currentUser())
    }
    
    /*
    * This method initializes the view when it is loaded
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.translucent = false;
        
        // Enable refresh on the table view
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.tintColor = UIColor.TWLightGreyColor()
        self.refreshControl!.addTarget(self, action: Selector("reloadDrinks"), forControlEvents: UIControlEvents.ValueChanged)
    }
    
    /*
    * This method prepares the view to be displayed
    */
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Refresh the tableview
        self.tableView.reloadData()
    }
    
    /*
    * This method returns the number of sections in the tables
    * @return The number of sections in the tableview. Since the tableview is unsection this method should return 1.
    */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    /*
    * This method looks for the number of rows that should be displayed in the table view
    * @return The number of rows in the table view. Should correspond to the length of the drinks array.
    */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count;
    }
    
    /*
    * The cell for the row in the table view at the index specified by the index path
    * @param indexPath The index path of the row corresponding to the cell
    * @return A table view cell for the given row
    */
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
    
    /*
    * The method to reload the drinks table view.
    * This method is meant to be called when a change has been made to the drinks and the table view needs to be updated to reflect that change.
    */
    func reloadDrinks() {
        self.refreshControl!.endRefreshing()
    }
}