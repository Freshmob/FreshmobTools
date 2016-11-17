//
//  KeyboardObservable.swift
//  FreshmobTools
//
//  Created by Rogerio de Paula Assis on 17/11/16.
//  Copyright © 2016 Rogerio de Paula Assis. All rights reserved.
//

import Foundation

public protocol KeyboardObservable {
    var bottomSpaceToMainViewConstraint: NSLayoutConstraint! { get }
    func subscribeToKeyboardNotifications()
}

public extension KeyboardObservable where Self: UIViewController {
    func subscribeToKeyboardNotifications() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(forName: .UIKeyboardWillShow,
                                       object: nil,
                                       queue: nil) { [weak self] (notification) in
            if let userInfo = notification.userInfo,
                let keyboardFrame = self?.getKeyboardRect(forKey: UIKeyboardFrameEndUserInfoKey,
                                                          withUserInfo: userInfo),
                let values = self?.getDurationAndCurve(fromNotificationUserInfo: userInfo) {
                let bottomLayoutGuideLength = self?.bottomLayoutGuide.length ?? 0
                self?.bottomSpaceToMainViewConstraint.constant =
                    keyboardFrame.size.height - bottomLayoutGuideLength
                self?.view.needsUpdateConstraints()
                UIView.animate(withDuration: values.duration, delay: 0,
                               options: UIViewAnimationOptions(rawValue: values.curve),
                               animations: {
                    self?.view.layoutIfNeeded()
                })
            }
        }
        notificationCenter.addObserver(forName: .UIKeyboardWillHide,
                                       object: nil,
                                       queue: nil) { [weak self] (notification) in
            if let userInfo = notification.userInfo,
                let values = self?.getDurationAndCurve(fromNotificationUserInfo: userInfo) {
                self?.bottomSpaceToMainViewConstraint.constant = 0
                self?.view.needsUpdateConstraints()
                UIView.animate(withDuration: values.duration, delay: 0,
                               options: UIViewAnimationOptions(rawValue: values.curve),
                               animations: {
                    self?.view.layoutIfNeeded()
                })
            }
        }
    }
    
    func getKeyboardRect(forKey key: String,
                         withUserInfo userInfo: [AnyHashable: Any]) -> CGRect? {
        return (userInfo[key] as? NSValue)?.cgRectValue
    }
    
    func getDurationAndCurve(fromNotificationUserInfo userInfo: [AnyHashable: Any]) ->
        (duration: TimeInterval, curve: UInt)? {
        guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval,
        let curve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UInt else {
            return nil
        }
        return (duration, curve)
    }
}
