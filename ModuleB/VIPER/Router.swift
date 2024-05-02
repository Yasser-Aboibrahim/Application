//
//  Router.swift
//  ModuleB
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import UIKit
import UtilitiesModule

public protocol ModuleBRouterProtocol: AnyObject {
    func showDetailsScreen(university: University?)
    func dismissDetailsScreen()
}

public class ModuleBRouter: ModuleBRouterProtocol {
    var viewController: UIViewController?

    public init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }

    public func showDetailsScreen(university: University?) {
        let view = DetailsViewController.create(university: university)
        let presenter: ModuleBPresenterProtocol = ModuleBPresenter(university: university)
        view.presenter = presenter
        presenter.view = view
        presenter.router = self
        viewController = view
        guard let viewController = viewController else { return }
        UIApplication.topViewController()?.present(viewController, animated: true, completion: nil)
    }

    public func dismissDetailsScreen() {
        viewController?.dismiss(animated: true)
    }
}
