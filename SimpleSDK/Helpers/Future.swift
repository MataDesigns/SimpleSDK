//
//  Future.swift
//  MakeCentsSdkiOS
//
//  Created by Nicholas Mata on 1/10/18.
//  Copyright © 2018 E7Systems. All rights reserved.
//

import UIKit

public struct Future<T> {
    public typealias ResultType = Result<T>
    
    private let operation: ( @escaping (ResultType) -> ()) -> ()
    
    public init(result: ResultType) {
        self.init(operation: { completion in
            completion(result)
        })
    }
    
    public init(value: T) {
        self.init(result: .success(value))
    }
    
    public init(error: Error) {
        self.init(result: .failure(error))
    }
    
    public init(operation: @escaping ( @escaping (ResultType) -> ()) -> ()) {
        self.operation = operation
    }
    
    fileprivate func then(_ completion: @escaping (ResultType) -> ()) {
        self.operation() { result in
            completion(result)
        }
    }
    
    public func subscribe(onNext: @escaping (T) -> Void = { _ in }, onError: @escaping (Error) -> Void = { _ in }) {
        self.then { result in
            switch result {
            case .success(let value): onNext(value)
            case .failure(let error): onError(error)
            }
        }
    }
}

extension Future {
    public func then<U>(_ f: @escaping (T) throws -> U) -> Future<U> {
        return Future<U>(operation: { completion in
            self.then { result in
                switch result {
                    
                case .success(let resultValue):
                    do {
                        let transformedValue = try f(resultValue)
                        completion(Result.success(transformedValue))
                    } catch let error {
                        completion(Result.failure(error))
                    }
                    
                    
                case .failure(let errorBox):
                    completion(Result.failure(errorBox))
                    
                }
            }
        })
    }
    
    public func then<U>(_ f: @escaping () -> Future<U>) -> Future<U> {
        return Future<U>(operation: { completion in
            self.then { firstFutureResult in
                switch firstFutureResult {
                case .success(_): f().then(completion)
                case .failure(let error): completion(Result.failure(error))
                }
            }
        })
    }
    
    public func then<U>(_ f: @escaping (T) -> Future<U>) -> Future<U> {
        return Future<U>(operation: { completion in
            self.then { firstFutureResult in
                switch firstFutureResult {
                case .success(let value): f(value).then(completion)
                case .failure(let error): completion(Result.failure(error))
                }
            }
        })
    }
}
