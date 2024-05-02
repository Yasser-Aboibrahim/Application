//
//  Bundle+ModuleB.swift
//  ModuleB
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation

extension Bundle {
    private class ModuleBExample{}
    internal class var moduleB: Bundle {
        return Bundle(for: ModuleBExample.self)
    }
}
