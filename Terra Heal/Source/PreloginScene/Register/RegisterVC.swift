//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class RegisterVC: BaseVC {
    
    @IBOutlet weak var ivHeader: UIImageView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var hVwContent: NSLayoutConstraint!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet weak var txtName: ACFloatingTextfield!
    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtMobileNumber: ACFloatingTextfield!
    @IBOutlet weak var txtCountryPhoneCode: ACFloatingTextfield!
    @IBOutlet weak var txtReferralCode: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var txtConfirmPassword: ACFloatingTextfield!
    @IBOutlet weak var vwTermsCondition: UIView!
    @IBOutlet weak var btnTermsCondition: UnderlineTextButton!
    @IBOutlet weak var lblAccept: ThemeLabel!
    @IBOutlet weak var btnCheckBox: JDCheckboxButton!
    @IBOutlet weak var lblConnect: ThemeLabel!
    @IBOutlet weak var btnSignUp: FilledRoundedButton!
    @IBOutlet weak var btnFacebook: ThemeButton!
    @IBOutlet weak var btnGoogle: ThemeButton!
    @IBOutlet weak var btnLogin: UnderlineTextButton!
    @IBOutlet weak var lblAlreadyMember: ThemeLabel!
    @IBOutlet weak var vwDashed: UIView!
    
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    // MARK: Setup
    private func setup() {
    }
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.ivHeader.adjustHeight()
            btnGoogle?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
            btnLogin?.setRound(withBorderColor: .clear, andCornerRadious: 5.0, borderWidth: 1.0)
            self.vwDashed?.createDashedLine(from: CGPoint(x: vwDashed.bounds.minX, y: vwDashed.bounds.midY), to: CGPoint(x: vwDashed.bounds.maxX, y: vwDashed.bounds.midY), color: UIColor.themeSecondary, strokeLength: 10, gapLength: 10, width: 2.0)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.lblConnect.backgroundColor = UIColor.themeBackground
        self.lblMessage?.text = "REGISTER_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Bold, size: FontSize.header)
        self.txtName?.placeholder = "REGISTER_TXT_NAME".localized()
        self.txtName?.delegate = self
        self.txtName?.configureTextField(InputTextFieldDetail.getNameConfiguration())
        self.txtEmail?.placeholder = "REGISTER_TXT_EMAIL".localized()
        self.txtEmail?.delegate = self
        self.txtEmail?.configureTextField(InputTextFieldDetail.getEmailConfiguration())
        self.txtCountryPhoneCode?.placeholder = "".localized()
        self.txtCountryPhoneCode?.delegate = self
        self.txtCountryPhoneCode?.text = CountryPhone.modelsFromDictionaryArray().first?.countryPhoneCode
        self.txtMobileNumber?.placeholder = "REGISTER_TXT_MOBILE_NUMBER".localized()
        self.txtMobileNumber?.delegate = self
        self.txtMobileNumber?.configureTextField(InputTextFieldDetail.getMobileConfiguration())
        self.txtReferralCode?.placeholder = "REGISTER_TXT_REFFERAL_CODE".localized()
        self.txtReferralCode?.delegate = self
        self.txtReferralCode?.configureTextField(InputTextFieldDetail.getNameConfiguration())
        self.txtPassword?.placeholder = "REGISTER_TXT_PASSWORD".localized()
        self.txtPassword?.delegate = self
        self.txtPassword?.setupPasswordTextFielad()
        self.txtPassword?.configureTextField(InputTextFieldDetail.getPassowordConfiguration())
        self.txtConfirmPassword?.placeholder = "REGISTER_TXT_CONFIRM_PASSWORD".localized()
        self.txtConfirmPassword?.delegate = self
        self.txtConfirmPassword?.setupPasswordTextFielad()
        self.txtConfirmPassword?.configureTextField(InputTextFieldDetail.getPassowordConfiguration())
        self.lblConnect?.text = "REGISTER_LBL_CONNECT_VIA".localized()
        self.lblConnect?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.lblAccept?.text = "REGISTR_LBL_ACCEPT".localized()
        self.lblAccept?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
        self.btnTermsCondition?.setFont(name: FontName.SemiBold, size: FontSize.button_17)
        self.btnTermsCondition?.setTitle("REGISTR_BTN_TERMS_AND_CONDITION".localized(), for: .normal)
        self.btnLogin?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnLogin?.setTitle("REGISTER_BTN_SIGN_IN".localized(), for: .normal)
        self.btnSignUp?.setTitle("REGISTER_BTN_SIGN_UP".localized(), for: .normal)
        self.lblAlreadyMember?.text = "REGISTER_LBL_ALREADY_A_MEMBER".localized()
        self.lblAlreadyMember?.setFont(name: FontName.SemiBold, size: FontSize.subHeader)
    }
    
    // MARK: - Action Methods
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
       Common.appDelegate.loadWelcomeVC(navigaionVC: self.navigationController)
    }
    
    @IBAction func btnCheckBoxTapped(_ sender: JDCheckboxButton) {
        self.btnCheckBox.checkboxAnimation {
        }
    }
    
    @IBAction func btnLoginTapped(_ sender: UIButton) {
        Common.appDelegate.loadLoginVC(navigaionVC: self.navigationController)
    }
    
    @IBAction func btnRegisterTapped(_ sender: UIButton) {
        self.view.endEditing(true)
        if checkValidation() {
            self.wsRegister()
        }
    }
    
    @IBAction func btnTermsTapped(_ sender: Any) {
        self.openTermsAndConditonPicker()
    }
}

extension RegisterVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtName {
            _ = txtEmail?.becomeFirstResponder()
        } else if textField == txtEmail {
            _ = txtMobileNumber?.becomeFirstResponder()
        } else if textField == txtMobileNumber {
            _ = txtReferralCode?.becomeFirstResponder()
        } else if textField == txtReferralCode {
            _ = txtPassword?.becomeFirstResponder()
        } else if textField == txtPassword {
            _ = txtConfirmPassword?.becomeFirstResponder()
        } else if textField == txtConfirmPassword {
            _ = txtConfirmPassword?.resignFirstResponder()
        }
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtCountryPhoneCode {
            self.openCountryCodePicker()
            return false
        }
        return true
    }
    
}
// MARK: - Web API Methods
extension RegisterVC {
    
    func wsRegister() {
        Loader.showLoading()
        var request: User.RequestRegister = User.RequestRegister()
        request.email = txtEmail.text?.trim() ?? ""
        request.password = txtPassword.text!
        request.name = (txtName.text?.trim())!
        request.tel_number_code = (txtCountryPhoneCode.text?.trim())!
        request.tel_number = (txtMobileNumber.text?.trim())!
        request.referral_code = (txtReferralCode.text?.trim())!
        AppWebApi.register(params: request) { (response) in
            self.btnSignUp?.isEnabled = true
            let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
            if ResponseModel.isSuccess(response: model, withSuccessToast: true, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                appSingleton.user = user
                Singleton.saveInDb()
                self.openRegisterFingerPrintDialog()
            }
            Loader.hideLoading()
        }
    }
    
    func checkValidation() -> Bool {
        if !txtName.validate().isValid {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: txtName.validate().message)
            alert.show(animated: true)
            alert.onBtnCancelTapped = { [weak alert, weak self] in
                alert?.dismiss()
                guard let self = self else { return } ; print(self)
                _ = self.txtName.becomeFirstResponder()
            }
            return false
        }
        else if !txtEmail.validate().isValid{
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: txtEmail.validate().message)
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtEmail.becomeFirstResponder()
            }
            return false
        }
        else if !txtMobileNumber.validate().isValid {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: txtMobileNumber.validate().message)
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtMobileNumber.becomeFirstResponder()
            }
            return false
        }
        else if !txtPassword.validate().isValid {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: txtPassword.validate().message)
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                guard let self = self else { return } ; print(self)
                alert?.dismiss()
                _ = self.txtPassword.becomeFirstResponder()
            }
            return false
        } else if txtPassword.text! != txtConfirmPassword.text! {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_MISMATCH_CONFIRM_PASSWORD".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                guard let self = self else { return } ; print(self)
                alert?.dismiss()
                _ = self.txtConfirmPassword.becomeFirstResponder()
            }
            return false
        } else if !btnCheckBox.isSelected {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_SELECT_TERMS_AND_CONDITION".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                guard let self = self else { return } ; print(self)
                alert?.dismiss()
            }
            return false
        }
        return true
    }
    
}

extension RegisterVC {
    
    func openRegisterFingerPrintDialog() {
        let alertFingerPrint: FingerPrintDialog = FingerPrintDialog.fromNib()
        alertFingerPrint.initialize(title: "FINGER_PRINT_DIALOG_REGISTER_TITLE".localized(), buttonTitle: "BTN_YES_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        alertFingerPrint.show(animated: true)
        alertFingerPrint.onBtnCancelTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            Common.appDelegate.loadMainVC()
        }
        alertFingerPrint.onBtnDoneTapped = {
            [weak alertFingerPrint, weak self] in
            guard let self = self else {return}; print(self)
            alertFingerPrint?.dismiss();
            CoreDataManager.sharedManager.create(username: self.txtEmail.text!, password: self.txtPassword.text!)
            Common.appDelegate.loadMainVC()
        }
    }
    
    func openCountryCodePicker() {
        let alert: CustomCountryPhoneCodePicker = CustomCountryPhoneCodePicker.fromNib()
        alert.initialize(title: "COUNTRY_PHONE_CODE_TITLE".localized(),buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (countryPhoneCode:  CountryPhone) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.txtCountryPhoneCode.text = countryPhoneCode.countryPhoneCode
        }
    }
    
    func openTermsAndConditonPicker() {
        let alert: CustomInformationDialog = CustomInformationDialog.fromNib()
        alert.initialize(title: SettingMenu.TermsAndCondition.name(), data: "", buttonTitle: "".localized(), cancelButtonTitle: "".localized())
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
}
