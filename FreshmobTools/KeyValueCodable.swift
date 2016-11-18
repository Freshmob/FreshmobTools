//
//  KVO.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 18/11/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

import Foundation

public protocol KeyValueCodable {
    func value<T>(forKey key: String) -> T?
}

public extension KeyValueCodable {
    func value<T>(forKey key: String) -> T? {
        let mirror = Mirror(reflecting: self)
        for case let (label?, value) in mirror.children {
            if label == key { return value as? T }
        }
        return nil
    }
}
