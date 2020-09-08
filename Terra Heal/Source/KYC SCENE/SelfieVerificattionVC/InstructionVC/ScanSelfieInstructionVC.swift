//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class ScanSelfieInstructionVC: MainVC {



    @IBOutlet weak var btnScanNow: FilledRoundedButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet var vwBg: UIView!

    @IBOutlet weak var btnInfo1: ThemeButton!
    @IBOutlet weak var lblInfo1Title: ThemeLabel!
    @IBOutlet weak var lblInfo1Detail: ThemeLabel!

    @IBOutlet weak var btnInfo2: ThemeButton!
    @IBOutlet weak var lblInfo2Title: ThemeLabel!
    @IBOutlet weak var lblInfo2Detail: ThemeLabel!

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
         self.btnScanNow?.setupFilledButton()
         self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
        self.btnInfo1?.setRound()
        self.btnInfo2?.setRound()

    }

    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.lblHeader?.text = "SELFIE_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)

        self.lblMessage?.text = "SELFIE_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)

        self.btnScanNow?.setTitle("SELFIE_BTN_OPEN_CAMERA".localized(), for: .normal)
        self.btnScanNow?.setFont(name: FontName.Regular, size: FontSize.button_18)

        self.lblInfo1Title?.text = "SELFIE_LBL_INFO_1_TITLE".localized()
        self.lblInfo1Title?.setFont(name: FontName.SemiBold, size: FontSize.label_18)

        self.lblInfo1Detail?.text = "SELFIE_LBL_INFO_1_MESSAGE".localized()
        self.lblInfo1Detail?.setFont(name: FontName.Regular, size: FontSize.label_12)

        self.lblInfo2Title?.text = "SELFIE_LBL_INFO_2_TITLE".localized()
        self.lblInfo2Title?.setFont(name: FontName.SemiBold, size: FontSize.label_18)

        self.lblInfo2Detail?.text = "SELFIE_LBL_INFO_2_MESSAGE".localized()
        self.lblInfo2Detail?.setFont(name: FontName.Regular, size: FontSize.label_12)

    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnScanTapped(_ sender: Any) {
        Common.appDelegate.loadScanSelfieVC(navigaionVC: self.navigationController)
    }


}

