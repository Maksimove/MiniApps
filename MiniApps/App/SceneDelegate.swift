//
//  SceneDelegate.swift
//  MiniApps
//
//  Created by Evgeniy Maksimov on 04.09.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if #available(iOS 13, *) {
            window?.overrideUserInterfaceStyle = .light
        }
    }
}

