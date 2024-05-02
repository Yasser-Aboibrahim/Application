//
//  Constants.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation

struct Cells {
    static let tableViewCell = "TableViewCell"
}

struct Storyboards {
    static let listingViewController = "ListingViewController"
}

struct ViewControllers {
    static let listingViewController = "ListingViewController"
}

struct CoreDataMessages {
    static let coreDataModelSetupError = "Cannot setup ModelURL For CoreData"
    static let resourceName = "SecLibDB"
}

enum JSONBody: String {
    case name = "name"
    case stateProvince = "state-province"
    case domains = "domains"
    case webPages = "web_pages"
    case country = "country"
    case alphaTwoCode = "alpha_two_code"
}
