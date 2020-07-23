//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class ReservationVC: MainVC {
    
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet var vwBg: UIView!
    
    @IBOutlet weak var btnProceedDone: FloatingRoundButton!
    @IBOutlet weak var btnProceed: ThemeButton!
    
    @IBOutlet weak var btnProceed2: ThemeButton!
    @IBOutlet weak var btnProceed2Done: FloatingRoundButton!
    @IBOutlet weak var btnBack: UnderlineTextButton!
    
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
            self.vwBg?.setRound()
        }
    }
    
    private func initialViewSetup() {
        self.lblHeader?.text = "RESERVATION_TITLE".localized()
        self.lblHeader?.setFont(name: FontName.SemiBold, size: FontSize.label_26)
        self.lblMessage?.text = "RESERVATION_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.label_18)
        self.btnProceed?.setTitle("BTN_PROCEED".localized(), for: .normal)
        self.btnProceed?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.btnProceed2?.setTitle("RESERVATION_BTN_PROCEED2".localized(), for: .normal)
        self.btnProceed2.titleLabel?.numberOfLines = 0
        self.btnBack.setFont(name: FontName.Bold, size: FontSize.button_22)
        self.btnBack.setTitle("BTN_BACK".localized(), for: .normal)
        self.btnProceedDone.setForwardButton()
        self.btnProceed2Done.setForwardButton()
        self.btnProceed2?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
    }
  
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnProceedDoneTapped(_ sender: Any) {
    }
    
    @IBAction func btnProceed2DoneTapped(_ sender: Any) {
    }
    
}


