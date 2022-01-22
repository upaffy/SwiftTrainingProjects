//
//  StorageManager.swift
//  Countdown
//
//  Created by Pavlentiy on 05.11.2021.
//

import Foundation


class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    func save(data: String, for key: String) {
        UserDefaults.standard.set(data, forKey: key)
    }
    
    func deleteData(for key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
