//
//  AppDelegate.swift
//  FGElasticPullToRefresh
//
//  Created by SaiDiCaprio on 2020/10/2.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let viewController = ViewController()
        let navigationController = NavigationController(rootViewController: viewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.backgroundColor = .white
        window!.makeKeyAndVisible()
        return true
    }

}

