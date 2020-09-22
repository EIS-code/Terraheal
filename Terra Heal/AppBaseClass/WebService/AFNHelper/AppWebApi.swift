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
        
        static var GetBookingList: String {
            return  Domain + Routes.Client + "/booking/list/past"
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


extension AppWebApi {
    
    class func login(params:User.RequestLogin, completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.UserLogin, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func bookRequest(params:[String:Any], completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.UserBookRequest, methodName: AlamofireHelper.POST_METHOD, paramData: params) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    
    
    class func getUserDetail(completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetUserDetail, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func register(params:User.RequestRegister, completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.UserRegister, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func getEmailOtp(params:User.RequestEmailOTP, completionHandler: @escaping ((User.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.VerifyEmail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func getPhoneOtp(params:User.RequestPhoneOTP, completionHandler: @escaping ((User.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.VerifyPhone, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func verifyEmailOtp(params:User.RequestVerifyEmailOTP, completionHandler: @escaping ((User.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.VerifyEmailOTP, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func verifyPhoneOtp(params:User.RequestVerifyPhoneOTP, completionHandler: @escaping ((User.ResponseVerification) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.VerifyPhoneOTP, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = User.ResponseVerification.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func profile(params:User.RequestProfile, image:UploadDocumentDetail? = nil, paramName:String = "profile_photo", completionHandler: @escaping ((User.Response) -> Void)) {
        
        
        if let imageToUpload = image {
            AlamofireHelper().uploadDocumentToURL(urlString:API_URL.UserProfile , paramData: params.dictionary, documents: [imageToUpload],paramName: paramName)  { (data, dictionary, error) in
                let response = User.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        } else {
            AlamofireHelper().getDataFrom(urlString: API_URL.UserProfile, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = User.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        }
    }
    
    
    class func uploadDocument(params:User.RequestUploadDocument, documents:[UploadDocumentDetail],paramName:String = "file", completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().uploadDocumentToURL(urlString:API_URL.UploadDocument , paramData: params.dictionary, documents: documents, paramName: paramName)  { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func exception(params:[String:String], completionHandler: @escaping ((User.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.CheckExeption, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = User.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func fetchSessionList(params:Session.RequestList, completionHandler: @escaping ((Session.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.FetchSessionlist, methodName: AlamofireHelper.POST_METHOD, paramData:params.dictionary) { (data, dictionary, error) in
            let response = Session.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func countryList(params:Countries.RequestCountrylist = Countries.RequestCountrylist(), completionHandler: @escaping ((Countries.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetCountryList, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = Countries.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    
    class func massageCenterList(params:ServiceCenter.RequestServiceCenterlist = ServiceCenter.RequestServiceCenterlist(), completionHandler: @escaping ((ServiceCenter.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.MassageCenterList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ServiceCenter.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func massageCenterDetail(params:ServiceCenter.RequestServiceCenterDetail = ServiceCenter.RequestServiceCenterDetail(), completionHandler: @escaping ((ServiceCenter.ServiceCenterDetailResponse) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.MassageCenerDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ServiceCenter.ServiceCenterDetailResponse.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    
    class func locationList(params:PriceAndLocation.RequestLocationlist = PriceAndLocation.RequestLocationlist(), completionHandler: @escaping ((PriceAndLocation.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetLocationList, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = PriceAndLocation.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func cityList(params:Cities.RequestCitylist, completionHandler: @escaping ((Cities.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetCityList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Cities.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func massagePreferencceList(params:MassagePreference.RequestMassagePrefenceList = MassagePreference.RequestMassagePrefenceList(), completionHandler: @escaping ((MassagePreference.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetMassagePreferenceList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = MassagePreference.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func saveMassagePreferencceList(params:MassagePreference.SaveMassagePrefenceList = MassagePreference.SaveMassagePrefenceList(), completionHandler: @escaping ((MassagePreference.Response) -> Void)) {
        
        AlamofireHelper().getDataFrom(urlString: API_URL.SaveMassagePreferenceList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = MassagePreference.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func therapistQuestionList(params:TherapistQuastionaries.RequestQuestionList = TherapistQuastionaries.RequestQuestionList(), completionHandler: @escaping ((TherapistQuastionaries.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.TherapistQuesionaryList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = TherapistQuastionaries.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func saveQuestionList(params:TherapistQuastionaries.SaveQuestionList = TherapistQuastionaries.SaveQuestionList(), completionHandler: @escaping ((TherapistQuastionaries.Response) -> Void)) {
        
        AlamofireHelper().getDataFrom(urlString: API_URL.SaveTherapistQuesionaryList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = TherapistQuastionaries.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    //MARK:  Address Related APIS
    
    class func addAddress(params:Addresses.RequestAddAddress, completionHandler: @escaping ((Addresses.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.AddAddress, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Addresses.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func getAddress(params:Addresses.RequestAddresslist = Addresses.RequestAddresslist(), completionHandler: @escaping ((Addresses.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetAddressList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Addresses.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    
    class func updateAddress(params:Addresses.RequestUpdateAddress, completionHandler: @escaping ((Addresses.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.UpdateAddress, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Addresses.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func removeAddress(params:Addresses.RequestDeleteAddress, completionHandler: @escaping ((Addresses.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.RemoveAddress, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = Addresses.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    //MARK:  Address Related APIS
    
    class func addPeople(params:ManagePeople.RequestAddPeoples, image:UploadDocumentDetail? = nil, paramName:String = "photo", completionHandler: @escaping ((ManagePeople.Response) -> Void)) {
        
        if let imageToUpload = image {
            AlamofireHelper().uploadDocumentToURL(urlString:API_URL.AddPeople , paramData: params.dictionary, documents: [imageToUpload],paramName: paramName)  { (data, dictionary, error) in
                let response = ManagePeople.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        } else {
            AlamofireHelper().getDataFrom(urlString: API_URL.AddPeople, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = ManagePeople.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        }
        
        
    }
    
    class func getPeopleList(params:ManagePeople.RequestPeoplelist = ManagePeople.RequestPeoplelist(), completionHandler: @escaping ((ManagePeople.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetPeopleList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ManagePeople.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    
    class func updatePeople(params:ManagePeople.RequestUpdatePeople, image:UploadDocumentDetail? = nil, paramName:String = "photo", completionHandler: @escaping ((ManagePeople.Response) -> Void)) {
        if let imageToUpload = image {
            AlamofireHelper().uploadDocumentToURL(urlString:API_URL.UpdatePeople , paramData: params.dictionary, documents: [imageToUpload],paramName: paramName)  { (data, dictionary, error) in
                let response = ManagePeople.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        } else {
            AlamofireHelper().getDataFrom(urlString: API_URL.UpdatePeople, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = ManagePeople.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        }
        
    }
    class func removePeople(params:ManagePeople.RequestDeletePeople, completionHandler: @escaping ((ManagePeople.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.RemovePeople, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ManagePeople.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    
    //MARK:   Setting APIS
    class func getSettingDetail(params:SettingPreference.RequestSettingPrefenceList = SettingPreference.RequestSettingPrefenceList(), completionHandler: @escaping ((SettingPreference.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.SettingDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = SettingPreference.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func updateSetting(params:SettingPreference.SaveSettingPrefence, completionHandler: @escaping ((SettingPreference.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.UpdateSettingDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = SettingPreference.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func userLogout(params:User.RequestLogout = User.RequestLogout(), completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.UserLogout, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func changePassword(params:User.RequestChangePassword, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.ChangePassword, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    
    class func rateTherapist(params:TherapistWebService.RequestSaveRating, completionHandler: @escaping ((ResponseModel) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.RateTherapist, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ResponseModel.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func getBookingTherapistList(params:TherapistWebService.RequestBookingTherapist = TherapistWebService.RequestBookingTherapist() , completionHandler: @escaping ((TherapistWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetBookingTherapistList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = TherapistWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func getBookingPlacesList(params:PlacesWebService.RequestBookingPlaces = PlacesWebService.RequestBookingPlaces(), completionHandler: @escaping ((PlacesWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetBookingPlacesList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = PlacesWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func getMenuDetail(params:MenuItemWebService.RequestMenuDetail = MenuItemWebService.RequestMenuDetail(), completionHandler: @escaping ((MenuItemWebService.ResponseMenuDetail) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetMenuDetail, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = MenuItemWebService.ResponseMenuDetail.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
    class func getMenuList(completionHandler: @escaping ((MenuItemWebService.ResponseMenuList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetMenuList, methodName: AlamofireHelper.GET_METHOD, paramData:[:]) { (data, dictionary, error) in
            let response = MenuItemWebService.ResponseMenuList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    
     class func getPastBookingList(params:MyBookingWebService.RequestPastBookingList = MyBookingWebService.RequestPastBookingList(), completionHandler: @escaping ((MyBookingWebService.Response) -> Void)) {
           AlamofireHelper().getDataFrom(urlString: API_URL.GetBookingList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
               let response = MyBookingWebService.Response.init(fromDictionary: dictionary)
               completionHandler(response)
           }
       }
    
}





