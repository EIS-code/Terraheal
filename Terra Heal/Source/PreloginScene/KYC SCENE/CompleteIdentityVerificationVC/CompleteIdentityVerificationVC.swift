//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class CompleteIdentityVerificationVC: MainVC {


    @IBOutlet weak var btnHome: ThemeButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet var vwBg: UIView!

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
            self.btnHome?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
            self.vwBg?.setRound()
        }
    }

    private func initialViewSetup() {
        
        self.lblHeader?.text = "COMPLETE_VERIFICATION_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
        self.lblMessage?.text = "COMPLETE_VERIFICATION_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)
        self.btnHome?.setTitle("COMPLETE_VERIFICATION_BTN_HOME".localized(), for: .normal)
        self.btnHome?.setFont(name: FontName.Regular, size: FontSize.button_18)
    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnHomeTapped(_ sender: Any) {
        Common.appDelegate.loadWelcomeVC()
    }
}

