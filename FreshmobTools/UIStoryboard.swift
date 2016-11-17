//
//  UIStoryboard.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 17/11/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

import Foundation

public protocol UIStoryboardable: RawRepresentable {
    var name: String { get }
    func instanceInBundle(bundle: Bundle?) -> UIStoryboard
}

public extension UIStoryboardable {
    var name: String { return String(describing: rawValue) }
    func instanceInBundle(bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: nil)
    }
}

// Implement as:
//
// enum Storyboard: String, UIStoryboardable {
//    case Main
//    case News
//    case OtherStoryboard
// }
//
// let storyboard = Storyboard.Main.instanceInBundle()

