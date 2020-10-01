//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import Alamofire

typealias API_URL = AppWebApi.URL
typealias API_ERROR_CODE = AppWebApi.ErrorCode

//MARK: WEb Urls
class AppWebApi: NSObject {
    
    struct URL {
        
        private struct Domains {
            static let Dev = "http://35.180.253.133"
            static let Production = "http://35.180.253.133"
            static let Local = "http://35.180.253.133"
        }
        private  struct Routes {
            static let Client = "/api/user"
            static let Setting = "/api/user/setting"
            static let Exception = "/api/error"
            static let Massage = "/api/massage"
            static let Location = "/api/location"
            static let Therapy = "/api/therapy"
            static let Address = "/api/user/address"
            static let People = "/api/user/people"
        }
        private  static let Domain = Domains.Production
        static var UserLogin: String {
            return Domain + Routes.Client  + "/signin"
        }
        
        static var UserRegister: String {
            return Domain + Routes.Client + "/signup"
        }
        static var UserProfile: String {
            return Domain + Routes.Client + "/profile/update"
        }
        
        static var UserLogout: String {
            return Domain + Routes.Setting  + "/logout"
        }
        
        static var UserBookRequest: String {
            return Domain + Routes.Client  + "/booking/create"
        }
        
        static var ChangePassword: String {
            return Domain + Routes.Setting + "/update/password"
        }
        
        static var SettingDetail: String {
            return Domain + Routes.Setting + "/get"
        }
        
        static var UpdateSettingDetail: String {
            return Domain + Routes.Setting + "/save"
        }
        
        static var UploadDocument: String {
            return Domain + Routes.Client + "/documents/" + PreferenceHelper.shared.getUserId()
        }
        
        static var VerifyEmail: String {
            return Domain + Routes.Client + "/verify/email"
        }
        static var VerifyPhone: String {
            return Domain + Routes.Client + "/verify/mobile"
        }
        static var VerifyEmailOTP: String {
            return Domain + Routes.Client + "/compare/otp/email"
        }
        static var VerifyPhoneOTP: String {
            return Domain + Routes.Client + "/compare/otp/mobile"
        }
        static var CheckExeption: String {
            return Domain + Routes.Exception
        }
        static var GetUserDetail: String {
            return  Domain + Routes.Client + "/get/" + PreferenceHelper.shared.getUserId()
        }
        static var GetCountryList: String {
            return Domain + Routes.Location + "/get/country"
        }
        static var GetCityList: String {
            return  Domain + Routes.Location + "/get/city"
        }
        static var GetLocationList: String {
            return  Domain + Routes.Location + "/get/province"
        }
        static var GetMassagePreferenceList: String {
            return  Domain + Routes.Massage + "/preference"
        }
        static var SaveMassagePreferenceList: String {
            return  Domain + Routes.Massage + "/preference/save"
        }
        static var MassageCenterList: String {
            return  Domain + Routes.Massage + "/center/get"
        }
        static var MassageCenerDetail: String {
            return Domain + Routes.Massage + "/get"
        }
        static var TherapistQuesionaryList: String {
            return  Domain + Routes.Therapy + "/questionnaire"
        }
        static var SaveTherapistQuesionaryList: String {
            return  Domain + Routes.Therapy + "/questionnaire/save"
        }
        static var FetchSessionlist: String {
            return  Domain + Routes.Massage + "/session/get"
        }
        //Address APIs
        static var GetAddressList: String {
            return  Domain + Routes.Address + "/get"
        }
        static var RemoveAddress: String {
            return  Domain + Routes.Address + "/remove"
        }
        static var UpdateAddress: String {
            return  Domain + Routes.Address + "/update"
        }
        static var AddAddress: String {
            return  Domain + Routes.Address + "/save"
        }
        //Manage People APIs
        static var GetPeopleList: String {
            return  Domain + Routes.People + "/get"
        }
        static var RemovePeople: String {
            return  Domain + Routes.People + "/remove"
        }
        static var UpdatePeople: String {
            return  Domain + Routes.People + "/update"
        }
        static var AddPeople: String {
            return  Domain + Routes.People + "/save"
        }
        static var GetBookingTherapistList: String {
            return  Domain + Routes.Client + "/booking/therapists"
        }
        static var RateTherapist: String {
            return  Domain + Routes.Client + "/therapist/review/save"
        }
        static var GetBookingPlacesList: String {
            return  Domain + Routes.Client + "/booking/places"
        }
        
        static var GetMenuDetail: String {
            return  Domain + Routes.Client + "/menu/item/get"
        }
        static var GetMenuList: String {
                   return  Domain + Routes.Client + "/menu/get"
        }
        
        static var GetBookingPast: String {
            return  Domain + Routes.Client + "/booking/list/past"
        }
        static var GetBookingFuture: String {
            return  Domain + Routes.Client + "/booking/list/future"
        }
        
        static var GetVoucherList: String {
            return  Domain + Routes.Client + "/gift/voucher/get"
        }
        
        static var GetVoucherInfo: String {
            return  Domain + Routes.Client + "/gift/voucher/info"
        }
        
        static var BookVoucher: String {
            return  Domain + Routes.Client + "/gift/voucher/save"
        }
        
        static var GiftVoucherDesign: String {
            return  Domain + Routes.Client + "/gift/voucher/design/get"
        }
        
        static var FaqList: String {
            return  Domain + Routes.Client + "/faq/get"
        }
        //Package APIs
        static var PackList: String {
            return  Domain + Routes.Client + "/pack/get"
        }
        static var BuyPack: String {
            return  Domain + Routes.Client + "/pack/order/save"
        }
        
        static var BuyGiftPack: String {
            return  Domain + Routes.Client + "/pack/gift/save"
        }
        
        static var PackServiceList: String {
            return  Domain + Routes.Client + "/pack/services/get"
        }
    }
}

//MARK: Known Error Codes

extension AppWebApi {
    struct ErrorCode {
        static let InvalidServerToken: String = "ERROR_12"
        static let DetailNotFound: String = "ERROR_13"
    }
}
