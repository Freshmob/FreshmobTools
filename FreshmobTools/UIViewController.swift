//
//  UIViewController.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 17/11/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import UIKit

public protocol StoryboardIdentifiable {
    static var storyboardIdentifier: String { get }
}

public extension StoryboardIdentifiable where Self: UIViewController {
    static var storyboardIdentifier: String {
        return String(describing: self)
    }
}

extension UIViewController : StoryboardIdentifiable { }

public extension UIStoryboard {
    func instantiateViewController<T>() -> T? where T: UIViewController, T: StoryboardIdentifiable {
        return self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T
    }
}
