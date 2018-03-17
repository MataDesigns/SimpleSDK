//
//  SimpleJSONResponse.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/17/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit

public typealias JsonObject = [String: Any]

public enum Json {
    case object(JsonObject)
    case array([JsonObject])
    
    static func from(_ data: Any) -> Json? {
        switch data {
        case let jsonObject as JsonObject:
            return Json.object(jsonObject)
        case let jsonArray as [JsonObject]:
            return Json.array(jsonArray)
        default:
            return nil
        }
    }
}

public struct SimpleJsonResponse: SimpleApiResponse {
    public var body: Json
    public var headers: Headers
    public var statusCode: Int
}
