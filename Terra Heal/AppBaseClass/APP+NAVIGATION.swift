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
            SlideVC.remove()
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
    
    func loadWelcomeVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: WelcomeVC =  nc.findVCs(ofType: WelcomeVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                PreferenceHelper.shared.setUserId("")
                Singleton.shared.user = User.UserData.init(fromDictionary: [:])
                let welcomeVc: WelcomeVC = WelcomeVC.fromNib()
                let nC: NC = NC(rootViewController: welcomeVc)
                self.windowConfig(withRootVC: nC)
            }
        }else {
            PreferenceHelper.shared.setUserId("")
            Singleton.shared.user = User.UserData.init(fromDictionary: [:])
            let welcomeVc: WelcomeVC = WelcomeVC.fromNib()
            let nC: NC = NC(rootViewController: welcomeVc)
            self.windowConfig(withRootVC: nC)
        }
        
    }
    
    func loadTutoraiVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: TutorialVC =  nc.findVCs(ofType: TutorialVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: TutorialVC = TutorialVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: RegisterVC = RegisterVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: LoginVC = LoginVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: LoginVC = LoginVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    fileprivate func loadMainVC(_ navigaionVC: UINavigationController?) {
        let mainVC: NC = NC(rootViewController: MainVC.fromNib())
        let leftVC: NC = NC(rootViewController: SideVC.fromNib())
        let rightVC: NC = NC(rootViewController: ProfileVC.fromNib())
        let targetVC = PBRevealViewController.init(leftViewController: leftVC, mainViewController: mainVC, rightViewController: rightVC)
        self.windowConfig(withRootVC: targetVC)
    }
    
    func loadMainVC(navigaionVC:UINavigationController? = nil) {
        if !PreferenceHelper.shared.getUserId().isEmpty() {
            AppWebApi.getUserDetail { (response) in
                Loader.hideLoading()
                let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
                if ResponseModel.isSuccess(response: model, withSuccessToast: false, andErrorToast: false) {
                    let user = response.data
                    PreferenceHelper.shared.setUserId(user.id)
                    appSingleton.user = user
                    Singleton.saveInDb()
                    self.loadMainVC(navigaionVC)
                    
                } else {
                    self.loadMainVC(navigaionVC)
                }
            }
        } else {
            loadMainVC(navigaionVC)
        }
    }
    
    func loadTouchIdVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: TouchIdVC =  nc.findVCs(ofType: TouchIdVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: TouchIdVC = TouchIdVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: TouchIdVC = TouchIdVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    
    func loadVerifiedContactVC(navigaionVC:UINavigationController? = nil) {
        
        if let nc = navigaionVC as? NC {
            if let targetVC: ContactVerifiedVC =  nc.findVCs(ofType: ContactVerifiedVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ContactVerifiedVC = ContactVerifiedVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ContactVerifiedVC = ContactVerifiedVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    

    func loadVerifyContactVC(navigaionVC:UINavigationController? = nil) {
        
        if let nc = navigaionVC as? NC {
            if let targetVC: VerifyContactVC =  nc.findVCs(ofType: VerifyContactVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: VerifyContactVC = VerifyContactVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: VerifyContactVC = VerifyContactVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    
    
    func loadVerificationVC(navigaionVC:UINavigationController? = nil) {
        
        if let nc = navigaionVC as? NC {
            if let targetVC: VerificationVC =  nc.findVCs(ofType: VerificationVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: VerificationVC = VerificationVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: VerificationVC = VerificationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    
    func loadMapLocationVC(navigaionVC:UINavigationController? = nil) -> MapLocationVC {
        if let nc = navigaionVC as? NC {
            if let targetVC: MapLocationVC =  nc.findVCs(ofType: MapLocationVC.self).first {
                _ = nc.popToVc(targetVC)
                return targetVC
            } else {
                let targetVC: MapLocationVC = MapLocationVC.fromNib()
                nc.pushVC(targetVC)
                return targetVC
            }
        } else {
            let targetVC: MapLocationVC = MapLocationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
            return targetVC
        }
    }
    
    
    func loadCameraVC(navigaionVC:UINavigationController? = nil) -> CameraVC {
        
        if let nc = navigaionVC as? NC {
            if let targetVC: CameraVC =  nc.findVCs(ofType: CameraVC.self).first {
                _ =  nc.popToViewController
                return targetVC
            } else {
                let targetVC: CameraVC = CameraVC.fromNib()
                nc.pushVC(targetVC)
                return targetVC
            }
        } else {
            let targetVC: CameraVC = CameraVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
            return targetVC
        }
    }
    
    func loadProfileVC(navigaionVC:UINavigationController? = nil) {
        
        if let nc = navigaionVC as? NC {
            if let targetVC: ProfileVC =  nc.findVCs(ofType: ProfileVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ProfileVC = ProfileVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ProfileVC = ProfileVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadMyBookingVC(navigaionVC:UINavigationController? = nil) {
        
        if let nc = navigaionVC as? NC {
            if let targetVC: MyBookingVC =  nc.findVCs(ofType: MyBookingVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MyBookingVC = MyBookingVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: MyBookingVC = MyBookingVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadEditProfileVC(navigaionVC:UINavigationController? = nil) {
        
        if let nc = navigaionVC as? NC {
            if let targetVC: EditProfileVC =  nc.findVCs(ofType: EditProfileVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: EditProfileVC = EditProfileVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: EditProfileVC = EditProfileVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    
    func loadMassagePreferenceVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: MassagePreferenceVC =  nc.findVCs(ofType: MassagePreferenceVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MassagePreferenceVC = MassagePreferenceVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MyTherapistVC = MyTherapistVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: SettingVC = SettingVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: NotificationVC = NotificationVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MyPlaceVC = MyPlaceVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: TherapistQuestionariesVC = TherapistQuestionariesVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: MyAddressVC = MyAddressVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ManagePeopleVC = ManagePeopleVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: HowItWorkVC = HowItWorkVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: PriceLocationVC = PriceLocationVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: PromoCodeVC = PromoCodeVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: PackVC = PackVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ReferAndEarnVC = ReferAndEarnVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: CampaignsVC = CampaignsVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: HelpVC = HelpVC.fromNib()
                nc.pushVC(targetVC)
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
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: GiftVoucherVC = GiftVoucherVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: GiftVoucherVC = GiftVoucherVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadCompleteVC(navigaionVC:UINavigationController? = nil, data:CompletionData) {
        if let nc = navigaionVC as? NC {
            if let targetVC: BookingCompleteVC =  nc.findVCs(ofType: BookingCompleteVC.self).first {
                targetVC.completionData = data
                _ = nc.popToVc(targetVC)
                
            } else {
                let targetVC: BookingCompleteVC = BookingCompleteVC.fromNib()
                targetVC.completionData = data
                nc.pushVC(targetVC)
                
            }
        } else {
            let targetVC: BookingCompleteVC = BookingCompleteVC.fromNib()
            targetVC.completionData = data
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadServiceMapVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ServiceMapVC =  nc.findVCs(ofType: ServiceMapVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ServiceMapVC = ServiceMapVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ServiceMapVC = ServiceMapVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    
    func loadManageDocumentVC(navigaionVC:UINavigationController? = nil) {
        
        if let nc = navigaionVC as? NC {
            if let targetVC: ManageDocumentVC =  nc.findVCs(ofType: ManageDocumentVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ManageDocumentVC = ManageDocumentVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ManageDocumentVC = ManageDocumentVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadServiceDetailVC(navigaionVC:UINavigationController? = nil) -> ServiceDetailVC {
        if let nc = navigaionVC as? NC {
            if let targetVC: ServiceDetailVC =  nc.findVCs(ofType: ServiceDetailVC.self).first {
                _ = nc.popToVc(targetVC)
                return targetVC
            } else {
                let targetVC: ServiceDetailVC = ServiceDetailVC.fromNib()
                nc.pushVC(targetVC)
                return targetVC
            }
        } else {
            let targetVC: ServiceDetailVC = ServiceDetailVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
            return targetVC
        }
    }
    
    func loadServiceSelectionVC(navigaionVC:UINavigationController? = nil) -> ServiceSelectionVC {
        if let nc = navigaionVC as? NC {
            if let targetVC: ServiceSelectionVC =  nc.findVCs(ofType: ServiceSelectionVC.self).first {
                _ = nc.popToVc(targetVC)
                return targetVC
            } else {
                let targetVC: ServiceSelectionVC = ServiceSelectionVC.fromNib()
                nc.pushVC(targetVC)
                return targetVC
            }
        } else {
            let targetVC: ServiceSelectionVC = ServiceSelectionVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
            return targetVC
        }
    }
    
    func loadReviewAndBookVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ReviewAndBookVC =  nc.findVCs(ofType: ReviewAndBookVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ReviewAndBookVC = ReviewAndBookVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ReviewAndBookVC = ReviewAndBookVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadPaymentReferenceVC(navigaionVC:UINavigationController? = nil, fromVC: BaseVC?) {
        if let nc = navigaionVC as? NC {
            if let targetVC: PaymentPreferenceVC =  nc.findVCs(ofType: PaymentPreferenceVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: PaymentPreferenceVC = PaymentPreferenceVC.fromNib()
                targetVC.comeFromVC = fromVC
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: PaymentPreferenceVC = PaymentPreferenceVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    
    func loadGiftVoucherDetailVC(navigaionVC:UINavigationController? = nil, data:GiftVoucherDetail) {
        if let nc = navigaionVC as? NC {
            if let targetVC: GiftVoucherDetailVC =  nc.findVCs(ofType: GiftVoucherDetailVC.self).first {
                targetVC.giftVoucherDetail = data
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: GiftVoucherDetailVC = GiftVoucherDetailVC.fromNib()
                targetVC.giftVoucherDetail = data
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: GiftVoucherDetailVC = GiftVoucherDetailVC.fromNib()
            targetVC.giftVoucherDetail = data
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    
    
    func loadAddCardVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: AddCardVC =  nc.findVCs(ofType: AddCardVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: AddCardVC = AddCardVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: AddCardVC = AddCardVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadReservationVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ReservationVC =  nc.findVCs(ofType: ReservationVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ReservationVC = ReservationVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ReservationVC = ReservationVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadKycInfoVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: KycInfoVC =  nc.findVCs(ofType: KycInfoVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: KycInfoVC = KycInfoVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: KycInfoVC = KycInfoVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadScanPassportVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ScanPassportVC =  nc.findVCs(ofType: ScanPassportVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ScanPassportVC = ScanPassportVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ScanPassportVC = ScanPassportVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadScanSelfieVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ScanSelfieVC =  nc.findVCs(ofType: ScanSelfieVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ScanSelfieVC = ScanSelfieVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ScanSelfieVC = ScanSelfieVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadScanSelfieInstructionVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ScanSelfieInstructionVC =  nc.findVCs(ofType: ScanSelfieInstructionVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ScanSelfieInstructionVC = ScanSelfieInstructionVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ScanSelfieInstructionVC = ScanSelfieInstructionVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    func loadScanPassportInstructionVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: ScanPassportInstructionVC =  nc.findVCs(ofType: ScanPassportInstructionVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: ScanPassportInstructionVC = ScanPassportInstructionVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: ScanPassportInstructionVC = ScanPassportInstructionVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    func loadAddGiftVoucherVC(navigaionVC:UINavigationController? = nil) {
        if let nc = navigaionVC as? NC {
            if let targetVC: AddGiftVoucherVC =  nc.findVCs(ofType: AddGiftVoucherVC.self).first {
                _ = nc.popToVc(targetVC)
            } else {
                let targetVC: AddGiftVoucherVC = AddGiftVoucherVC.fromNib()
                nc.pushVC(targetVC)
            }
        } else {
            let targetVC: AddGiftVoucherVC = AddGiftVoucherVC.fromNib()
            let nC: NC = NC(rootViewController: targetVC)
            self.windowConfig(withRootVC: nC)
        }
    }
    
    
    
}

