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
        
        let viewController = ResultViewController(summary: "You get 1/2 correct ", answer: [
            PresentableAnswer(question: "Question 1 Question 1 Question 1 Question 1 Question 1", answer: "Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah! Yeah!", worngAnswer: nil),
            PresentableAnswer(question: "Question 2", answer: "Hell Yeah!", worngAnswer: "Hell no")
        ])
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

