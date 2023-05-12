//
//  BaseTableViewController.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/12.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        setSwipeGesture()
    }
    
    private func setSwipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeLeft.direction = .left
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeLeft)
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleSwipeGesture(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if (self.selectedIndex) < 2 { // 슬라이드할 탭바 갯수 지정 (전체 탭바 갯수 - 1)
                animateToTab(toIndex: self.selectedIndex + 1)
            }
        } else if gesture.direction == .right {
            if (self.selectedIndex) > 0 {
                animateToTab(toIndex: self.selectedIndex - 1)
            }
        }
    }
}

extension BaseTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            guard let tabViewControllers = tabBarController.viewControllers, let toIndex = tabViewControllers.firstIndex(of: viewController) else {
                return false
            }
        
            animateToTab(toIndex: toIndex)
        
            return true
        }
    
    func animateToTab(toIndex: Int) {
        guard let tabViewControllers = viewControllers,
              let selectedVC = selectedViewController else { return }
        
        guard let fromView = selectedVC.view,
              let toView = tabViewControllers[toIndex].view,
              let fromIndex = tabViewControllers.firstIndex(of: selectedVC),
              fromIndex != toIndex else { return }
        
        fromView.superview?.addSubview(toView)
        
        // Position toView off screen (to the left/right of fromView)
        let screenWidth = UIScreen.main.bounds.size.width
        let scrollRight = toIndex > fromIndex
        let offset = (scrollRight ? screenWidth : -screenWidth)
        toView.center = CGPoint(x: fromView.center.x + offset, y: toView.center.y)
        
        // Disable interaction during animation
        view.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       usingSpringWithDamping: 1,
                       initialSpringVelocity: 0,
                       options: .curveEaseOut,
                       animations: {
            // Slide the views by -offset
            fromView.center = CGPoint(x: fromView.center.x - offset, y: fromView.center.y)
            toView.center = CGPoint(x: toView.center.x - offset, y: toView.center.y)
            
        }, completion: { finished in
            // Remove the old view from the tabbar view.
            fromView.removeFromSuperview()
            
            self.selectedIndex = toIndex
            self.view.isUserInteractionEnabled = true
        })
    }
    
}
