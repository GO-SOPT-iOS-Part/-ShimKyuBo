//
//  UICollectionView+Extensions.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/02.
//

import UIKit.UICollectionView

extension UICollectionView {
    func fetchCellRectFor(indexPath index: IndexPath, paddingFromLeading: CGFloat, cellHorizontalPadding: CGFloat) -> TapRect {
        guard let cellAttributes = self.layoutAttributesForItem(at: index) else { return TapRect(index: 0, width: 0, xPosition: CGPoint()) }
        let cellOrigin = cellAttributes.frame.origin
//        let cellOriginPointFrameInSuperView = self.convert(cellAttributes.frame, to: self).origin
        let cellXPosition: CGPoint = CGPoint(x: cellOrigin.x + paddingFromLeading, y: cellOrigin.y)
        
        let cellWidth: CGFloat = cellAttributes.size.width - cellHorizontalPadding
        
        return TapRect(index: index.item, width: cellWidth, xPosition: cellXPosition)
    }
}
