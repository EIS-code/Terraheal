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
        let nC: NC = NC(rootViewController: welcomeVc)
        self.windowConfig(withRootVC: nC)
    }

    func loadTutoraiVC(navigaionVC:UINavigationController? = nil) {

        if let nc = navigaionVC as? NC {
            if let targetVC: TutorialVC =  nc.findVCs(ofType: TutorialVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: TutorialVC = TutorialVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: TutorialVC = TutorialVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }



    }

    func loadRegisterVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: RegisterVC =  nc.findVCs(ofType: RegisterVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: RegisterVC = RegisterVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: RegisterVC = RegisterVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }

    }

    func loadLoginVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: LoginVC =  nc.findVCs(ofType: LoginVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: LoginVC = LoginVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: LoginVC = LoginVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadTouchIdVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: TouchIdVC =  nc.findVCs(ofType: TouchIdVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: TouchIdVC = TouchIdVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: TouchIdVC = TouchIdVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadContactVerificationVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ContactVerificationVC =  nc.findVCs(ofType: ContactVerificationVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ContactVerificationVC = ContactVerificationVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ContactVerificationVC = ContactVerificationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
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

