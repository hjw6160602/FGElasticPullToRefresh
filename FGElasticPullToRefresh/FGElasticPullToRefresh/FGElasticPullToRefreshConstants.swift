//
//  FGElasticPullToRefreshConstants.swift
//  FGElasticPullToRefresh
//
//  Created by SaiDiCaprio on 2020/10/2.
//  Copyright © 2016年 SaiDiCaprio. All rights reserved.
//


import CoreGraphics

public struct FGElasticPullToRefreshConstants {
    
    struct KeyPaths {
        static let ContentOffset = "contentOffset"
        static let ContentInset = "contentInset"
        static let Frame = "frame"
        static let PanGestureRecognizerState = "panGestureRecognizer.state"
    }
    
    public static var WaveMaxHeight: CGFloat = 70.0
    public static var MinOffsetToPull: CGFloat = 95.0
    public static var LoadingContentInset: CGFloat = 50.0
    public static var LoadingViewSize: CGFloat = 30.0
	
}
