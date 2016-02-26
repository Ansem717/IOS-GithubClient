//
//  CustomTranstiion.swift
//  GithubClient
//
//  Created by Andy Malik on 2/25/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import UIKit

class CustomTranstiion: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration = 1.0
    var delay = 0.0
    var curY = 0
    var curX = 0
    
    init(duration: NSTimeInterval, delay: Double) {
        self.duration = duration
        self.delay = delay
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return self.duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {return}
        guard let containerView = transitionContext.containerView() else {return}
        
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        let screenBounds = UIScreen.mainScreen().bounds
        
        let yPos = [screenBounds.size.height, -screenBounds.size.height]
        let xPos = [screenBounds.size.width, -screenBounds.size.width]
        
        switch (curX, curY) {
            case (0, 0):
                curX = 1
            case (0, 1):
                curY = 0
            case (1, 0):
                curY = 1
            case (1, 1):
                curX = 0
            default:
                curX = 0
                curY = 0
        }
        
        let realX = xPos[curX]
        let realY = yPos[curY]
        
        toVC.view.frame = CGRectOffset(finalFrame, realX, realY)
        containerView.addSubview(toVC.view)
        
        UIView.animateWithDuration(self.duration, delay: self.delay, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .CurveEaseOut, animations: { () -> Void in
            toVC.view.frame = finalFrame
            }) { (fin) -> Void in
                transitionContext.completeTransition(true)
        }
    }
}
