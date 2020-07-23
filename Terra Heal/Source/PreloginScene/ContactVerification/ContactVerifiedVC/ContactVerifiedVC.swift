//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class ContactVerifiedVC: MainVC {


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
       // self.vwBg?.setRound()
        }
    }

    private func initialViewSetup() {
        
        self.lblHeader?.text = "CONTACT_VERIFIED_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblMessage?.text = "CONTACT_VERIFIED_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.btnHome?.setTitle("CONTACT_VERIFICATION_BTN_HOME".localized(), for: .normal)
        self.btnHome?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnHome?.setHighlighted(isHighlighted: false)
       // self.vwBg?.setRound()
    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
         _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnHomeTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }
}

