//
//  UIView+Extensions.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/04/30.
//

import UIKit.UIView

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}


  /// UIViewController Extension for Preview
#if canImport(SwiftUI) && DEBUG
import SwiftUI

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let viewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return viewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(viewController: self)
        }
}
#endif
