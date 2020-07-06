//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


enum SettingMenu: String {
    case PreferredLanguage = "0"
    case ChangePassword = "1"
    case Currency = "2"
    case DistanceUnit = "3"
    case Notification = "4"
    case TermsAndCondition = "5"
    case Privacy = "6"
    case Logout = "7"
    func name() -> String {
        switch self {
        case .PreferredLanguage:
            return "SETTING_PREFERRED_LANGUAGE".localized()
        case .ChangePassword:
            return  "SETTING_CHANGE_PASSWORD".localized()
        case .Currency:
            return  "SETTING_CURRENCY".localized()
        case .DistanceUnit:
            return  "SETTING_DISTANCE_UNIT".localized()
        case .Notification:
            return  "SETTING_NOTIFICATION".localized()
        case .TermsAndCondition:
            return  "SETTING_TERMS_AND_CONDITION".localized()
        case .Privacy:
            return  "SETTING_PRIVACY".localized()
        case .Logout:
            return  "SETTING_LOGOUT".localized()
        }
    }

}

struct SettingPreferenceDetail {

    var type: SettingMenu = SettingMenu.Logout
    var strDetail: String = ""
    var isSelected: Bool = false
}

class SettingVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    var settingDetail:Setting = Setting.init(fromDictionary: [:])
    var arrForData: [SettingPreferenceDetail] = [
        SettingPreferenceDetail(type: SettingMenu.PreferredLanguage, strDetail: "", isSelected: false),
        SettingPreferenceDetail(type: SettingMenu.ChangePassword, strDetail: "", isSelected: false),
        SettingPreferenceDetail(type: SettingMenu.Currency, strDetail: "", isSelected: false),
        SettingPreferenceDetail(type: SettingMenu.DistanceUnit, strDetail: "", isSelected: false),
        SettingPreferenceDetail(type: SettingMenu.Notification, strDetail: "", isSelected: false),
        SettingPreferenceDetail(type: SettingMenu.TermsAndCondition, strDetail: "", isSelected: false),
        SettingPreferenceDetail(type: SettingMenu.Privacy, strDetail: "", isSelected: false),
        SettingPreferenceDetail(type: SettingMenu.Logout, strDetail: "",  isSelected: false)

    ]
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {


    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
        self.addBottomFade()
        self.addTopFade()
        self.wsGetSettingDetail()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tableView?.reloadData({})
            self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)
        }
    }

    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "SETTING_MENU_TITTLE".localized())
        self.btnBack.setBackButton()
    }

    func openMassagerPressurePicker() {
        let alert: CustomPressurePicker = CustomPressurePicker.fromNib()
        alert.initialize(title: "MASSAGE_PREFERENCE_MENU_ITEM_1".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)
        }
        alert.onBtnDoneTapped = {
             [weak alert, weak self] (pressure) in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)

        }
    }



    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }




}
//MARK:- Dialogs
extension SettingVC {
    func openLanguagePicker() {
        let alert: CustomLanguagePicker = CustomLanguagePicker.fromNib()
        alert.initialize(title: SettingMenu.PreferredLanguage.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        if settingDetail.languageCode.isNotEmpty() {
            alert.select(language: PreferLanguage.init(rawValue: settingDetail.languageCode) ?? PreferLanguage.English)
        }
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (language) in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)
            var request: SettingPreference.SaveSettingPrefence = SettingPreference.SaveSettingPrefence()
            request.language_code = language.code()
            
            self.wsUpdateSettingDetail(request: request)
            
        }
    }

    func openTermsAndConditonPicker() {
        let alert: CustomInformationDialog = CustomInformationDialog.fromNib()
        alert.initialize(title: SettingMenu.TermsAndCondition.name(), data: settingDetail.terms, buttonTitle: "".localized(), cancelButtonTitle: "".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
             guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
             guard let self = self else { return } ; print(self)
            alert?.dismiss()

        }
    }

    func openPrivacyPolicyPicker() {
        let alert: CustomInformationDialog = CustomInformationDialog.fromNib()
        alert.initialize(title: SettingMenu.Privacy.name(), data: settingDetail.privacy, buttonTitle: "".localized(), cancelButtonTitle: "".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
             guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
             guard let self = self else { return } ; print(self)
            alert?.dismiss()

        }
    }


    func openCurrencyPicker() {
        let alert: CustomCurrencyPicker = CustomCurrencyPicker.fromNib()
        alert.initialize(title: SettingMenu.Currency.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        if settingDetail.currencyCode.isNotEmpty() {
            alert.select(currency: Currency.init(rawValue: settingDetail.currencyCode) ?? Currency.Euro)
        }
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (currency) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            print(currency.name())
            var request: SettingPreference.SaveSettingPrefence = SettingPreference.SaveSettingPrefence()
            request.currency_code = currency.name()
            self.wsUpdateSettingDetail(request: request)
            
        }
    }

    func openDistanceUnitPicker() {
           let alert: CustomDistanceUnitPicker = CustomDistanceUnitPicker.fromNib()
           alert.initialize(title: SettingMenu.DistanceUnit.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
           alert.show(animated: true)
            if settingDetail.unit.isNotEmpty() {
                alert.select(data: DistanceUnit.init(rawValue: settingDetail.unit) ?? DistanceUnit.Kilometre)
            }
           alert.onBtnCancelTapped = {
               [weak alert, weak self] in
               guard let self = self else { return } ; print(self)
               alert?.dismiss()
           }
           alert.onBtnDoneTapped = {
               [weak alert, weak self] (data) in
               guard let self = self else { return } ; print(self)
               alert?.dismiss()
               print(data.name())
               var request: SettingPreference.SaveSettingPrefence = SettingPreference.SaveSettingPrefence()
            request.unit = data.symbol()
               self.wsUpdateSettingDetail(request: request)
               
           }
       }
    
    func openChangePasswordDialog() {
        let alert: CustomChangePasswordDialog = CustomChangePasswordDialog.fromNib()
        alert.initialize(title: SettingMenu.ChangePassword.name(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (password,newpassword) in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)
            var request = User.RequestChangePassword.init()
            request.new_password = newpassword
            request.old_password = password
            self.wsUpdatePassword(request: request)
        }
    }

}

extension SettingVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(SettingTblCell.nib()
            , forCellReuseIdentifier: SettingTblCell.name)
        tableView.register(SettingSwitchTblCell.nib()
            , forCellReuseIdentifier: SettingSwitchTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        if arrForData[indexPath.row].type == SettingMenu.Notification {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingSwitchTblCell.name, for: indexPath) as?  SettingSwitchTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForData[indexPath.row])
            cell?.layoutIfNeeded()
            cell?.parentVC = self
            return cell!


        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: SettingTblCell.name, for: indexPath) as?  SettingTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForData[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!

        }

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let settingMenu = self.arrForData[indexPath.row]
        switch settingMenu.type {
        case .PreferredLanguage:
            self.openLanguagePicker()
        case .ChangePassword:
            self.openChangePasswordDialog()
        case .Currency:
            self.openCurrencyPicker()
        case .DistanceUnit:
              self.openDistanceUnitPicker()
        case .Notification:
            Common.appDelegate.loadNotificationVC(navigaionVC: self.navigationController)
        case .TermsAndCondition:
            self.openTermsAndConditonPicker()
        case .Privacy:
            self.openPrivacyPolicyPicker()
        case .Logout:
            self.wsLogout()
        }

    }
    func setData() {
        for i  in 0..<arrForData.count {
            let data = arrForData[i]
            
            switch data.type {
                case .PreferredLanguage:
                    arrForData[i].strDetail = settingDetail.languageCode
                    arrForData[i].isSelected = settingDetail.languageCode.isNotEmpty()
                case .ChangePassword:
                    arrForData[i].strDetail = ""
                case .Currency:
                    arrForData[i].strDetail = settingDetail.currencyCode
                    arrForData[i].isSelected = settingDetail.currencyCode.isNotEmpty()
                case .DistanceUnit:
                    arrForData[i].strDetail = settingDetail.unit
                case .Notification:
                    arrForData[i].strDetail = settingDetail.notification
                case .TermsAndCondition:
                    arrForData[i].strDetail = ""
                case .Privacy:
                    arrForData[i].strDetail = ""
                case .Logout:
                    arrForData[i].strDetail = ""
                }
        }
        self.tableView.reloadData()
    }
    
}


extension SettingVC {
    func wsGetSettingDetail() {
        Loader.showLoading()
        AppWebApi.getSettingDetail { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.settingDetail = response.settingDetail
                self.setData()
            }
            
        }
    }
    
    func wsUpdateSettingDetail(request:SettingPreference.SaveSettingPrefence) {
        Loader.showLoading()
        AppWebApi.updateSetting(params: request, completionHandler: { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response,withSuccessToast: true,andErrorToast: true) {
                self.settingDetail = response.settingDetail
                self.setData()
            }
        })
            
    }
    func wsLogout() {
           Loader.showLoading()
           AppWebApi.userLogout { (response) in
               Loader.hideLoading()
               if ResponseModel.isSuccess(response: response) {
                   Common.appDelegate.loadWelcomeVC()
               }
           }
    }
    
    func wsUpdatePassword(request:User.RequestChangePassword) {
        Loader.showLoading()
        AppWebApi.changePassword(params: request, completionHandler: { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response,withSuccessToast: true,andErrorToast: true) {
            }
        })
            
    }
}
