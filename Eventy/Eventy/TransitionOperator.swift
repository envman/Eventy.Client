//
//  TransitionOperator.swift
//  NavTransition
//
//  Created by Harry Goodwin on 15/09/2015.
//  Copyright (c) 2015 App Design Vault. All rights reserved.
//

import Foundation
import UIKit

class TransitionOperator: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate{
    
    var snapshot : UIView!
    var isPresenting : Bool = true
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) ->  NSTimeInterval
    {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning)
    {
        if isPresenting
        {
            presentNavigation(transitionContext)
        }
        else
        {
            dismissNavigation(transitionContext)
        }
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) ->  UIViewControllerAnimatedTransitioning?
    {
        self.isPresenting = true
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        self.isPresenting = false
        return self
    }
    
    func presentNavigation(transitionContext: UIViewControllerContextTransitioning)
    {
        let container = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromView = fromViewController!.view
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toViewController!.view
        
        let size = toView.frame.size
        var offSetTransform = CGAffineTransformMakeTranslation(size.width - 120, 0)
        offSetTransform = CGAffineTransformScale(offSetTransform, 0.7, 0.7)
        
        snapshot = fromView.snapshotViewAfterScreenUpdates(true)
        
        container!.addSubview(toView)
        container!.addSubview(snapshot)
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: [], animations: {
            
            self.snapshot.transform = offSetTransform
            
            }, completion: { finished in
                
                transitionContext.completeTransition(true)
        })
    }
    
    func dismissNavigation(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        let fromView = fromViewController!.view
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        let toView = toViewController!.view
        
        let duration = self.transitionDuration(transitionContext)
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            self.snapshot.transform = CGAffineTransformIdentity
            
            }, completion: { finished in
                transitionContext.completeTransition(true)
                self.snapshot.removeFromSuperview()
        })
    }
}