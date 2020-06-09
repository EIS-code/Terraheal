//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit


// MARK: - NAVIGATION
extension AppDelegate {

    func windowConfig(withRootVC rootVC: UIViewController?) {
        DispatchQueue.main.async {
            self.window?.clean()
            self.window?.rootViewController?.clean()

            self.window?.rootViewController = rootVC
            self.window?.makeKeyAndVisible()
        }
    }

    func loadLaunchVC() {
        if let launchVc: LaunchVC = Bundle.main.loadNibNamed(LaunchVC.name, owner: nil, options: nil)?.first as? LaunchVC{
            self.windowConfig(withRootVC: launchVc)
        }
    }

    func loadWelcomeVC() {
        SideVC.remove()
        PreferenceHelper.shared.setUserId("")
        Singleton.shared.user = User.UserData.init(fromDictionary: [:])
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

    fileprivate func loadHomeVC(_ navigaionVC: UINavigationController?) {
        if let nc = navigaionVC as? NC {
            if let targetVC: HomeVC =  nc.findVCs(ofType: HomeVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: HomeVC = HomeVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: HomeVC = HomeVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadHomeVC(navigaionVC:UINavigationController? = nil) {
        if !PreferenceHelper.shared.getUserId().isEmpty() {
            AppWebApi.getUserDetail { (response) in
                Loader.hideLoading()
                let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
                if ResponseModel.isSuccess(response: model, withSuccessToast: false, andErrorToast: false) {
                    let user = response.data
                    PreferenceHelper.shared.setUserId(user.id)
                    appSingleton.user = user
                    Singleton.saveInDb()
                    self.loadHomeVC(navigaionVC)

                } else {
                    self.loadHomeVC(navigaionVC)
                }

            }

            } else {
            loadHomeVC(navigaionVC)
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
        if Singleton.shared.user.isContactVerified() {
            Common.showAlert(message: "Already Verified")
        } else  {
            if let nc = navigaionVC as? NC {
                if let targetVC: VerifyContactVC =  nc.findVCs(ofType: VerifyContactVC.self).first {
                    _ = nc.popToViewController(targetVC, animated: true)
                } else {
                    let targetVC: VerifyContactVC = VerifyContactVC.fromNib()
                    nc.pushViewController(targetVC, animated: true)
                }
            } else {
                let targetVC: VerifyContactVC = VerifyContactVC.fromNib()
                let nC: NC = NC(rootViewController: targetVC)
                self.windowConfig(withRootVC: nC)
            }
        }

    }

    func loadVerifiedContactVC(navigaionVC:UINavigationController? = nil) {

        if let nc = navigaionVC as? NC {
            if let targetVC: ContactVerifiedVC =  nc.findVCs(ofType: ContactVerifiedVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ContactVerifiedVC = ContactVerifiedVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ContactVerifiedVC = ContactVerifiedVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadKycWelcomeVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: KycVC =  nc.findVCs(ofType: KycVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: KycVC = KycVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: KycVC = KycVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadKycInfoVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: KycInfoVC =  nc.findVCs(ofType: KycInfoVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: KycInfoVC = KycInfoVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: KycInfoVC = KycInfoVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadScanPassportInstructionVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ScanPassportInstructionVC =  nc.findVCs(ofType: ScanPassportInstructionVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ScanPassportInstructionVC = ScanPassportInstructionVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ScanPassportInstructionVC = ScanPassportInstructionVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadScanPassportVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ScanPassportVC =  nc.findVCs(ofType: ScanPassportVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ScanPassportVC = ScanPassportVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ScanPassportVC = ScanPassportVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }


    func loadProfileVC(navigaionVC:UINavigationController? = nil) {

        if let nc = navigaionVC as? NC {
            if let targetVC: ProfileVC =  nc.findVCs(ofType: ProfileVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ProfileVC = ProfileVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ProfileVC = ProfileVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadEditProfileVC(navigaionVC:UINavigationController? = nil) {

        if let nc = navigaionVC as? NC {
            if let targetVC: EditProfileVC =  nc.findVCs(ofType: EditProfileVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: EditProfileVC = EditProfileVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: EditProfileVC = EditProfileVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadScanSelfieInstructionVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ScanSelfieInstructionVC =  nc.findVCs(ofType: ScanSelfieInstructionVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ScanSelfieInstructionVC = ScanSelfieInstructionVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ScanSelfieInstructionVC = ScanSelfieInstructionVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadScanSelfieVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ScanSelfieVC =  nc.findVCs(ofType: ScanSelfieVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ScanSelfieVC = ScanSelfieVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ScanSelfieVC = ScanSelfieVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadAddCardVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: AddCardVC =  nc.findVCs(ofType: AddCardVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: AddCardVC = AddCardVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: AddCardVC = AddCardVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadCompleteIdentityVerificationVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: CompleteIdentityVerificationVC =  nc.findVCs(ofType: CompleteIdentityVerificationVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: CompleteIdentityVerificationVC = CompleteIdentityVerificationVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: CompleteIdentityVerificationVC = CompleteIdentityVerificationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadMassagePreferenceVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MassagePreferenceVC =  nc.findVCs(ofType: MassagePreferenceVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: MassagePreferenceVC = MassagePreferenceVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: MassagePreferenceVC = MassagePreferenceVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadMyTherapistVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MyTherapistVC =  nc.findVCs(ofType: MyTherapistVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: MyTherapistVC = MyTherapistVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: MyTherapistVC = MyTherapistVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }


}

