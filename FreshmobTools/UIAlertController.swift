//
//  UIAlertController.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 1/12/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

public extension UIAlertController {
    func addActions(_ actions: UIAlertAction...) {
        actions.forEach { self.addAction($0) }
    }
}

