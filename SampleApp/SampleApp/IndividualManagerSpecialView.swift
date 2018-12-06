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
        let image = UIImageView(frame: CGRect(x: 10, y: center.y - 70, width: 70, height: 70))
        return image
    }()
    
    lazy var specialHeadline: UILabel = {
        print(center.x)
        print((width * 0.85)/2)
        let label = UILabel(frame: CGRect(x: 25, y: center.y, width: (width * 0.85).cgFloat, height: 80))//UILabel(frame: CGRect(x: center.x - ((width * 0.90)/2).cgFloat, y: center.y + 20, width: (width * 0.90).cgFloat, height: 75))
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.init(name: "San Francisco", size: 10.0)
        print(label.center)
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
    }
}
