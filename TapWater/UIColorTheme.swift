//
//  UIColorTheme.swift
//  TapWater
//
//  Created by Jonathan Hooper on 8/29/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import Foundation
import UIKit

/**
* These extensions of the built-in UIColor class provide colors that are part of the TapWater theme.
*/
extension UIColor {
    
    /*
    * The yellow color from the TapWater theme
    */
    class func TWYellowColor() -> UIColor {
        return UIColor(red: 244.0/255.0, green: 208.0/255.0, blue: 63.0/255.0, alpha: 1.0)
    }
    
    /*
    * The light grey color from the TapWater theme
    */
    class func TWLightGreyColor() -> UIColor {
        return UIColor(red: 218.0/255.0, green: 223.0/255.0, blue: 225.0/225.0, alpha: 1.0)
    }
    
    /*
    * The grey color from the TapWater theme
    */
    class func TWGreyColor() -> UIColor {
        return UIColor(red: 189.0/255.0, green: 195.0/255.0, blue: 199.0/225.0, alpha: 1.0)
    }
    
    /*
    * The dark grey color from the TapWater theme
    */
    class func TWDarkGreyColor() -> UIColor {
        return UIColor(red: 108.0/255.0, green: 122.0/255.0, blue: 137.0/225.0, alpha: 1.0)
    }
    
    /*
    * The light blue color from the TapWater theme
    */
    class func TWLightBlueColor() -> UIColor {
        return UIColor(red: 107.0/255.0, green: 185.0/255.0, blue: 240.0/225.0, alpha: 1.0)
    }
    
    /*
    * The blue color from the TapWater theme
    */
    class func TWBlueColor() -> UIColor {
        return UIColor(red: 34.0/255.0, green: 167.0/255.0, blue: 240.0/225.0, alpha: 1.0)
    }
    
    /*
    * The dark blue color from the TapWater theme
    */
    class func TWDarkBlueColor() -> UIColor {
        return UIColor(red: 30.0/255.0, green: 139.0/255.0, blue: 95.0/225.0, alpha: 1.0)
    }
    
}