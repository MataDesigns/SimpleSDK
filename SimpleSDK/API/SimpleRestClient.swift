//
//  SimpleRestClient.swift
//  SimpleSDK
//
//  Created by Nicholas Mata on 3/16/18.
//  Copyright © 2018 MataDesigns. All rights reserved.
//

import UIKit

protocol SimpleRestClient {
    associatedtype Key
    associatedtype Model

    func get(id: Key) -> Future<Model>
    func get() -> Future<Model>
    func update() -> Future<Model>
    func delete()
}
