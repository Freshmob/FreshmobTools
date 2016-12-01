//
//  AttributeConvertible.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 1/12/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

import Foundation

public protocol AttributeConvertible: CustomStringConvertible, RawRepresentable {}

public extension AttributeConvertible {
    var description: String { return String(describing: self.rawValue) }
}
