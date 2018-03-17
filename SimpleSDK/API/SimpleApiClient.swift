//
//  SimpleClient.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/15/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit
import Alamofire

public typealias JSON = [String: Any]
public typealias Headers = [String: Any]

public struct JSONResponse {
    public var body: JSON
    public var headers: Headers
}

public enum SimpleApiError: Error {
    case api(JSON), invalidJson, missingJson, invalidHeaaders
}

open class SimpleApiClient {
    var version: ApiVersion
    var domain: String
    
    public init(version: ApiVersion, domain: String) {
        self.version = version
        self.domain = domain
    }
    
    private func buildUrl(_ relativeUrl: String, _ apiVersion: String?) -> String {
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
    
    public func jsonRequest(_ method: Alamofire.HTTPMethod,
                     _ relativeUrl: String,
                     _ apiVersion: ApiVersion? = nil,
                     parameters: Parameters? = nil,
                     encoding: Alamofire.ParameterEncoding = JSONEncoding.default,
                     headers: [String: String]? = nil) -> Future<JSONResponse> {
        let url = buildUrl(relativeUrl, apiVersion?.rawValue)
        
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON().then(self.toJson)
    }
    
    public func toJson(response: Alamofire.DataResponse<Any>) -> Future<JSONResponse> {
        return Future { completion in
            switch response.result {
            case .failure(let error):
                guard let data = response.data else {
                    return completion(.failure(error))
                }
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON else {
                        return completion(.failure(SimpleApiError.invalidJson))
                    }
                    return completion(.failure(SimpleApiError.api(json)))
                } catch {
                    return completion(.failure(error))
                }
            case .success(let data):
                guard let json = data as? JSON else {
                    return completion(.failure(SimpleApiError.invalidJson))
                }
                guard let headers = response.response?.allHeaderFields as? [String: Any] else {
                    return completion(.failure(SimpleApiError.invalidHeaaders))
                }
                let jsonResponse = JSONResponse(body: json, headers: headers)
                return completion(.success(jsonResponse))
            }
            
        }
    }
    
}
