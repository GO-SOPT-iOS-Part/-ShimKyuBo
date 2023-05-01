//
//  ProfileModel.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/01.
//

import UIKit

struct ProfileModel: Hashable {
    var idNumber: UUID = UUID()
    var profileImage: UIImage?
    var profileName: String
}
