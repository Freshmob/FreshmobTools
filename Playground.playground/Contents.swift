//: Playground - noun: a place where people can play

import UIKit

protocol AttributeConvertible: CustomStringConvertible, RawRepresentable {}

extension AttributeConvertible {
    var description: String { return String(describing: self.rawValue) }
}

enum Test: CGFloat, AttributeConvertible {
    case f = 12.0
    case d = 13.0
}

let a = "test".localizedCapitalized
