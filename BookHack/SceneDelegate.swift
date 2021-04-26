//
//  SceneDelegate.swift
//  BookHack
//
//  Created by Yoav Nemirovsky on 20.03.2021.
//

import UIKit
import UserNotifications

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var mainCoordinator: MainCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            
            let authService = AuthService()
            let innerNetworkService = InnerNetworkService()
            
            let authBuilder = AuthViewBuilder(
                authService: authService,
                networkService: innerNetworkService
            )
            
            let ISBNService = IsbnNetworkService()
            
            let userBuilder = UserViewBuilder(networkService: innerNetworkService, ISBNService: ISBNService)
            
            let mainCoordinator = MainCoordinator(
                navigationController: UINavigationController(),
                viewBuilder: ViewBuilder(),
                window: window,
                authBuilder: authBuilder,
                userBuilder: userBuilder,
                authService: authService
            )
            self.mainCoordinator = mainCoordinator
            mainCoordinator.start()
            window.makeKeyAndVisible()
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
                 (granted, error) in
                 if granted {
                     print("yes")
                 } else {
                     print("No")
                 }
             }
        }
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
        print("adsda")
        
        
        let content = UNMutableNotificationContent()
        content.title = "Время платить по счетам!😁"
        content.subtitle = ""
        content.body = "Время чтения книжки подходит к концу. Осталось 3 дня."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        
        print("AAAAAQAA")
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

