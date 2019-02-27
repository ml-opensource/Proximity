//
//  AlertCard.swift
//  AlertCard
//
//  Created by Eric Kunz on 2/21/19.
//  Copyright © 2019 Fuzz. All rights reserved.
//

import UIKit

open class AlertCard: UIViewController {
    
    override open var preferredContentSize: CGSize {
        get { return CGSize(width: 400, height: 300) }
        set {}
    }
    
    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.cornerRadius = 32
        view.backgroundColor = .white
    }
}

extension AlertCard: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return AlertCardPresentationController(presentedViewController: presented,
                                        presenting: presentingViewController)
    }
}

