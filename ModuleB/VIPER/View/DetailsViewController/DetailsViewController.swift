//
//  DetailsViewController.swift
//  ModuleB
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import UIKit
import UtilitiesModule

extension Bundle {
    private class ModuleBExample{}
    internal class var moduleB: Bundle {
        return Bundle(for: ModuleBExample.self)
    }
}

class DetailsViewController: UIViewController, ModuleBViewProtocol {
    var presenter: ModuleBPresenterProtocol?
    var university: University?

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var code: UILabel!
    @IBOutlet weak var webPage: UILabel!
    @IBOutlet weak var stateLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var codeToStateConstraint: NSLayoutConstraint!
    @IBOutlet weak var countryToStateConstaint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 0
    }

    class func create(university: University?) -> DetailsViewController {
        let detailsViewController = DetailsViewController.create(
            storyboardName: Storyboards.detailsViewController,
            identifier: ViewControllers.detailsViewController,
            bundle: Bundle.moduleB
        ) as! DetailsViewController
        detailsViewController.university = university
        return detailsViewController
    }

    func showItemDetails(_ university: University) {
        self.university = university
        name.text = university.name
        if state == nil {
            stateLabelHeight.constant = 0
            countryToStateConstaint.constant = 0
            codeToStateConstraint.constant = 0
        } else {
            state.text = university.stateProvince
            stateLabelHeight.constant = 40
        }
        country.text = university.country
        code.text = university.alphaTwoCode
        webPage.text = "\(university.webPages)"
    }

    @IBAction func refreshButtomPressed(_ sender: UIButton) {
        presenter?.dismissDetailsScreeen()
    }
}

