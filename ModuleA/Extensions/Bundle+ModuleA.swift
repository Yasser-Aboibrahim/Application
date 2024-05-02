//
//  Bundle+ModuleA.swift
//  ModuleA
//
//  Created by Yasser Aboibrahim on 02/05/2024.
//

import Foundation

extension Bundle {
    private class ModuleAExample{}
    internal class var moduleA: Bundle {
        return Bundle(for: ModuleAExample.self)
    }
}
