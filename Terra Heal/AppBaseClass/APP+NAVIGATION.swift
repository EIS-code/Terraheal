//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit


// MARK: - NAVIGATION
extension AppDelegate {

    func loadLaunchVC() {
        if let launchVc: LaunchVC = Bundle.main.loadNibNamed(LaunchVC.name, owner: nil, options: nil)?.first as? LaunchVC{
            self.windowConfig(withRootVC: launchVc)
        }
    }

    func loadWelcomeVC() {
        let welcomeVc: WelcomeVC = WelcomeVC.fromNib()
        self.windowConfig(withRootVC: welcomeVc)
    }

    func loadTutoraiVC() {
        let tutorialVC: TutorialVC = TutorialVC.fromNib()
        self.windowConfig(withRootVC: tutorialVC)
    }

    func loadLoginVC() {
        let loginVc: LoginVC = LoginVC.fromNib()
        self.windowConfig(withRootVC: loginVc)
    }
    
    func windowConfig(withRootVC rootVC: UIViewController?) {
        DispatchQueue.main.async {
            self.window?.clean()
            self.window?.rootViewController?.clean()
            self.window?.rootViewController = rootVC
            self.window?.makeKeyAndVisible()
        }
    }

}

