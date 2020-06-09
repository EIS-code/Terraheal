//
//  Created by Jaydeep VyasUnderlineTextButton
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import LocalAuthentication


class LoginVC: MainVC {

    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var vwContent: UIView!



    @IBOutlet weak var lblLoginTitle: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    

    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var btnForgotPassword: ThemeButton!
    @IBOutlet weak var btnLogin: ThemeButton!
    @IBOutlet weak var btnSignUp: ThemeButton!
    @IBOutlet weak var imgChecked: UIImageView!
    @IBOutlet weak var vwDashed: UIView!
    @IBOutlet weak var lblConnect: ThemeLabel!
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
            self.vwDashed?.createDashedLine(from: CGPoint(x: vwDashed.bounds.minX, y: vwDashed.bounds.midY), to: CGPoint(x: vwDashed.bounds.maxX, y: vwDashed.bounds.midY), color: UIColor.themePrimary, strokeLength: 10, gapLength: 10, width: 2.0)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        _ = self.txtEmail?.becomeFirstResponder()
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblLoginTitle?.text = "LOGIN_LBL_TITLE".localized()
        self.lblLoginTitle?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
        self.lblMessage?.text = "LOGIN_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)
        self.txtEmail?.placeholder = "LOGIN_TXT_EMAIL".localized()
        self.txtEmail?.delegate = self
        self.txtPassword?.placeholder = "LOGIN_TXT_PASSWORD".localized()
        self.txtPassword?.delegate = self
        self.btnForgotPassword?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnForgotPassword?.setTitle("LOGIN_BTN_FORGOT_PASSWORD".localized(), for: .normal)
        self.btnSignUp?.setTitle("LOGIN_BTN_SIGN_UP".localized(), for: .normal)
        self.btnSignUp?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnLogin?.setTitle("LOGIN_BTN_SIGN_IN".localized(), for: .normal)
        self.btnLogin?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnLogin.setHighlighted(isHighlighted: true)
        self.imgChecked?.isHidden = true
        self.txtPassword.setupPasswordTextFielad()

        self.lblConnect?.text = "LOGIN_LBL_CONNECT_VIA".localized()
        self.lblConnect?.setFont(name: FontName.SemiBold, size: FontSize.label_22)
    }


    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        if checkValidation() {
            self.wsLogin()
        }
    }
    @IBAction func btnSignUpTapped(_ sender: Any) {
        Common.appDelegate.loadRegisterVC()//(navigaionVC: self.navigationController)
    }

    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        Common.appDelegate.loadTouchIdVC(navigaionVC: self.navigationController)
    }

    @IBAction func btnFingerPrintTapped(_ sender: UIButton) {
        authenticateUser(self)
    }

}

extension LoginVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtEmail {
            _ = txtPassword?.becomeFirstResponder()
        } else if textField == txtPassword {
            _ = txtPassword?.resignFirstResponder()
        }
        return true
    }
}
// MARK: - Web API Methods
extension LoginVC {

    func wsLogin() {
        Loader.showLoading()
        var request: User.RequestLogin = User.RequestLogin()
        request.email = txtEmail.text?.trim() ?? ""
        request.password = txtPassword.text!
        AppWebApi.login(params: request) { (response) in
            let model: ResponseModel = ResponseModel.init(fromDictionary: response.toDictionary())
            Loader.hideLoading()
            self.btnLogin?.isEnabled = true
            if ResponseModel.isSuccess(response: model, withSuccessToast: false, andErrorToast: true) {
                let user = response.data
                PreferenceHelper.shared.setUserId(user.id)
                //PreferenceHelper.shared.setSessionToken(user.token)
                appSingleton.user = user
                Singleton.saveInDb()
                if appSingleton.user.isContactVerified() {
                    Common.appDelegate.loadHomeVC()
                } else {
                    Common.appDelegate.loadContactVerificationVC()
                }

            }
        }
    }

    func checkValidation() -> Bool {

        if !txtEmail.text!.isValidEmail() {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_EMAIL".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss();
                _ = self?.txtEmail.becomeFirstResponder()
            }
            return false
        }
        else if txtPassword.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_INVALID_PASSWORD".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                alert?.dismiss()
                _ = self?.txtPassword.becomeFirstResponder()
            }
            return false
        }
        return true
    }

}

// MARK: - Touch API Methods
extension LoginVC {


    func authenticateUser(_ sender: Any) {

        let context = LAContext()

        var error: NSError?

        if context.canEvaluatePolicy(
            LAPolicy.deviceOwnerAuthenticationWithBiometrics,
            error: &error) {

            // Device can use biometric authentication
            context.evaluatePolicy(
                LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                localizedReason: "Access requires authentication",
                reply: {(success, error) in
                    DispatchQueue.main.async {

                        if let err = error {

                            switch err._code {

                            case LAError.Code.systemCancel.rawValue:
                                self.notifyUser("Session cancelled",
                                                err: err.localizedDescription)

                            case LAError.Code.userCancel.rawValue:
                                self.notifyUser("Please try again",
                                                err: err.localizedDescription)

                            case LAError.Code.userFallback.rawValue:
                                self.notifyUser("Authentication",
                                                err: "Password option selected")
                                // Custom code to obtain password here

                            default:
                                self.notifyUser("Authentication failed",
                                                err: err.localizedDescription)
                            }

                        } else {
                            self.imgChecked?.isHidden = false
                        }
                    }
            })

        } else {
            // Device cannot use biometric authentication
            if let err = error {
                switch err.code {

                case LAError.Code.biometryNotEnrolled.rawValue:
                    notifyUser("User is not enrolled",
                               err: err.localizedDescription)

                case LAError.Code.passcodeNotSet.rawValue:
                    notifyUser("A passcode has not been set",
                               err: err.localizedDescription)


                case LAError.Code.biometryNotAvailable.rawValue:
                    notifyUser("Biometric authentication not available",
                               err: err.localizedDescription)
                default:
                    notifyUser("Unknown error",
                               err: err.localizedDescription)
                }
            }
        }
    }


    func notifyUser(_ msg: String, err: String?) {

        let alert: CustomAlert = CustomAlert.fromNib()
        alert.initialize(message: msg.localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
    }
}
