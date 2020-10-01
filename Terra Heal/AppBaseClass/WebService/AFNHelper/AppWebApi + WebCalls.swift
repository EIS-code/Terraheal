//
//  AppWebApi + WebCalls.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 29/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

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
        }
        else {
            AlamofireHelper().getDataFrom(urlString: API_URL.UserProfile, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = User.Response.init(fromDictionary: dictionary)
                completionHandler(response)        }
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
        if params.latitude != "" && params.longitude != "" {
            AlamofireHelper().getDataFrom(urlString: API_URL.MassageCenterList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = ServiceCenter.Response.init(fromDictionary: dictionary)
                completionHandler(response)
            }
        } else {
            print("Location Not Found")
            let response = ServiceCenter.Response.init(fromDictionary: [:])
            completionHandler(response)
        }

    }
    class func massageCenterDetail(params:ServiceCenter.RequestServiceCenterDetail, completionHandler: @escaping ((ServiceCenter.ServiceCenterDetailResponse) -> Void)) {
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
    class func addPeople(params:ManagePeople.RequestAddPeoples, image:UploadDocumentDetail? = nil, paramName:String = "photo", completionHandler: @escaping ((ManagePeople.Response) -> Void)) {
        if let imageToUpload = image { AlamofireHelper().uploadDocumentToURL(urlString:API_URL.AddPeople , paramData: params.dictionary, documents: [imageToUpload],paramName: paramName)  { (data, dictionary, error) in
            let response = ManagePeople.Response.init(fromDictionary: dictionary)
            completionHandler(response)
            }
        }
        else {
            AlamofireHelper().getDataFrom(urlString: API_URL.AddPeople, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = ManagePeople.Response.init(fromDictionary: dictionary)
                completionHandler(response)        }
        }
    }

    class func getPeopleList(params:ManagePeople.RequestPeoplelist = ManagePeople.RequestPeoplelist(), completionHandler: @escaping ((ManagePeople.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetPeopleList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ManagePeople.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func updatePeople(params:ManagePeople.RequestUpdatePeople, image:UploadDocumentDetail? = nil, paramName:String = "photo", completionHandler: @escaping ((ManagePeople.Response) -> Void)) {
        if let imageToUpload = image { AlamofireHelper().uploadDocumentToURL(urlString:API_URL.UpdatePeople , paramData: params.dictionary, documents: [imageToUpload],paramName: paramName)  { (data, dictionary, error) in
            let response = ManagePeople.Response.init(fromDictionary: dictionary)
            completionHandler(response)
            }
        } else {
            AlamofireHelper().getDataFrom(urlString: API_URL.UpdatePeople, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
                let response = ManagePeople.Response.init(fromDictionary: dictionary)
                completionHandler(response)        }
        }
    }
    class func removePeople(params:ManagePeople.RequestDeletePeople, completionHandler: @escaping ((ManagePeople.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.RemovePeople, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = ManagePeople.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
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
    class func getGiftVoucherList(params:VoucherWebService.RequestVoucherList = VoucherWebService.RequestVoucherList(), completionHandler: @escaping ((VoucherWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetVoucherList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = VoucherWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    class func getGiftVoucherInfo(params:VoucherWebService.RequestVoucherInfo = VoucherWebService.RequestVoucherInfo(), completionHandler: @escaping ((VoucherWebService.ResponseVoucherInfo) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetVoucherInfo, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = VoucherWebService.ResponseVoucherInfo.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func getGiftDesignList(params:GiftDesignWebService.RequestDesignList = GiftDesignWebService.RequestDesignList(), completionHandler: @escaping ((GiftDesignWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GiftVoucherDesign, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = GiftDesignWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func getFaqList(params:FAQWebService.RequestFAQlist = FAQWebService.RequestFAQlist(), completionHandler: @escaping ((FAQWebService.ResponseFAQList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.FaqList, methodName: AlamofireHelper.GET_METHOD, paramData: [:]) { (data, dictionary, error) in
            let response = FAQWebService.ResponseFAQList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func buyGiftVoucher(params:VoucherWebService.RequestPurchageVoucher, completionHandler: @escaping ((VoucherWebService.ResponseVoucherPurchageInfo) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.BookVoucher, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = VoucherWebService.ResponseVoucherPurchageInfo.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func getPackageList(params:PackageWebService.RequestPackageList, completionHandler: @escaping ((PackageWebService.ResponsePackageList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.PackList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = PackageWebService.ResponsePackageList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func getPackageServiceList(params:PackageWebService.RequestPackageServiceList, completionHandler: @escaping ((PackageWebService.ResponsePackageServiceList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.PackServiceList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = PackageWebService.ResponsePackageServiceList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func getPurchasedPackageList(params:PackageWebService.RequestPurchasedPackageList = PackageWebService.RequestPurchasedPackageList(), completionHandler: @escaping ((PackageWebService.ResponsePurchasedPackageList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.PackList, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = PackageWebService.ResponsePurchasedPackageList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func buyPackage(params:PackageWebService.RequestBuyPackage, completionHandler: @escaping ((PackageWebService.ResponsePackageList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.BuyPack, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = PackageWebService.ResponsePackageList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func buyPackageForGift(params:PackageWebService.RequestBuyPackage, completionHandler: @escaping ((PackageWebService.ResponsePackageList) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.BuyGiftPack, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = PackageWebService.ResponsePackageList.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func getPastBookingList(params:MyBookingWebService.RequestPastBookingList = MyBookingWebService.RequestPastBookingList(), completionHandler: @escaping ((MyBookingWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetBookingPast, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = MyBookingWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }
    class func getFutureBookingList(params:MyBookingWebService.RequestFutureBookingList = MyBookingWebService.RequestFutureBookingList(), completionHandler: @escaping ((MyBookingWebService.Response) -> Void)) {
        AlamofireHelper().getDataFrom(urlString: API_URL.GetBookingFuture, methodName: AlamofireHelper.POST_METHOD, paramData: params.dictionary) { (data, dictionary, error) in
            let response = MyBookingWebService.Response.init(fromDictionary: dictionary)
            completionHandler(response)
        }
    }

    func checkUserLogin() -> Bool {
        if PreferenceHelper.shared.getUserId().isNotEmpty() {
            return true
        } else {
            Common.appDelegate.loadWelcomeVC()
            return false
        }
    }
}
