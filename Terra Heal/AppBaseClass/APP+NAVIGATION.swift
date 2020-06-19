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

    func loadSettingVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: SettingVC =  nc.findVCs(ofType: SettingVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: SettingVC = SettingVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: SettingVC = SettingVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadNotificationVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: NotificationVC =  nc.findVCs(ofType: NotificationVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: NotificationVC = NotificationVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: NotificationVC = NotificationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadMyPlacesVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MyPlaceVC =  nc.findVCs(ofType: MyPlaceVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: MyPlaceVC = MyPlaceVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: MyPlaceVC = MyPlaceVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadTherapistQuestionaryVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: TherapistQuestionariesVC =  nc.findVCs(ofType: TherapistQuestionariesVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: TherapistQuestionariesVC = TherapistQuestionariesVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: TherapistQuestionariesVC = TherapistQuestionariesVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadManageAddressVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MyAddressVC =  nc.findVCs(ofType: MyAddressVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: MyAddressVC = MyAddressVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: MyAddressVC = MyAddressVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }


    func loadManagePeopleVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ManagePeopleVC =  nc.findVCs(ofType: ManagePeopleVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ManagePeopleVC = ManagePeopleVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ManagePeopleVC = ManagePeopleVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadHowItWorkVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: HowItWorkVC =  nc.findVCs(ofType: HowItWorkVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: HowItWorkVC = HowItWorkVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: HowItWorkVC = HowItWorkVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadPriceLocationVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: PriceLocationVC =  nc.findVCs(ofType: PriceLocationVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: PriceLocationVC = PriceLocationVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: PriceLocationVC = PriceLocationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadPromocodeVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: PromoCodeVC =  nc.findVCs(ofType: PromoCodeVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: PromoCodeVC = PromoCodeVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: PromoCodeVC = PromoCodeVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadPackVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: PackVC =  nc.findVCs(ofType: PackVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: PackVC = PackVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: PackVC = PackVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadReferAndEarnVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ReferAndEarnVC =  nc.findVCs(ofType: ReferAndEarnVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: ReferAndEarnVC = ReferAndEarnVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: ReferAndEarnVC = ReferAndEarnVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadCampaignsVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: CampaignsVC =  nc.findVCs(ofType: CampaignsVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: CampaignsVC = CampaignsVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: CampaignsVC = CampaignsVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadHelpVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: HelpVC =  nc.findVCs(ofType: HelpVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: HelpVC = HelpVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: HelpVC = HelpVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }

    func loadGiftVoucherVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: GiftVoucherVC =  nc.findVCs(ofType: GiftVoucherVC.self).first {
                _ = nc.popToViewController(targetVC, animated: true)
            } else {
                let targetVC: GiftVoucherVC = GiftVoucherVC.fromNib()
                nc.pushViewController(targetVC, animated: true)
            }
        } else {
            let targetVC: GiftVoucherVC = GiftVoucherVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }


}

