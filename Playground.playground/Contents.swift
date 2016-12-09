//: Playground - noun: a place where people can play

import UIKit

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

struct A:KeyValueCodable {
    var propertyA = "123"
    var propertyB = "ABC"
    
    var keys: [String] {
        let mirror = Mirror(reflecting: self)
        return mirror.children.map({ (k,v) -> String in
            if let unwrapped = k { return unwrapped }
            return ""
        })
    }
    
    func clone() -> Self {
        let a = A()
        a.keys
    }
}

let a = A()
print(a.keys)

