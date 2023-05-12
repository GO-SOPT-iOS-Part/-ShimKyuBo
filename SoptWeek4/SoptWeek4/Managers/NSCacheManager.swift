//
//  NSCacheManager.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/10.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
