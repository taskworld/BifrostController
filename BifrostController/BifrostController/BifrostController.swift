//
//  StoryboardBridgeController.swift
//  Taskworld
//
//  Created by Ambas Chobsanti on 11/20/14.
//  Copyright (c) 2014 Taskworld All rights reserved.
//

import UIKit

public class BifrostController: UINavigationController {
    
    @IBInspectable public var storyboardName: String? = nil {
        didSet {
            setNeedReloadViewController()
        }
    }
    
    @IBInspectable public var storyboardID: String? = nil {
        didSet {
            setNeedReloadViewController()
        }
    }
   
    // MARK: Private Methods
    
    private var needReloadViewController = false
    
    private func setNeedReloadViewController() {
        self.needReloadViewController = true
        scheduleForReloadViewController()
    }
    
    private func scheduleForReloadViewController() {
        if self.needReloadViewController {
            dispatch_async(dispatch_get_main_queue()) {
                if let storyboardName = self.storyboardName {
                    let viewController = self.loadViewController(storyboardName, storyboardID: self.storyboardID)
                    if let viewController = viewController {
                        self.viewControllers = [viewController]
                    }
                } else {
                    self.viewControllers = []
                }
                self.needReloadViewController = false
            }
        }
    }
    
    private func loadViewController(storyboardName: String, storyboardID: String?) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        println(storyboard)
        var viewController: UIViewController?
        if let storyboardID = storyboardID {
            viewController = storyboard.instantiateViewControllerWithIdentifier(storyboardID) as? UIViewController
        } else {
            viewController = storyboard.instantiateInitialViewController() as? UIViewController
        }
        return viewController
    }
}