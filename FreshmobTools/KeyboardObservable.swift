//
//  KeyboardObservable.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 17/11/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

import Foundation
import UIKit

public typealias KeyboardAnimationTuple = (duration: TimeInterval, curve: UInt)

public protocol KeyboardObservable {
    func subscribeToKeyboardNotifications()
    func unsubscribeToKeyboardNotifications()
    var keyboardWillShowCallback: (CGFloat, KeyboardAnimationTuple) -> Void { get }
    var keyboardWillHideCallback: (CGFloat, KeyboardAnimationTuple) -> Void { get }
}

public extension KeyboardObservable where Self: UIViewController {
        
    func unsubscribeToKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: UIResponder.keyboardWillShowNotification,
                                       object: nil,
                                       queue: nil) { [weak self] (notification) in
            if let userInfo = notification.userInfo,
               let keyboardFrame = self?.getKeyboardRect(forKey: UIResponder.keyboardFrameEndUserInfoKey,
                                                          withUserInfo: userInfo),
                let values = self?.getDurationAndCurve(fromNotificationUserInfo: userInfo) {
                let bottomLayoutGuideLength = self?.bottomLayoutGuide.length ?? 0
                let offset = keyboardFrame.size.height - bottomLayoutGuideLength
                self?.keyboardWillShowCallback(offset, values)
            }
        }
        notificationCenter.addObserver(forName: UIResponder.keyboardWillHideNotification,
                                       object: nil,
                                       queue: nil) { [weak self] (notification) in
            if let userInfo = notification.userInfo,
               let keyboardFrame = self?.getKeyboardRect(forKey: UIResponder.keyboardFrameEndUserInfoKey,
                                                          withUserInfo: userInfo),
                let values = self?.getDurationAndCurve(fromNotificationUserInfo: userInfo) {
                let bottomLayoutGuideLength = self?.bottomLayoutGuide.length ?? 0
                let offset = keyboardFrame.size.height + bottomLayoutGuideLength
                self?.keyboardWillHideCallback(offset, values)
            }
        }
    }
    
    
    private func getKeyboardRect(forKey key: String,
                         withUserInfo userInfo: [AnyHashable: Any]) -> CGRect? {
        return (userInfo[key] as? NSValue)?.cgRectValue
    }
    
    private func getDurationAndCurve(fromNotificationUserInfo userInfo: [AnyHashable: Any]) ->
        (duration: TimeInterval, curve: UInt)? {
        guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
              let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else {
            return nil
        }
        return (duration, curve)
    }
}
