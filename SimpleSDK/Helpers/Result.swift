//
//  Result.swift
//  MakeCentsSdkiOS
//
//  Created by Nicholas Mata on 1/10/18.
//  Copyright © 2018 E7Systems. All rights reserved.
//

import UIKit

public enum Result<T> {
    case success(T)
    case failure(Error)
}

extension Result {
    public func then<U>(_ f: (T)->U) -> Result<U> {
        switch self {
        case .success(let t): return .success(f(t))
        case .failure(let err): return .failure(err)
        }
    }
    public func then<U>(_ f: (T)->Result<U>) -> Result<U> {
        switch self {
        case .success(let t): return f(t)
        case .failure(let err): return .failure(err)
        }
    }
}

extension Result {
    // Return the value if it's a .Success or throw the error if it's a .Failure
    public func resolve() throws -> T {
        switch self {
        case Result.success(let value): return value
        case Result.failure(let error): throw error
        }
    }
    
    // Construct a .Success if the expression returns a value or a .Failure if it throws
    public init(_ throwingExpr: () throws -> T) {
        do {
            let value = try throwingExpr()
            self = Result.success(value)
        } catch {
            self = Result.failure(error)
        }
    }
}
