//
//  SimpleApiModels.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/15/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit
import EasyJSON

public protocol SimpleModel {
    associatedtype Key
    var id: Key {get set}
}

public protocol SimpleRestModel {
    associatedtype Key
    var id: Key {get set}
    
    static func get(id: Key) -> Future<Self>
    static func get() -> Future<Self>
    func update()
    func delete()
}
