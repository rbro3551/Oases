//
//  FileManager-DocumentsDirectory.swift
//  WePeople
//
//  Created by Riley Brookins on 5/29/23.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
