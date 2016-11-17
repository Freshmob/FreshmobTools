//
//  ImagePickerPresenter.swift
//  Bloodstock
//
//  Created by Rogerio de Paula Assis on 4/11/16.
//  Copyright © 2016 Arrowfield. All rights reserved.
//

import UIKit

public protocol MediaPickerPresenter {
    func presentMediaPicker(fromController controller: UIViewController, handler: MediaPickerHandler)
    func presentDocumentPicker(fromController controller: UIViewController, handler: MediaPickerHandler)
    func didSelectFromMediaPicker(withImage image: UIImage)
    func didSelectFromMediaPicker(withUrl url: URL)
}

public extension MediaPickerPresenter {
    func presentMediaPicker(fromController controller: UIViewController, handler: MediaPickerHandler) {
        handler.delegate = self
        controller.present(handler.imagePicker, animated: true, completion: nil)
    }
    
    func presentDocumentPicker(fromController controller: UIViewController, handler: MediaPickerHandler) {
        handler.delegate = self
        controller.present(handler.documentPicker, animated: true, completion: nil)
    }
    
}
