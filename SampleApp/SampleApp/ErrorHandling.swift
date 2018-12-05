//
//  ErrorHandling.swift
//  SampleApp
//
//  Created by Nirmala Venkat on 12/5/18.
//  Copyright © 2018 nirmala. All rights reserved.
//

import Foundation

// Custom error enum
enum SampleAppError: Error {
    case runtimeError(String)
}
