//
//  IndividualManagerSpecialView.swift
//  SampleApp
//
//  Created by Nirmala Venkat on 12/5/18.
//  Copyright © 2018 nirmala. All rights reserved.
//

import UIKit

class IndividualManagerSpecialView: UIView {

    let kCONTENT_XIB_NAME = "IndividualManagerSpecialView"
    
    var origin : CGPoint = CGPoint.init()
    var width : Double = 10.0
    
    lazy var specialImage: UIImageView = {
        let image = UIImageView.init()
        return image
    }()
    
    /*For the font please use Apple's default font: San Francisco. The crossed out price color is: #989898. The price color is: #179C77 and the name text color is: #000000. There is also a 1px border around the cell of #D8D8D8. Hope that helps.*/
    
    lazy var specialHeadline: UILabel = {
        let label = UILabel.init()
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.init(name: "San Francisco", size: 10.0)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var originalPrice: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor(red:0.60, green:0.60, blue:0.60, alpha:1.0)
        label.font = UIFont.init(name: "San Francisco", size: 30.0)
        label.textAlignment = .right
        return label
    }()
    
    lazy var specialPrice: UILabel = {
        let label = UILabel.init()
        label.textColor = UIColor(red:0.09, green:0.61, blue:0.47, alpha:1.0)
        label.font = UIFont.init(name: "San Francisco", size: 30.0)
        label.textAlignment = .right
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }
    
    func commonSetup() {
        
        // Set the shadow
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 5.0
        
        // Set the background color to be white
        self.backgroundColor = .white
        
        // Change the corners to be rounded
        self.layer.cornerRadius = 8.0
        
        // Set the border
        self.layer.borderColor = UIColor(red:0.85, green:0.85, blue:0.85, alpha:1.0).cgColor
        self.layer.borderWidth = 1
        
        // Set the origin
        self.origin = self.frame.origin
        
        // Set the width of the frame
        self.width = self.frame.width.double
        
        // Add all the subviews
        self.addSubview(specialHeadline)
        self.addSubview(specialImage)
        self.addSubview(originalPrice)
        self.addSubview(specialPrice)
        
        // specialHeadline: constraints
        specialHeadline.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            specialHeadline.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 22.0),
            specialHeadline.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            specialHeadline.widthAnchor.constraint(lessThanOrEqualToConstant: CGFloat(self.width * 0.70)),
            specialHeadline.heightAnchor.constraint(greaterThanOrEqualToConstant: 0.0)])
        
        // specialImage: contraints
        specialImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            specialImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 30.0),
            specialImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15.0),
            specialImage.widthAnchor.constraint(equalToConstant: 65.0),
            specialImage.heightAnchor.constraint(equalToConstant: 65.0)
            ])
        
        // originalPrice: contraints
        originalPrice.translatesAutoresizingMaskIntoConstraints = false
        
        let originalPriceConstraint = NSLayoutConstraint.init(item: originalPrice, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -15.0)
        originalPriceConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            originalPrice.widthAnchor.constraint(equalToConstant: (width * 0.40).cgFloat),
            originalPrice.heightAnchor.constraint(equalToConstant: 30.0),
            originalPrice.topAnchor.constraint(equalTo: specialImage.topAnchor, constant: 5.0)
            ])
        
        // specialPrice: contraints
        specialPrice.translatesAutoresizingMaskIntoConstraints = false
        
        let specialPriceConstraint = NSLayoutConstraint.init(item: specialPrice, attribute: .trailingMargin, relatedBy: .equal, toItem: self, attribute: .trailingMargin, multiplier: 1.0, constant: -15.0)
        specialPriceConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            specialPrice.widthAnchor.constraint(equalToConstant: (width * 0.40).cgFloat),
            specialPrice.heightAnchor.constraint(equalToConstant: 30.0),
            specialPrice.topAnchor.constraint(equalTo: originalPrice.bottomAnchor)
            ])
    }
}
