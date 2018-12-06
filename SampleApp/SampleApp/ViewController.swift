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
        
        // Set the attributes of this stack view
        verticalStackView.alignment = .center
        verticalStackView.spacing = 20.0
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
                    // Using one variable adjustmentFactor for both the factor and marker, one more axis
                    var adjustmentFactorY: Int = 0
                    var adjustmentFactorX: Int = 0
                    
                    // Get the number of manager specials
                    let numberManagerSpecials = managerSpecialList.count
                    
                    // For each ManagerSpecial in the list, process the width and the height
                    for index in 0...numberManagerSpecials {
                        
                        // Get the current specials
                        let managerSpecial: ManagerSpecial = managerSpecialList[index]
                        
                        // Get the next specials
                        let nextManagerSpecial: ManagerSpecial = managerSpecialList[index + 1]
                        
                        // Get the result for the fit
                        let result: Bool = self.doesFitInSameLine(currentManagerSpecial: managerSpecial, nextManagerSpecial: nextManagerSpecial, canvasUnit: canvasUnit)
                        
                        print(managerSpecial.display_name)
                        print(managerSpecial.imageUrl)
                        
                        // Convert the url string to URL entity
                        // Putting a guard to avoid nil value for the variable
                        guard let url = URL(string: managerSpecial.imageUrl) else {
                            return
                        }
                        
                        // If the check for same row resulted in false
                        if !result {
                            
                            // Create a custom view for the special
                            let customView: IndividualManagerSpecialView = IndividualManagerSpecialView(frame: CGRect(x: (result ? 1 : 0) * adjustmentFactorX + 0, y:  (result ? 0 : 1) * adjustmentFactorY + 0, width: managerSpecial.width * divisibleUnitWidth, height: managerSpecial.height * divisibleUnitWidth))
                            
                            // Set the attributes of this view
                            customView.specialImage.load(url: url)
                            customView.originalPrice.text = managerSpecial.original_price
                            customView.specialPrice.text = managerSpecial.price
                            customView.specialHeadline.text = managerSpecial.display_name
                            
                            // Set the constraints
                            customView.heightAnchor.constraint(equalToConstant: (managerSpecial.height * divisibleUnitWidth).cgFloat)
                            customView.widthAnchor.constraint(equalToConstant: (managerSpecial.width * divisibleUnitWidth).cgFloat)
                            
                            // Increment the Y factor
                            adjustmentFactorY = adjustmentFactorY + managerSpecial.height * divisibleUnitWidth + self.verticalStackView.spacing.integer
                            
                            // add the view to the stack
                            self.verticalStackView.addSubview(customView)
                        } else {
                            
                            // Check for same row resulted in true
                            // Create a horizontal UIStackView as wide as the vertical stack view
                            let horizontalStackView: UIStackView = UIStackView.init(frame: CGRect(x: 0, y: adjustmentFactorY + 0, width: viewWidth.integer, height: max(managerSpecial.height, nextManagerSpecial.height) * divisibleUnitWidth))
                            
                            // Set the attributes of this stack view
                            horizontalStackView.axis = .horizontal
                            horizontalStackView.alignment = .center
                            horizontalStackView.spacing = 20.0
                            horizontalStackView.distribution = .fillProportionally
                            
                            // Reset the X factor
                            adjustmentFactorX = 0
                            
                            // Add the first custom view to the
                            
                            // Increment the X factor
                            adjustmentFactorX = adjustmentFactorX + managerSpecial.width * divisibleUnitWidth + self.verticalStackView.spacing.integer
                            
                            
                        }
                    }
                    
                }
                
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    fileprivate func doesFitInSameLine(currentManagerSpecial: ManagerSpecial, nextManagerSpecial: ManagerSpecial, canvasUnit: Int) -> Bool {
        
        // Start with false - assume that the specials won't fit in the same row
        var result: Bool = false
        
        // Check if the sum of the widths is less than or equal to the canvasUnit
        if currentManagerSpecial.width + nextManagerSpecial.width <= canvasUnit {
            result = true
        }
        
        return result
    }
}

