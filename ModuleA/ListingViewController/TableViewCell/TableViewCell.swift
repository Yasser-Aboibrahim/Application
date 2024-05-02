//
//  TableViewCell.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var stateHeight: NSLayoutConstraint!
    @IBOutlet weak var stateConstraintsToBottom: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.numberOfLines = 0
    }

    func cellConfigure(name: String, state: String?) {
        self.name.text = name
        if state == nil {
            stateHeight.constant = 0
            stateConstraintsToBottom.constant = 0
        } else {
            self.state.text = state
            stateHeight.constant = 20
            stateConstraintsToBottom.constant = 10
        }
        
    }
}
