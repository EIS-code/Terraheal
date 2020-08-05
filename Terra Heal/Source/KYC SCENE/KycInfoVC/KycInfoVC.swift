//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class KycInfoVC: MainVC {



    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var btnDone: FloatingRoundButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!

    @IBOutlet var btnScanPassport: ThemeButton!
    @IBOutlet var lblScanPassport: ThemeLabel!
    // MARK: Object lifecycle
    @IBOutlet var btnTakeSelfie: ThemeButton!
    @IBOutlet var lblTakeSelfie: ThemeLabel!

    @IBOutlet var btnAddCreditCard: ThemeButton!
    @IBOutlet var lblAddCreditCard: ThemeLabel!

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
        
        self.btnScanPassport?.setRound()
        self.btnTakeSelfie?.setRound()
        self.btnAddCreditCard?.setRound()
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }

    private func initialViewSetup() {
        

        self.lblHeader?.text = "KYC_INFO_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.Bold, size: FontSize.label_26)

        self.lblMessage?.text = "KYC_INFO_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)

        self.lblScanPassport?.text = "KYC_INFO_LBL_SCAN_PASSPORT".localized()
        self.lblScanPassport?.setFont(name:  FontName.SemiBold, size: FontSize.label_22)

        self.lblTakeSelfie?.text = "KYC_INFO_LBL_TAKE_SELFIE".localized()
        self.lblTakeSelfie?.setFont(name:  FontName.SemiBold, size: FontSize.label_22)

        self.lblAddCreditCard?.text = "KYC_INFO_LBL_ADD_CREDIT_CARD".localized()
        self.lblAddCreditCard?.setFont(name:  FontName.SemiBold, size: FontSize.label_22)


        self.btnDone?.setForwardButton()
        self.btnNext?.setTitle("BTN_YES_PROCEED".localized(), for: .normal)
        self.btnNext?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        Common.appDelegate.loadScanPassportInstructionVC(navigaionVC: self.navigationController)
    }

    @IBAction func btnScanPassportTapped(_ sender: Any) {
         Common.appDelegate.loadScanPassportInstructionVC(navigaionVC: self.navigationController)
    }
    
    @IBAction func btnTakeSelfieTapped(_ sender: Any) {
        Common.appDelegate.loadScanSelfieInstructionVC(navigaionVC: self.navigationController)
    }
    @IBAction func btnAddCardTapped(_ sender: Any) {
        Common.appDelegate.loadAddCardVC(navigaionVC: self.navigationController)
    }
    
}

