//
//  MCStorage.swift
//  MakeCentsSdkiOS
//
//  Created by Nicholas Mata on 1/11/18.
//  Copyright © 2018 E7Systems. All rights reserved.
//

import UIKit

public protocol SimpleApiStorage {
    static var accessToken: String? { get set }
    
    static var tokenHeader: [String: String] { get }
}
