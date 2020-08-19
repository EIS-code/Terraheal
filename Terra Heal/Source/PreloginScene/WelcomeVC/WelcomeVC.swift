//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class WelcomeVC: MainVC {


    @IBOutlet weak var lblHeader1: ThemeLabel!
    @IBOutlet weak var lblMsg1: ThemeLabel!
    @IBOutlet weak var lblHeader2: ThemeLabel!
    @IBOutlet weak var lblMsg2: ThemeLabel!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var btnSignUp: ThemeButton!
    @IBOutlet weak var btnHome: ThemeButton!
    @IBOutlet weak var iv1: UIImageView!
    @IBOutlet weak var btnSignIn: ThemeButton!
    
    @IBOutlet weak var iv2: UIImageView!
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

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.view.layoutIfNeeded()
            self.btnSignUp?.setupFilledButton()
            self.btnSignIn?.setupFilledButton()
            self.btnHome?.setupBorderedButton()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.lblHeader1?.text = "WELCOME_LBL_HEADER_1".localized()
        self.lblHeader1?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblMsg1?.text = "WELCOME_LBL_MESSAGE_1".localized()
        self.lblMsg1?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblHeader2?.text = "WELCOME_LBL_HEADER_2".localized()
        self.lblHeader2?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblMsg2?.text = "WELCOME_LBL_MESSAGE_2".localized()
        self.lblMsg2?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.btnSignUp.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSignUp.setTitle("WELCOME_BTN_SIGN_UP".localized(), for: .normal)
        self.btnSignIn.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSignIn.setTitle("WELCOME_BTN_SIGN_IN".localized(), for: .normal)
        self.btnHome.setTitle("WELCOME_BTN_HOME".localized(), for: .normal)
        self.btnHome.setFont(name: FontName.SemiBold, size: FontSize.button_14)
    }


    // MARK: Action Buttons
    @IBAction func btnSignupTapped(_ sender: Any) {
        Common.appDelegate.loadRegisterVC()
    }
    @IBAction func btnHomeTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }
    @IBAction func btnSignInTapped(_ sender: Any) {
           Common.appDelegate.loadLoginVC()
    }

    // MARK: Other Functions

}

