//
//  ManagerSpecialStructs.swift
//  SampleApp
//
//  Created by Nirmala Venkat on 12/4/18.
//  Copyright © 2018 nirmala. All rights reserved.
//

import Foundation

// The following is the struct for the entire response
struct Response : Decodable {
    
    // Each of the variables need to keep with the naming convention of the JSON for decoding
    let managerSpecials: [ManagerSpecial]
    let canvasUnit: Int
}


// The following is the struct for the individual manager specials
struct ManagerSpecial : Decodable {
    
    // Each of the variables need to keep with the naming convention of the JSON for decoding
    let imageUrl: String
    let width: Int
    let height: Int
    let display_name: String
    let original_price: String
    let price: String
}
