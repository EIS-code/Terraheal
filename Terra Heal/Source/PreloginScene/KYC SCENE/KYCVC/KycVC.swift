//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class KycVC: MainVC {



    @IBOutlet weak var btnSkip: UnderlineTextButton!
    @IBOutlet weak var btnNext: ThemeButton!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!

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
        self.btnDone?.setUpRoundedButton()
    }

    private func initialViewSetup() {
        
        self.btnSkip?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnSkip?.setTitle("KYC_BTN_SKIP".localized(), for: .normal)
        self.btnNext?.setTitle("KYC_BTN_PROCEED".localized(), for: .normal)
        self.btnNext?.setFont(name: FontName.SemiBold, size: FontSize.button_22)



        self.lblHeader?.text = "KYC_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)

        self.lblMessage?.text = "KYC_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)

    }

    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSkipTapped(_ sender: Any) {
        Common.appDelegate.loadWelcomeVC()
    }

    @IBAction func btnNextTapped(_ sender: Any) {
        Common.appDelegate.loadKycInfoVC()
    }


}

