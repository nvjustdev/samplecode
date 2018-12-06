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
    
    lazy var specialImage: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 20, y: 20, width: 80, height: 80))
        print(origin)
        return image
    }()
    
    lazy var specialHeadline: UILabel = {
        let label = UILabel(frame: CGRect(x: 20, y: 100, width: 200, height: 30))
        label.numberOfLines = 0
        return label
    }()
    
    lazy var originalPrice: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 20, width: 30, height: 10))
        return label
    }()
    
    lazy var specialPrice: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 20, width: 30, height: 10))
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
        
        // Set the background color to be white
        self.backgroundColor = .white
        
        // Change the corners to be rounded
        self.layer.cornerRadius = 8.0
        
        // Set the origin
        self.origin = self.frame.origin
        
        // Add all the subviews
        self.addSubview(specialHeadline)
        self.addSubview(specialImage)
        self.addSubview(originalPrice)
        self.addSubview(specialPrice)
    }
}
