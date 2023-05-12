//
//  Congifuration.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/06.
//

import Foundation

enum Configuration {
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
        }
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("plist cannot found.")
        }
        return dict
    }()
}

extension Configuration {
    
    static let baseURL: String = {
        guard let key = Configuration.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL is not set in plist for this configuration.")
        }
        
        return key
    }()
}
