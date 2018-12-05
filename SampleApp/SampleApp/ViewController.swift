//
//  ViewController.swift
//  SampleApp
//
//  Created by Nirmala Venkat on 12/4/18.
//  Copyright © 2018 nirmala. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var foundationView: UIStackView!
    
    // A handle for the ManagerSpecialsModel class
    var managerSpecials : ManagerSpecialsModel = ManagerSpecialsModel.init()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Calling this in viewWillAppear so that the date is ready before the view is loaded
        // TODO: Process Indicator needs to be shown till the response is returned
        managerSpecials.getManagerSpecials { (specials, error) in
            
            if error != nil {
                
                // Show an alert with the error
                print(error.debugDescription)
            } else {
                
                // Process the responses
                guard specials != nil else {
                    
                    // Show an alert with the message
                    return
                }
                
                // The responses are not nil and hence we can store them to process
                let canvasUnit: Int = specials!.canvasUnit
                let managerSpecialList: [ManagerSpecial] = specials!.managerSpecials
                
                // From hence, we need to process the information on the main thread
                
                DispatchQueue.main.async {
                    
                    // Get the current view frame width
                    let viewWidth: CGFloat  = self.foundationView.frame.width
                    
                    // Determine the divisible unit width
                    // Reference: The canvasUnit will determine how many divisible units fits into the full width of the phone.
                    // ** For example: if the canvasUnit is 8 and the total width of the phone is 360px then each unit is 360px/8 = 45px.
                    
                    let divisibleUnitWidth: Int = viewWidth.integer / canvasUnit
                    
                    // For each ManagerSpecial in the list, process the width and the height
                    for managerSpecial in managerSpecialList {
                        
                        print(managerSpecial.display_name)
                        print(managerSpecial.imageUrl)
                        
                        // Convert the url string to URL entity
                        // Putting a guard to avoid nil value for the variable
                        guard let url = URL(string: managerSpecial.imageUrl) else {
                            return
                        }
                        
                        print(managerSpecial.width * divisibleUnitWidth)
                        print(managerSpecial.height * divisibleUnitWidth)
                        print(managerSpecial.original_price)
                        print(managerSpecial.price)
                        print("\n")
                        
                        let customView: ManagerSpecialView = ManagerSpecialView.init(frame: CGRect(x: 10.0, y: 10.0, width: Double(managerSpecial.width * divisibleUnitWidth), height: Double(managerSpecial.height * divisibleUnitWidth)))
                        
                        customView.iconImageView.load(url: url)
                        customView.originalPrice.text = managerSpecial.original_price
                        customView.price.text = managerSpecial.price
                        customView.specialTitle.text = managerSpecial.display_name
                        
                        self.view.addSubview(customView)
                    }
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

