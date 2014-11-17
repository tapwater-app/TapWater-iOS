//
//  HTTPClient.swift
//  TapWater
//
//  Created by Jonathan Hooper on 11/15/14.
//  Copyright (c) 2014 NewAperio. All rights reserved.
//

import Foundation

var _sharedClient: HTTPClient! // Singleton HTTPClient

/*
* THe HTTPClient handles all of the web request and response forwarding between the device and the server
*/
class HTTPClient: AFHTTPRequestOperationManager {
    
    /*
    * The singleton for the HTTPClient
    */
    class func sharedClient() -> HTTPClient {
        if _sharedClient == nil {
            _sharedClient = HTTPClient(baseURL: NSURL(string: "http://tapwater.herokuapp.com"))
            _sharedClient.requestSerializer = AFJSONRequestSerializer(writingOptions:nil)
            _sharedClient.responseSerializer = AFJSONResponseSerializer(readingOptions:nil)
        }
        return _sharedClient
    }
    
    /*
    * The method for signing up a new user
    * @param username The user's username
    * @param password The user's password
    * @param password_confirmation The user's password confirmation
    * @param success The block to be executed when the user is created
    * @param failure The block to be executed if the user is not created
    */
    func postNewUser(username: String, password: String, passwordConfirmation: String, success: (response: AnyObject?) -> Void, failure: (response: AnyObject?, error: NSError?) -> Void) {
        // Create a dictionary for the user parameters to build into the request params
        var userParameters: [String:String] = ["username":username, "password":password, "passwordConfirmation":passwordConfirmation]
        var requestParameters: [String:AnyObject] = ["user":userParameters]
        
        // Create closures for success/failure
        let successBlock = { (operation: AFHTTPRequestOperation!, response: AnyObject?) -> Void in
            success(response: response)
        }
        let failureBlock = { (operation: AFHTTPRequestOperation!, error: NSError?) -> Void in
            failure(response: nil, error: error)
        }
        
        // Execute the post request
        self.POST("/api/v1/users.json", parameters: requestParameters, success: successBlock, failure: failureBlock)
    }
    
    /*
    * Authenticates an existing user
    * @param username The user's username
    * @param password The user's password
    * @param success The block to be executed when the user is created
    * @param failure The block to be executed if the user is not created
    */
    func authenticateUser(username: String, password: String, success: (response: AnyObject?) -> Void, failure: (response: AnyObject?, error: NSError?) -> Void) {
        // Create a dictionary for the request params
        var requestParameters: [String:String] = ["username":username, "password":password]
        
        // Create closures for success/failure
        let successBlock = { (operation: AFHTTPRequestOperation!, response: AnyObject?) -> Void in
            success(response: response)
        }
        let failureBlock = { (operation: AFHTTPRequestOperation!, error: NSError?) -> Void in
            failure(response: nil, error: error)
        }
        
        // Execute the post request
        self.POST("/api/v1/users/authenticate.json", parameters: requestParameters, success: successBlock, failure: failureBlock)
    }
    
    /*
    * Validates that a device token is still valid
    * @param deviceToken The user's device token
    * @return A bool corresponding to whether or not the device token is valide
    */
    func validateUserStatus(deviceToken: String) -> Bool {
        return false
    }
    
    /*
    * Downloads the user's drinks
    * @param deviceToken The user's device token
    * @param success The block to be executed when the drinks are downloaded
    * @param failure The block to be executed if the request fails
    */
    func getDrinks(deviceToken: String, success: (response: AnyObject?) -> Void, failure: (response: AnyObject?, error: NSError?) -> Void) {
        // Create a clouse for success/failure
        let successBlock = { (operation: AFHTTPRequestOperation!, response: AnyObject?) -> Void in
            success(response: response)
        }
        let failureBlock = { (operation: AFHTTPRequestOperation!, error: NSError?) -> Void in
            failure(response: nil, error: error)
        }
        
        // Execute the get request
        self.GET("/api/v1/drinks.json", parameters:["device_token":deviceToken], success: successBlock, failure: failureBlock)
    }
    
    /*
    * Posts a new drink to the rails app
    * @param drink The Drink to be uploaded
    * @param deviceToken The user's device token
    * @param success The block to be executed when the drink is created
    * @param failure The block to be executed if the request fails
    */
    func postDrink(drink: Drink, deviceToken: String, success: (response: AnyObject?) -> Void, failure: (response: AnyObject?, error: NSError?) -> Void) {
        
    }
    
    /*
    * Trades drink data with the rails app
    * @param drinks The drinks on the local device
    * @param deviceToken The user's device token
    * @param success The block to be executed in response to the sync
    * @param failure The block to be executed if the request fails
    */
    func syncDrinks(drinks: [Drink], deviceToken: String, success: (response: AnyObject?) -> Void, failure: (response: AnyObject?, error: NSError?) -> Void) {
        
    }
    
}
