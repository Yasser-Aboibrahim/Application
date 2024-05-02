//
//  UIViewController+TopViewController.swift
//  UtilitiesModule
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import UIKit

public extension UIApplication {
    class func topViewController(base: UIViewController? =
        UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
