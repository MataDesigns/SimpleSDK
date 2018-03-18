//
//  SimpleJSONClient.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/17/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit
import Alamofire

open class SimpleJsonClient: SimpleApiClient {

    public func jsonRequest(_ method: Alamofire.HTTPMethod,
                            _ relativeUrl: String,
                            _ apiVersion: ApiVersion? = nil,
                            parameters: Parameters? = nil,
                            encoding: Alamofire.ParameterEncoding = JSONEncoding.default,
                            headers: [String: String]? = nil) -> Future<SimpleJsonResponse> {
        let url = buildUrl(relativeUrl, apiVersion?.rawValue)
        
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: headers).validate().responseJSON().then(self.toJson)
    }
    
    public func toJson(response: Alamofire.DataResponse<Any>) -> Future<SimpleJsonResponse> {
        return Future { completion in
            guard let urlResponse = response.response else {
                return completion(.failure(SimpleApiError.noResponse))
            }
            let statusCode = urlResponse.statusCode
            let headers = urlResponse.allHeaderFields
            guard statusCode != SimpleStatusCode.NoContent.rawValue else  {
                let jsonResponse = SimpleJsonResponse(body: .empty, headers: headers, statusCode: statusCode)
                return completion(.success(jsonResponse))
            }
            switch response.result {
            case .failure(let error):
                guard let data = response.data else {
                    return completion(.failure(error))
                }
                
                do {
                    let data = try JSONSerialization.jsonObject(with: data, options: [])
                    guard let json = Json.from(data) else {
                        return completion(.failure(SimpleJsonError.invalidJson))
                    }
                    let jsonResponse = SimpleJsonResponse(body: json, headers: headers, statusCode: statusCode)
                    let error = SimpleJsonError.api(jsonResponse)
                    return completion(.failure(error))
                } catch {
                    return completion(.failure(error))
                }
            case .success(let data):
                guard let json = Json.from(data) else {
                    return completion(.failure(SimpleJsonError.invalidJson))
                }
                let jsonResponse = SimpleJsonResponse(body: json, headers: headers, statusCode: statusCode)
                return completion(.success(jsonResponse))
            }
            
        }
    }
    
}
