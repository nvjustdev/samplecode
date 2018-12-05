//
//  ViewController.swift
//  SampleApp
//
//  Created by Nirmala Venkat on 12/4/18.
//  Copyright © 2018 nirmala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // A handle for the ManagerSpecialsModel class
    var managerSpecials : ManagerSpecialsModel = ManagerSpecialsModel.init()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Calling this in viewWillAppear so that the date is ready before the view is loaded
        // TODO: Process Indicator needs to be shown till the response is returned
        managerSpecials.getManagerSpecials { (specials, error) in
            
            if error != nil {
                
                // Show an alert with the error
                print(error)
            } else {
                
                // Process the responses
                print(specials)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

