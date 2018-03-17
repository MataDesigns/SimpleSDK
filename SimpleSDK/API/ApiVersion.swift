//
//  SimpleAPI.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/15/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit

/// Common Api versioning strings
///
/// - empty: Empty string
/// - none: api without a version (or default api)
/// - v1: api v1 uri `api/v1`
/// - v2: api v2 uri `api/v2`
/// - v3: api v3 uri `api/v3`
/// - v4: api v4 uri `api/v4`
/// - v5: api v5 uri `api/v5`
/// - v6: api v6 uri `api/v6`
/// - v7: api v7 uri `api/v7`
/// - v8: api v8 uri `api/v8`
/// - v9: api v9 uri `api/v9`
/// - v10: api v10 uri `api/v10`
public enum ApiVersion: String {
    case empty = ""
    case none = "api/"
    case v1 = "api/v1/"
    case v2 = "api/v2/"
    case v3 = "api/v3/"
    case v4 = "api/v4/"
    case v5 = "api/v5/"
    case v6 = "api/v6/"
    case v7 = "api/v7/"
    case v8 = "api/v8/"
    case v9 = "api/v9/"
    case v10 = "api/v10/"
}
