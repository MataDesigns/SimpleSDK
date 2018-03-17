//
//  SimpleApiResponse.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/17/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit
import EasyJSON

public typealias Headers = [AnyHashable: Any]

public protocol SimpleApiResponse {
    associatedtype BodyType
    var body: BodyType {get set}
    var headers: Headers {get set}
    var statusCode: Int {get set}
}
