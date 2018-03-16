//
//  Alamofire+Future.swift
//  MakeCentsSdkiOS
//
//  Created by Nicholas Mata on 1/11/18.
//  Copyright © 2018 E7Systems. All rights reserved.
//

import UIKit
import Alamofire

public extension Alamofire.DataRequest {
    /// Adds a handler to be called once the request has finished.
    public func responseJSON(options: JSONSerialization.ReadingOptions = .allowFragments) -> Future<(DataResponse<Any>)> {
        return Future { completion in
            self.responseJSON(queue: nil, options: options) { response in
                 completion(.success(response))
            }
        }
    }
}
