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
    
    // A flag to skip placement
    var shouldSkipPlacement: Bool = false
    
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
                    //TODO: Use Layout Constraints instead of adjustment factor - 12/25/2018
                    var adjustmentFactorY: Int = 0
                    var adjustmentFactorX: Int = 0
                    
                    // Get the number of manager specials
                    let numberManagerSpecials = managerSpecialList.count
                    
                    // For each ManagerSpecial in the list, process the width and the height
                    for index in 0...(numberManagerSpecials - 1) {
                        
                        // Check if the placement should be skipped
                        if !self.shouldSkipPlacement {
                            
                            // Get the current specials
                            let managerSpecial: ManagerSpecial = managerSpecialList[index]
                            
                            // Get the next specials
                            var nextManagerSpecial: ManagerSpecial?
                            
                            // Check if this is the last one
                            if index == numberManagerSpecials - 1 {
                                
                                // The next is nil
                                nextManagerSpecial = nil
                            } else {
                                
                                // Get the next since there are more
                                nextManagerSpecial = managerSpecialList[index + 1]
                            }
                            
                            // Get the result for the fit
                            let result: Bool = self.doesFitInSameLine(currentManagerSpecial: managerSpecial, nextManagerSpecial: nextManagerSpecial, canvasUnit: canvasUnit)
                            
                            // If the check for same row resulted in false
                            if !result {
                                
                                // Should not skip the placement of the next special
                                self.shouldSkipPlacement = false
                                
                                let customView = self.getIndividualManagerSpecialView(result: result, adjustmentFactorX: adjustmentFactorX, adjustmentFactorY: adjustmentFactorY, divisibleUnitWidth: divisibleUnitWidth, managerSpecial: managerSpecial)
                                
                                // Increment the Y factor
                                adjustmentFactorY = adjustmentFactorY + managerSpecial.height * divisibleUnitWidth + self.verticalStackView.spacing.integer
                                
                                // add the view to the stack
                                self.verticalStackView.addSubview(customView)
                            } else {
                                
                                // Check for same row resulted in true
                                // Create a horizontal UIStackView as wide as the vertical stack view
                                // There's no need to check for nextManagerSpecial being nil as the result can be true only if nextManagerSpecial is present
                                
                                // Should skip the placement of the next special
                                self.shouldSkipPlacement = true
                                
                                let horizontalStackView: UIStackView = UIStackView.init(frame: CGRect(x: 0, y: adjustmentFactorY + 0, width: viewWidth.integer, height: max(managerSpecial.height, nextManagerSpecial!.height) * divisibleUnitWidth))
                                
                                // Set the attributes of this stack view
                                horizontalStackView.axis = .horizontal
                                horizontalStackView.alignment = .center
                                horizontalStackView.spacing = 6.0
                                horizontalStackView.distribution = .fillProportionally
                                
                                // Reset the X factor
                                adjustmentFactorX = 0
                                
                                // Get and add the first custom view to the horizontal stack view
                                let firstCustomView = self.getIndividualManagerSpecialView(result: result, adjustmentFactorX: adjustmentFactorX, adjustmentFactorY: adjustmentFactorY, divisibleUnitWidth: divisibleUnitWidth, managerSpecial: managerSpecial)
                                horizontalStackView.addSubview(firstCustomView)
                                
                                // Increment the X factor
                                adjustmentFactorX = adjustmentFactorX + managerSpecial.width * divisibleUnitWidth + horizontalStackView.spacing.integer
                                
                                // Get and add the next custom view to the horizontal stack view
                                let nextCustomView = self.getIndividualManagerSpecialView(result: result, adjustmentFactorX: adjustmentFactorX, adjustmentFactorY: adjustmentFactorY, divisibleUnitWidth: divisibleUnitWidth, managerSpecial: nextManagerSpecial!)
                                
                                horizontalStackView.addSubview(nextCustomView)
                                
                                // Add the horizontal stack view to the vertical stack view
                                self.verticalStackView.addSubview(horizontalStackView)
                            }
                        }
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // To check if the current and the next special will fit in a line
    // MARK: Assumption that no more than two specials will look aesthetically good together
    // TODO: Need to generalize this by 12/25/2018
    fileprivate func doesFitInSameLine(currentManagerSpecial: ManagerSpecial, nextManagerSpecial: ManagerSpecial?, canvasUnit: Int) -> Bool {
        
        // Start with false - assume that the specials won't fit in the same row
        var result: Bool = false
        
        if nextManagerSpecial == nil {
            return result
        }
        
        // Check if the sum of the widths is less than or equal to the canvasUnit
        if currentManagerSpecial.width + nextManagerSpecial!.width <= canvasUnit {
            result = true
        }
        
        return result
    }
    
    // To get the custom view to add to the stack
    fileprivate func getIndividualManagerSpecialView(result: Bool, adjustmentFactorX: Int, adjustmentFactorY: Int, divisibleUnitWidth: Int, managerSpecial: ManagerSpecial) -> IndividualManagerSpecialView {
        
        // Create a custom view for the special
        let individualManagerSpecialView: IndividualManagerSpecialView = IndividualManagerSpecialView(frame: CGRect(x: (result ? 1 : 0) * adjustmentFactorX + 0, y:  (result ? 0 : 1) * adjustmentFactorY + 0, width: managerSpecial.width * divisibleUnitWidth - (result ? 1 : 0) * 3, height: managerSpecial.height * divisibleUnitWidth))
        
        // Convert the url string to URL entity
        let url = URL(string: managerSpecial.imageUrl)
        
        // Set the attributes of this view
        // Checking to avoid nil value for the variable
        if url != nil {
            individualManagerSpecialView.specialImage.load(url: url!)
        }
        
        let attributesForSpecialPrice = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
        let attributedSpecialPrice = NSMutableAttributedString(string:"$" + managerSpecial.price, attributes:attributesForSpecialPrice)
        
        let attributesForOriginalPrice = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20), NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue] as [NSAttributedString.Key : Any]
        let attributedOriginalPrice = NSMutableAttributedString(string: "$" + managerSpecial.original_price, attributes:attributesForOriginalPrice)
        
        print(managerSpecial.display_name.count)

        individualManagerSpecialView.specialPrice.attributedText = attributedSpecialPrice
        individualManagerSpecialView.originalPrice.attributedText = attributedOriginalPrice
        individualManagerSpecialView.specialHeadline.text = managerSpecial.display_name
        
        // Set the constraints
        individualManagerSpecialView.heightAnchor.constraint(equalToConstant: (managerSpecial.height * divisibleUnitWidth).cgFloat)
        individualManagerSpecialView.widthAnchor.constraint(equalToConstant: (managerSpecial.width * divisibleUnitWidth).cgFloat)
        
        return individualManagerSpecialView
    }
}

