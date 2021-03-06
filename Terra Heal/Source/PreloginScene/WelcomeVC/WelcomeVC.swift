//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class WelcomeVC: BaseVC {


    @IBOutlet weak var lblHeader1: ThemeLabel!
    @IBOutlet weak var lblMsg1: ThemeLabel!
    @IBOutlet weak var lblHeader2: ThemeLabel!
    @IBOutlet weak var lblMsg2: ThemeLabel!
    @IBOutlet weak var vw2: UIView!
    @IBOutlet weak var vw1: UIView!
    @IBOutlet weak var btnSignUp: FilledRoundedButton!
    @IBOutlet weak var btnHome: RoundedBorderButton!
    @IBOutlet weak var iv1: UIImageView!
    @IBOutlet weak var btnSignIn: FilledRoundedButton!
    
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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       /* let point = CGPoint.init(x: 0, y: self.getTopInset())
        self.mainScrollView.setContentOffset(point, animated: true)*/
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.view.layoutIfNeeded()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.lblHeader1?.text = "WELCOME_LBL_HEADER_1".localized()
        self.lblHeader1?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblMsg1?.text = "WELCOME_LBL_MESSAGE_1".localized()
        self.lblMsg1?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblHeader2?.text = "WELCOME_LBL_HEADER_2".localized()
        self.lblHeader2?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblMsg2?.text = "WELCOME_LBL_MESSAGE_2".localized()
        self.lblMsg2?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.btnSignUp.setTitle("WELCOME_BTN_SIGN_UP".localized(), for: .normal)
        self.btnSignIn.setTitle("WELCOME_BTN_SIGN_IN".localized(), for: .normal)
        self.btnHome.setTitle("WELCOME_BTN_HOME".localized(), for: .normal)
    }


    // MARK: Action Buttons
    @IBAction func btnSignupTapped(_ sender: Any) {
        Common.appDelegate.loadRegisterVC()
    }
    @IBAction func btnHomeTapped(_ sender: Any) {
        Common.appDelegate.loadMainVC()
    }
    @IBAction func btnSignInTapped(_ sender: Any) {
           Common.appDelegate.loadLoginVC()
    }

    // MARK: Other Functions

}

