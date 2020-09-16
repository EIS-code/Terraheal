//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class ScanPassportInstructionVC: BaseVC {
    
    
    
    @IBOutlet weak var btnScanNow: FilledRoundedButton!
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
        self.vwBg?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.lblHeader?.text = "SCAN_PASSPORT_LBL_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblMessage?.text = "SCAN_PASSPORT_LBL_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.btnScanNow?.setTitle("SCAN_PASSPORT_BTN_SCAN_NOW".localized(), for: .normal)
    }
    
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnScanTapped(_ sender: Any) {
        Common.appDelegate.loadScanPassportVC(navigaionVC: self.navigationController)
    }
}

