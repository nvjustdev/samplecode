//
//  ManagerSpecialView.swift
//  SampleApp
//
//  Created by Nirmala Venkat on 12/5/18.
//  Copyright © 2018 nirmala. All rights reserved.
//

import Foundation
import UIKit

class ManagerSpecialView: UIView {
    
    // Create the icon for the Manager's special
    lazy var iconImageView: UIImageView = {
        let contentView = UIImageView(frame: CGRect(x: 10.0, y: 30.0, width: 50.0, height: 50.0))
        
        return contentView
    }()
    
    // Create the label for the description
    lazy var specialTitle: UILabel = {
        let title: UILabel = UILabel(frame: CGRect(x: 10.0, y: 150.0, width: 100.0, height: 100.0))
        title.textAlignment = .center
        title.numberOfLines = 0
        
        return title
    }()
    
    // Create the label for the original price
    lazy var originalPrice: UILabel = {
        let price: UILabel = UILabel(frame: CGRect(x: 150.0, y: 30.0, width: 100.0, height: 100.0))
        
        return price
    }()
    
    // Create the label for the original price
    lazy var price: UILabel = {
        let price: UILabel = UILabel(frame: CGRect(x: 150.0, y: 30.0, width: 100.0, height: 100.0))
        
        return price
    }()
    
    // Regular initializer
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    // Coder initializer
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Setup of the custom view
    private func setupView() {
        backgroundColor = .white
        addSubview(iconImageView)
        addSubview(specialTitle)
        addSubview(originalPrice)
        addSubview(price)
    }
}
