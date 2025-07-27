//
//  SceneDelegate.swift
//  NetworkCommunicationProject
//
//  Created by 박성훈 on 7/23/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        
        let tabBarController = UITabBarController()

        let lottoVC = LottoViewController()
        let boxOfficeVC = BoxOfficeViewController()
        
        let shoppingVC = ShoppingHomeViewController()
        let shoppingNavigationVC = CustomNavigationController(rootViewController: shoppingVC)
        
        tabBarController.setViewControllers([lottoVC, boxOfficeVC, shoppingNavigationVC], animated: true)
        tabBarController.tabBar.barTintColor = .gray
        tabBarController.tabBar.tintColor = .black
        
        guard let items = tabBarController.tabBar.items else { return }
        items[0].selectedImage = UIImage(systemName: "01.circle.fill")
        items[0].image = UIImage(systemName: "01.circle")
        items[0].title = "로또"
        items[1].selectedImage = UIImage(systemName: "movieclapper.fill")
        items[1].image = UIImage(systemName: "movieclapper")
        items[1].title = "영화"
        items[2].selectedImage = UIImage(systemName: "cart.fill")
        items[2].image = UIImage(systemName: "cart")
        items[2].title = "쇼핑"

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

