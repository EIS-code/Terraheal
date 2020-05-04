//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class LoginVC: MainVC {

    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var vwContent: UIView!
    @IBOutlet weak var hVwContent: NSLayoutConstraint!


    @IBOutlet weak var lblLoginTitle: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    

    @IBOutlet weak var txtEmail: ACFloatingTextfield!
    @IBOutlet weak var txtPassword: ACFloatingTextfield!
    @IBOutlet weak var btnForgotPassword: UnderlineTextButton!
    @IBOutlet weak var btnLogin: ThemeButton!
    @IBOutlet weak var btnSignUp: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!


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
        btnDone.setUpRoundedButton()
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblLoginTitle?.text = "LOGIN_LBL_TITLE".localized()
        self.lblLoginTitle?.font = FontHelper.font(name: FontName.GradDuke, size: FontSize.label_26)
        self.lblMessage?.text = "LOGIN_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Ovo, size: FontSize.label_18)
        self.txtEmail?.placeholder = "LOGIN_TXT_EMAIL".localized()
        self.txtPassword?.placeholder = "LOGIN_TXT_PASSWORD".localized()
        self.btnForgotPassword?.setTitle("LOGIN_BTN_FORGOT_PASSWORD".localized(), for: .normal)
        self.btnForgotPassword?.setFont(name: FontName.GradDuke, size: FontSize.button_20)
        self.btnSignUp?.setTitle("LOGIN_BTN_SIGN_UP".localized(), for: .normal)
        self.btnSignUp?.setFont(name: FontName.GradDuke, size: FontSize.button_18)
        self.btnLogin?.setTitle("LOGIN_BTN_SIGN_IN".localized(), for: .normal)
        self.btnLogin?.setFont(name: FontName.GradDuke, size: FontSize.button_22)
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

    @IBAction func btnForgotPasswordTapped(_ sender: UIButton) {
        if checkValidation() {
            self.wsLogin()
        }
    }

}

// MARK: - Web API Methods
extension LoginVC {

    private func wsLogin() {

    }

    func checkValidation() -> Bool {

        if !txtEmail.text!.isValidEmail()  {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "Please enter valid email address")
            alert.show(animated: false)
            return false
        } else if txtPassword.text!.isEmpty {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "Please enter valid email address")
            alert.show(animated: false)

            return false
        }
        return true
    }

}
