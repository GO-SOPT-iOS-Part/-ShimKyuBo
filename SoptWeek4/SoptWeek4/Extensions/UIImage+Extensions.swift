//
//  UIImage+Extensions.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/11.
//

import UIKit

extension UIImage {
    static func load(url: URL) async throws -> UIImage {
        let (data, _) = try await URLSession.shared.data(from: url)
        
        guard let image = UIImage(data: data) else { return UIImage() }
        
        return image
    }
}
