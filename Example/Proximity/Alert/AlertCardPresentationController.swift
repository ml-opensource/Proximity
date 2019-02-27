//
//  AlertCardPresentationController.swift
//  ProximityExample
//
//  Created by Eric Kunz on 2/21/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import UIKit

final class AlertCardPresentationController: UIPresentationController {
    
    let inset: CGFloat = 8
    
    private let shade: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.alpha = 0
        return view
    }()
    
    @objc private func tappedShade() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
    override func presentationTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        
        if let container = containerView {
            shade.frame = container.bounds
        }
        containerView?.addSubview(shade)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedShade))
        shade.addGestureRecognizer(tap)
        
        coordinator.animate(alongsideTransition: { (context) in
            self.shade.alpha = 1
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else { return }
        
        coordinator.animate(alongsideTransition: { (context) in
            self.shade.alpha = 0
        }, completion: { _ in
            self.shade.removeFromSuperview()
        })
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let container = containerView else { return .zero }
        let size = presentedViewController.preferredContentSize
        
        let sideInsets: CGFloat
        if #available(iOS 11.0, *) {
            sideInsets = max(inset, container.safeAreaInsets.left)
        } else {
            sideInsets = inset
        }
        
        let width = min(container.bounds.width - (sideInsets * 2), size.width)
        let height = min(container.bounds.height, size.height)
        
        let bottomInset: CGFloat
        if #available(iOS 11.0, *) {
            bottomInset = max(inset, container.safeAreaInsets.bottom)
        } else {
            bottomInset = inset
        }
        
        let frame = CGRect(x: (container.bounds.width - width) / 2,
                           y: container.bounds.height - height - bottomInset,
                           width: width,
                           height: height)
        
        return frame
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        presentedView?.frame = frameOfPresentedViewInContainerView
        shade.frame = containerView?.bounds ?? .zero
    }
    
}
