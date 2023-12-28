//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Qazi Mudassar on 06/12/2023.
//

import UIKit
import QuizEngine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    var game: Game<Question<String>, [String], NavigationControllerRouter>?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = .init(windowScene: scene)
        
        let question1 = Question.single("What is the Mudassar Nationality?")
        let question2 = Question.multiple("What Are  Nationalities Mudassar want?")
        let questions = [question1, question2]
        
        let option1 = "Pakistan"
        let option2 = "India"
        let option3 = "USA"
        let options1 = [option1, option2, option3]
        
        let option4 = "India"
        let option5 = "Astrulia"
        let option6 = "USA"
        let options2 = [option4, option5, option6]
        
        let correctAnswer = [question1: [option1], question2: [option5,option6]]
    
        let navigationController = UINavigationController()
        let factory = iOSViewControllerFactory(options: [question1 :options1, question2 :options2],
                                               correctAnswer: [(question1, [option1]), (question2, [option5,option6])])
        let router = NavigationControllerRouter(navigationController, factory: factory)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        game = startGame(questions: questions, router: router, correctAnswer: correctAnswer)
        
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

