//
//  ListingViewController.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import UIKit
import UtilitiesModule

class ListingViewController: UIViewController, ModuleAViewProtocol {
    var presenter: ModuleAPresenterProtocol?
    @IBOutlet weak var tableView: UITableView!
    var universities: [University] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        tableView.register(UINib(nibName: Cells.tableViewCell, bundle: Bundle.moduleA), forCellReuseIdentifier: Cells.tableViewCell)
        tableView.tableFooterView = UIView(frame: .zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 217
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewWillAppear()
    }

    class func create() -> ListingViewController {
        let listingViewController = ListingViewController.create(
            storyboardName: Storyboards.listingViewController,
            identifier: ViewControllers.listingViewController,
            bundle: Bundle.moduleA) as! ListingViewController
        return listingViewController
    }

    func showUniversities(_ universities: [University]) {
        DispatchQueue.main.async {
            self.universities = universities
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }

    func showError(message: String) {
        // Show error message
    }

    func itemSelected(at index: Int) {
        presenter?.itemSelected(at: index)
    }
}

extension ListingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.tableViewCell, for: indexPath) as! TableViewCell
        cell.cellConfigure(
            name: universities[indexPath.row].name,
            state: universities[indexPath.row].stateProvince
        )
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        itemSelected(at: indexPath.row)
    }
}