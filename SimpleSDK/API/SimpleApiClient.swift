//
//  SimpleClient.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/15/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit
import Alamofire

open class SimpleApiClient {
    var version: ApiVersion
    var domain: String
    
    public init(version: ApiVersion, domain: String) {
        self.version = version
        self.domain = domain
    }
    
    internal func buildUrl(_ relativeUrl: String, _ apiVersion: String?) -> String {
        var apiBaseUrl = "\(domain)\(version.rawValue)"
        if let versionOverride = apiVersion {
            
            apiBaseUrl = "\(domain)\(versionOverride)"
        }
        return "\(apiBaseUrl)\(relativeUrl)"
    }
    
    public func request(_ method: Alamofire.HTTPMethod,
                        _ relativeUrl: String,
                        _ apiVersion: ApiVersion? = nil,
                        parameters: Parameters? = nil,
                        encoding: Alamofire.ParameterEncoding = URLEncoding.default,
                        headers: [String: String]? = nil) -> Alamofire.DataRequest {
        let url = buildUrl(relativeUrl, apiVersion?.rawValue)
        
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate()
    }

}
