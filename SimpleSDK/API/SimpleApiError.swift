//
//  SimpleApiError.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/17/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit

/// Basic api errors
///
/// - noResponse: No response from server.
/// - noStatusCode: No status code.
public enum SimpleApiError: Error {
    case noResponse
    case noStatusCode
}
