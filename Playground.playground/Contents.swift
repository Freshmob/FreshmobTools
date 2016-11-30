//: Playground - noun: a place where people can play

import UIKit

class TestClass {
    var test: String = ""
    static func testFunc() {}
}

let t = TestClass()

let mirror = Mirror(reflecting: t)
for case let (label?, value) in mirror.children {
    print("\(label): \(value)")
}

print(mirror.children.count)
print(mirror.description)

let selector = Selector(("test"))
t.respondsTo(selector)
