//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class VerifyContactVC: MainVC {


    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var btnHome: ThemeButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet var vwBg: UIView!
    var alertForVerification: VerificationAlert!
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
        //self.btnHome?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        
    }

    private func initialViewSetup() {

        self.lblHeader?.text = "CONTACT_VERIFICATION_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.Bold, size: FontSize.label_36)
        self.lblMessage?.text = "CONTACT_VERIFICATION_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)
        self.btnHome?.setTitle("CONTACT_VERIFICATION_BTN_VERIFY".localized(), for: .normal)
        self.btnHome?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnHome.setHighlighted(isHighlighted: true)
        self.btnBack.setBackButton()

    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
         _ = (self.navigationController as? NC)?.popVC()
    }
    @IBAction func btnBackTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }

    @IBAction func btnHomeTapped(_ sender: Any) {
        //self.openVerification()
         Common.appDelegate.loadVerifiedContactVC()
       // Common.appDelegate.loadCompleteVC(data: CompletionData.init(strHeader: "CONTACT_VERIFIED_LBL_TITLE".localized(), strMessage: "CONTACT_VERIFIED_LBL_MESSAGE".localized(), strImg: ImageAsset.Completion.contactVarification, strButtonTitle: "CONTACT_VERIFICATION_BTN_HOME".localized()))

    }


    func openVerification() {
        alertForVerification = VerificationAlert.fromNib()
        alertForVerification.initialize(message: "VERIFICATION_EMAIL_TITLE".localized(), data: Singleton.shared.user.email)
        alertForVerification.setVerificationFor(type: .Phone)
        alertForVerification.show(animated: true)
        alertForVerification.onBtnDoneTapped = { [weak alertForVerification, weak self] (code:String) in
            guard let self = self else { return } ; print(self)
            alertForVerification?.dismiss()
            Common.appDelegate.loadVerifiedContactVC()
        }

        alertForVerification.onBtnResendTapped = { [weak self] in
            guard let self = self else { return } ; print(self)

        }
        alertForVerification.onBtnCancelTapped = { [weak alertForVerification,  weak self] in
            guard let self = self else { return } ; print(self)
            alertForVerification?.dismiss()
        }
    }
}



