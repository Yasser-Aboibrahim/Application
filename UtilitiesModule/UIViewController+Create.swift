//
//  UIViewController+Create.swift
//  UtilitiesModule
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import UIKit

public extension UIViewController {
    class func create<T: UIViewController>(storyboardName: String, identifier: String, bundle: Bundle? = nil) -> T {
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
}
