//
//  PhilinqSDK.swift
//  SimpleSDKTests
//
//  Created by Nicholas Mata on 3/15/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit
import SimpleSDK
import EasyJSON

class PhilinqStorage: SimpleApiStorage {
    static var accessToken: String? {
        get {
            guard let token =  get(key: "accesstoken") as? String else {
                return nil
            }
            return token
        }
        set {
            set(value: newValue, key: "accesstoken")
        }
    }
    
    static var tokenHeader: [String : String] {
        guard let accessToken = accessToken else {
            return [:]
        }
        return ["Authorization": "Bearer \(accessToken)"]
    }
    
    static var storeId: String {
        return "0e8411005e6047dbbbf51ea70e101e6f"
    }
    
    static func set(value: Any?, key: String) {
        let defaults = UserDefaults.standard
        defaults.set(value, forKey: "philinq.\(key)")
    }
    
    static func get(key: String) -> Any? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: "philinq.\(key)")
    }
}

//class PhilinqApi: SimpleApi {
//    static var clientId: String? = ""
//
//    static var clientSecret: String? = ""
//
//    static var responseQueue: DispatchQueue = DispatchQueue(label: "com.philinq.apiresponse", qos: .utility, attributes: [.concurrent])
//}

class MillenniumStoreModel: EasyModel, SimpleModel {
    var id: String!
    var hasImport: Bool = false
    var lastImport: Date?
}

class MillenniumClient: SimpleJsonClient {
    func last() -> Future<MillenniumStoreModel> {
        return Future { completion in
            self.jsonRequest(.get, "\(PhilinqStorage.storeId)/millennium/last", .v3, headers: PhilinqStorage.tokenHeader).subscribe(onNext: { (jResponse) in
                guard case Json.object(let jsonObject) = jResponse.body else {
                    return completion(.failure(SimpleJsonError.jsonRootMismatch))
                }
                var storeModel = MillenniumStoreModel()
                try? storeModel.fill(withDict: jsonObject)
                completion(.success(storeModel))
            }, onError: { (error) in
                completion(.failure(error))
            })
        }
    }
}

class LoginRequest: EasyModel {
    override var _options_: EasyModelOptions {
        return EasyModelOptions(snakeCased: true)
    }
    
    var grantType: String = "password"
    var username: String?
    var password: String?
}

class LoginModel: EasyModel {
    override var _options_: EasyModelOptions {
        return EasyModelOptions(snakeCased: true)
    }
    
    var accessToken: String?
    var tokenType: String?
    var expiresIn: Int = -1
    var userName: String?
    var storeId: String?
    var phoneNumber: String?
}

class AuthClient: SimpleJsonClient {
    func login(model: LoginRequest) -> Future<LoginModel> {
        return Future { completion in
            self.request(.post, "token", .none, parameters: model.toJson()).responseJSON().then(self.toJson).subscribe(onNext: { (jresponse) in
                guard case Json.object(let jsonObject) = jresponse.body else {
                    return completion(.failure(SimpleJsonError.jsonRootMismatch))
                }
                var model = LoginModel()
                try? model.fill(withDict: jsonObject)
                PhilinqStorage.accessToken = model.accessToken
                completion(.success(model))
            }, onError: { (error) in
                completion(.failure(error))
            })
        }
    }
}

class PhilinqSDK: SimpleSDK {
    static var domain: String = "http://philinq.com/"
    
    static var Millennium = MillenniumClient(version: .v3, domain: PhilinqSDK.domain)
    
    static var Auth = AuthClient(version: .none, domain: PhilinqSDK.domain)
}
