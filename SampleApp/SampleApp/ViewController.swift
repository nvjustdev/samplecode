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

    // The handle for the vertical UIStackView
    @IBOutlet weak var verticalStackView: UIStackView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        verticalStackView.alignment = .center
        verticalStackView.spacing = 30.0
        verticalStackView.distribution = .fillProportionally
        
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
                    let viewWidth: CGFloat  = self.verticalStackView.frame.width
                    
                    // Determine the divisible unit width
                    // Reference: The canvasUnit will determine how many divisible units fits into the full width of the phone.
                    // ** For example: if the canvasUnit is 8 and the total width of the phone is 360px then each unit is 360px/8 = 45px.
                    
                    let divisibleUnitWidth: Int = viewWidth.integer / canvasUnit
                    
                    // There's a need for an adjustment factor and a marker for where the next block should be rendered.
                    // Using one variable adjustmentFactor for both that
                    var adjustmentFactor: Int = 0
                    
                    // For each ManagerSpecial in the list, process the width and the height
                    for managerSpecial in managerSpecialList {
                        
                        print(managerSpecial.display_name)
                        print(managerSpecial.imageUrl)
                        
                        // Convert the url string to URL entity
                        // Putting a guard to avoid nil value for the variable
                        guard let url = URL(string: managerSpecial.imageUrl) else {
                            return
                        }
                        
                        let customView: IndividualManagerSpecialView = IndividualManagerSpecialView(frame: CGRect(x: 0, y: adjustmentFactor + 0, width: managerSpecial.width * divisibleUnitWidth, height: managerSpecial.height * divisibleUnitWidth))
                        
                        customView.specialImage.load(url: url)
                        customView.originalPrice.text = managerSpecial.original_price
                        customView.specialPrice.text = managerSpecial.price
                        customView.specialHeadline.text = managerSpecial.display_name
                        
                        customView.heightAnchor.constraint(equalToConstant: (managerSpecial.height * divisibleUnitWidth).cgFloat)
                        customView.widthAnchor.constraint(equalToConstant: (managerSpecial.width * divisibleUnitWidth).cgFloat)
                        
                        adjustmentFactor = adjustmentFactor + managerSpecial.height * divisibleUnitWidth + 20
                        
                        print(adjustmentFactor)
                        
                        self.verticalStackView.addSubview(customView)
                    }
                    
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

