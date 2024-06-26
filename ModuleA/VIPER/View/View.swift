//
//  View.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation
import UtilitiesModule

protocol ModuleAViewProtocol: AnyObject {
    var presenter: ModuleAPresenterProtocol? {get set}
    func showUniversities(_ university: [University])
    func showError()
}
