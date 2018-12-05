//
//  UsefulExtensions.swift
//  SampleApp
//
//  Created by Nirmala Venkat on 12/5/18.
//  Copyright © 2018 nirmala. All rights reserved.
//

import Foundation
import UIKit

extension CGFloat {
    
    // Get the double value of the CGFloat
    var double: Double { return Double(self) }
    
    // Get the integer value of the CGFloat
    var integer: Int { return Int(self) }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
