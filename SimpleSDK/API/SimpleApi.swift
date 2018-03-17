//
//  SimpleAPI.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/15/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit

public enum ApiVersion: String {
    case none = "", v0 = "api/", v1 = "api/v1/", v2 = "api/v2/", v3 = "api/v3/", v4 = "api/v4/", v5 = "api/v5/", v6 = "api/v6/"
}

public protocol SimpleApi {
    static var clientId: String? { get set }
    static var clientSecret: String? { get set }
    
    static var responseQueue: DispatchQueue { get set }
}
