//
//  ManagerSpecialsModel.swift
//  SampleApp
//
//  Created by Nirmala Venkat on 12/4/18.
//  Copyright © 2018 nirmala. All rights reserved.
//

import Foundation

// This class is responsible for getting the information from the endpoint

class ManagerSpecialsModel : NSObject {
    
    // The following method will contact the endpoint and get the JSON result
    
    func getManagerSpecials(complete: @escaping (_ specials: Response?, _ error: SampleAppError?) -> ()) {
        
        // Create the URL String for the endpoint.
        let urlString = "https://prestoq.com/ios-coding-challenge"
        
        // Convert the url string to URL entity
        // Putting a guard to avoid nil value for the variable
        guard let url = URL(string: urlString) else {
            
            // Send back the error to the ViewController for display / handling
            complete(nil, SampleAppError.runtimeError("URL string was not converted correctly to URL"))
            
            return
        }
        
        // Using URLSession, contact the endpoint at the given URL
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            
            // Check if there were any errors in executing the call
            if error != nil {
                
                // Send back the error to the ViewController for display / handling
                complete(nil, SampleAppError.runtimeError("Error while executing the URL: " + error.debugDescription))
            }
            
            
            // Data contains the data received. Checking for nil value
            guard data != nil else {
                
                // Send back the error to the ViewController for display / handling
                complete(nil, SampleAppError.runtimeError("Data from the endpoint is nil. Additional Info: " + error.debugDescription))
                return
            }
            
            
            // The data coming back is JSON array
            // JSONSerialization throws error which needs to be handled
            do {
                
                // Store the deserialized object in responseData
                let responseData = try JSONDecoder().decode(Response.self, from: data!)
                
                // Send back the response to the ViewController for appropriate handling and display
                complete(responseData, nil)
                
            } catch let error as NSError {
                
                // Deserialization gave error - This is the catch block
                // Send back the error to the ViewController for display / handling
                complete(nil, SampleAppError.runtimeError("Deserialization of the JSON response leads to error. Additional Info: " + error.debugDescription))
            }
            
            
            }.resume()
    }
}

