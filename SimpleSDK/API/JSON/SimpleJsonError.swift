//
//  SimpleJSONError.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/17/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit

/// JSON specific api errors.
///
/// - api: API error server responded with error status code.
/// - invalidJson: JSON is invalid (eg. incorrectly formatted).
/// - jsonRootMismatch: JSON root object was incorrect specified.
public enum SimpleJsonError: Error {
    case api(SimpleJsonResponse)
    case invalidJson
    case jsonRootMismatch
}
