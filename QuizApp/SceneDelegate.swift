//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 06/12/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: scene)
        let viewController = QuestionViewController(question: "A Question",
                                                    options: ["Option 1", "Option 2"]) {
            print($0)
        }
        _ = viewController.view
        viewController.tableView.allowsMultipleSelection = false
        window?.rootViewController = viewController
        
        window?.makeKeyAndVisible()
        
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

