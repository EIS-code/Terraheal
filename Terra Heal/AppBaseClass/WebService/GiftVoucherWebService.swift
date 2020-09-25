//
//  MyPlacesWebService.swift
//  Terra Heal
//
//  Created by Jaydeep Vyas on 18/09/20.
//  Copyright © 2020 Evolution. All rights reserved.
//

import Foundation

enum VoucherWebService {
    
    struct RequestVoucherList: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
    }
    struct RequestVoucherInfo: Codable {
        var user_id: String = PreferenceHelper.shared.getUserId()
    }
   
    struct RequestPurchageVoucher: Codable {
        var shop_id: String = ""
        var design_id: String = ""
        var giver_email: String = ""
        var giver_first_name: String = ""
        var giver_last_name: String = ""
        var giver_message_to_recipient: String = ""
        var giver_mobile: String = ""
        var amount: String = ""
        var massage_id: String = ""
        var preference_email: String = ""
        var preference_email_date: String = ""
        var recipient_email: String = ""
        var recipient_last_name: String = ""
        var recipient_mobile: String = ""
        var recipient_name: String = ""
        var recipient_second_name: String = ""
        var user_id: String = PreferenceHelper.shared.getUserId()
        
        func validate() -> String {
            if shop_id.isEmpty() {
                return "GIFT_VOUCHER_VALIDATION_SELECT_CENTER".localized()
            } else if design_id.isEmpty() {
                return "GIFT_VOUCHER_VALIDATION_SELECT_THEME".localized()
            } else if design_id.isEmpty() {
                return "GIFT_VOUCHER_VALIDATION_SELECT_SERVICE".localized()
            } else if giver_email.isEmpty() {
                return "GIFT_VOUCHER_VALIDATION_FILL_GIVER_DETAIL".localized()
            } else if recipient_email.isEmpty() {
                return "GIFT_VOUCHER_VALIDATION_FILL_RECIPIENT_DETAIL".localized()
            } else if preference_email.isEmpty() {
                return "GIFT_VOUCHER_VALIDATION_SELECT_SENDING_PREFERENCE".localized()
            } else {
                return ""
            }
        }
    }
    
    class Response: ResponseModel {
        var voucherList: [Voucher] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            voucherList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    voucherList.append(Voucher.init(fromDictionary: data))
                }
            }
        }
    }
    
    class ResponseVoucherInfo: ResponseModel {
        var voucherInfo: MenuItemDetail = MenuItemDetail.init(fromDictionary: [:])
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                if let info = dataArray.first {
                    self.voucherInfo = MenuItemDetail.init(fromDictionary: info)
                }
            }
        }
    }
    
    class ResponseVoucherPurchageInfo: ResponseModel {
        var voucherInfo: Voucher = Voucher.init(fromDictionary: [:])
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                if let info = dataArray.first {
                    self.voucherInfo = Voucher.init(fromDictionary: info)
                }
            }
        }
    }
}


class Voucher: ResponseModel {
    
    var designId: String = ""
    var giverEmail: String = ""
    var giverFirstName: String = ""
    var giverLastName: String = ""
    var giverMessageToRecipient: String = ""
    var giverMobile: String = ""
    var id: String = ""
    var isPack: String = ""
    var lastDate: String = ""
    var massageId: String = ""
    var preferenceEmail: String = ""
    var preferenceEmailDate: String = ""
    var recipientEmail: String = ""
    var recipientLastName: String = ""
    var recipientMobile: String = ""
    var recipientName: String = ""
    var recipientSecondName: String = ""
    var startFrom: String = ""
    var uniqueId: String = ""
    var userId: String = ""
    var amount: String = ""
    
    func getHeader() -> String {
        let recieverName = self.recipientName + " " + self.recipientSecondName + " "  + self.recipientLastName
        let giverName = self.giverFirstName + " " + self.giverLastName
        return "GIFT_VOUCHER_HEADER".localized(with: [recieverName,giverName])
    }
    
    init() {
        super.init(fromDictionary: [:])
    }
    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    override init(fromDictionary dictionary: [String:Any]) {
        super.init(fromDictionary: dictionary)
        self.designId = (dictionary["design_id"] as? String) ?? ""
        self.giverEmail = (dictionary["giver_email"] as? String) ?? ""
        self.giverFirstName = (dictionary["giver_first_name"] as? String) ?? ""
        self.giverLastName = (dictionary["giver_last_name"] as? String) ?? ""
        self.giverMessageToRecipient = (dictionary["giver_message_to_recipient"] as? String) ?? ""
        self.giverMobile = (dictionary["giver_mobile"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.isPack = (dictionary["is_pack"] as? String) ?? ""
        self.lastDate = (dictionary["last_date"] as? String) ?? ""
        self.massageId = (dictionary["massage_id"] as? String) ?? ""
        self.preferenceEmail = (dictionary["preference_email"] as? String) ?? ""
        self.preferenceEmailDate = (dictionary["preference_email_date"] as? String) ?? ""
        self.recipientEmail = (dictionary["recipient_email"] as? String) ?? ""
        self.recipientLastName = (dictionary["recipient_last_name"] as? String) ?? ""
        self.recipientMobile = (dictionary["recipient_mobile"] as? String) ?? ""
        self.recipientName = (dictionary["recipient_name"] as? String) ?? ""
        self.recipientSecondName = (dictionary["recipient_second_name"] as? String) ?? ""
        self.startFrom = (dictionary["start_from"] as? String) ?? ""
        self.uniqueId = (dictionary["unique_id"] as? String) ?? ""
        self.userId = (dictionary["user_id"] as? String) ?? ""
        self.amount = (dictionary["amount"] as? String) ?? ""
    }
}


