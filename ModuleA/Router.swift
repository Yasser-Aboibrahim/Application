//
//  Router.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import UIKit
import UtilitiesModule
import ModuleB

protocol ModuleARouterProtocol: AnyObject {
    func navigateToDetailsScreen(with university: University)
}

public class ModuleARouter: ModuleARouterProtocol {
    public static func start() -> UIViewController {
        let router = ModuleARouter()
        let view = ListingViewController.create()
        let interactor: ModuleAInteractorProtocol = ModuleAInteractor()
        let presenter: ModuleAPresenterProtocol = ModuleAPresenter()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor

        return view
    }

    func navigateToDetailsScreen(with university: University) {
        let router: ModuleBRouterProtocol  = ModuleBRouter()
        router.showDetailsScreen(university: university)
    }
}
