//
//  FGElasticPullToRefreshExtensions.swift
//  FGElasticPullToRefresh
//
//  Created by SaiDiCaprio on 2020/10/2.
//  Copyright © 2016年 SaiDiCaprio. All rights reserved.
//


import UIKit
import ObjectiveC

// MARK: -
// MARK: (NSObject) Extension

public extension NSObject {
    
    // MARK: -
    // MARK: Vars
    
    fileprivate struct fg_associatedKeys {
        static var observersArray = "observers"
    }
    
    fileprivate var fg_observers: [[String : NSObject]] {
        get {
            if let observers = objc_getAssociatedObject(self, &fg_associatedKeys.observersArray) as? [[String : NSObject]] {
                return observers
            } else {
                let observers = [[String : NSObject]]()
                self.fg_observers = observers
                return observers
            }
        } set {
            objc_setAssociatedObject(self, &fg_associatedKeys.observersArray, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: -
    // MARK: Methods
    
    func fg_addObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        let observerInfo = [keyPath : observer]
        
        if fg_observers.firstIndex(where: { $0 == observerInfo }) == nil {
            fg_observers.append(observerInfo)
            addObserver(observer, forKeyPath: keyPath, options: .new, context: nil)
        }
    }
    
    func fg_removeObserver(_ observer: NSObject, forKeyPath keyPath: String) {
        let observerInfo = [keyPath : observer]
        
        if let index = fg_observers.firstIndex(where: { $0 == observerInfo}) {
            fg_observers.remove(at: index)
            removeObserver(observer, forKeyPath: keyPath)
        }
    }
    
}

// MARK: -
// MARK: (UIScrollView) Extension

public extension UIScrollView {
    
    // MARK: - Vars

    fileprivate struct fg_associatedKeys {
        static var pullToRefreshView = "pullToRefreshView"
    }

    fileprivate var pullToRefreshView: FGElasticPullToRefreshView? {
        get {
            return objc_getAssociatedObject(self, &fg_associatedKeys.pullToRefreshView) as? FGElasticPullToRefreshView
        }

        set {
            objc_setAssociatedObject(self, &fg_associatedKeys.pullToRefreshView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    // MARK: - Methods (Public)
    
    func fg_addPullToRefreshWithActionHandler(_ actionHandler: @escaping () -> Void, loadingView: FGElasticPullToRefreshLoadingView?) {
        isMultipleTouchEnabled = false
        panGestureRecognizer.maximumNumberOfTouches = 1

        let pullToRefreshView = FGElasticPullToRefreshView()
        self.pullToRefreshView = pullToRefreshView
        pullToRefreshView.actionHandler = actionHandler
        pullToRefreshView.loadingView = loadingView
        addSubview(pullToRefreshView)

        pullToRefreshView.observing = true
    }
    
    func fg_removePullToRefresh() {
        pullToRefreshView?.disassociateDisplayLink()
        pullToRefreshView?.observing = false
        pullToRefreshView?.removeFromSuperview()
    }
    
    func fg_setPullToRefreshBackgroundColor(_ color: UIColor) {
        pullToRefreshView?.backgroundColor = color
    }
    
    func fg_setPullToRefreshFillColor(_ color: UIColor) {
        pullToRefreshView?.fillColor = color
    }
    
    func fg_stopLoading() {
        pullToRefreshView?.stopLoading()
    }
}

// MARK: -
// MARK: (UIView) Extension

public extension UIView {
    func fg_center(_ usePresentationLayerIfPossible: Bool) -> CGPoint {
        if usePresentationLayerIfPossible, let presentationLayer = layer.presentation() {
            // Position can be used as a center, because anchorPoint is (0.5, 0.5)
            return presentationLayer.position
        }
        return center
    }
}

// MARK: -
// MARK: (UIPanGestureRecognizer) Extension

public extension UIPanGestureRecognizer {
    func fg_resign() {
        isEnabled = false
        isEnabled = true
    }
}

// MARK: -
// MARK: (UIGestureRecognizerState) Extension

public extension UIGestureRecognizer.State {
    func fg_isAnyOf(_ values: [UIGestureRecognizer.State]) -> Bool {
        return values.contains(where: { $0 == self })
    }
}
