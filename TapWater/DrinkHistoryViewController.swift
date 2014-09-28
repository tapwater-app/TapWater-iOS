//
//  DrinkHistoryViewController.swift
//  TapWater
//
//  Created by Jonathan Hooper on 9/11/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import UIKit

class DrinkHistoryViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.translucent = false;
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCellWithIdentifier("DrinkCell", forIndexPath: indexPath) as UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell.textLabel!.text = "4oz Drink"
            cell.detailTextLabel!.text = "10 minutes ago"
            break
        case 1:
            cell.textLabel!.text = "4oz Drink"
            cell.detailTextLabel!.text = "2 hours ago"
            break
        case 2:
            cell.textLabel!.text = "8oz Glass"
            cell.detailTextLabel!.text = "5 hourse ago"
            break
        case 3:
            cell.textLabel!.text = "4oz Drink"
            cell.detailTextLabel!.text = "Yesterday"
            break
        case 4:
            cell.textLabel!.text = "16oz Bottle"
            cell.detailTextLabel!.text = "Yesterday"
            break
        case 5:
            cell.textLabel!.text = "8oz Glass"
            cell.detailTextLabel!.text = "Yesterday"
            break
        case 6:
            cell.textLabel!.text = "4oz Drink"
            cell.detailTextLabel!.text = "2 days ago"
            break
        default:
            cell.textLabel!.text = "4oz Drink"
            cell.detailTextLabel!.text = "2 days ago"
            break
        }
        
        return cell
    }
}