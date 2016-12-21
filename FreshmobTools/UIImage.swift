//
//  UIImageExtensions.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 30/11/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

import UIKit
import Foundation

public extension UIImage {
    var tempFileUrl: URL? {
        let tempUrlString = NSTemporaryDirectory().appending(NSUUID().uuidString).appending(".jpg")
        guard let data = UIImageJPEGRepresentation(self, 1) else {
            return nil
        }
        let tempUrl = URL(fileURLWithPath: tempUrlString)
        try! data.write(to: tempUrl, options: .atomic)
        return tempUrl
    }
}
