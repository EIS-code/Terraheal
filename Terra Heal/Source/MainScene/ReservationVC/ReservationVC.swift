//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class ReservationVC: MainVC {
    
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblMessage: ThemeLabel!
    @IBOutlet var vwBg: UIView!
    
    @IBOutlet weak var btnProceedDone: DialogFloatingProceedButton!
    @IBOutlet weak var btnProceed: ThemeButton!
    
    @IBOutlet weak var btnProceed2: ThemeButton!
    @IBOutlet weak var btnProceed2Done: DialogFloatingProceedButton!
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
        self.lblHeader?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblMessage?.text = "RESERVATION_MESSAGE".localized()
        self.lblMessage?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.btnProceed?.setTitle("BTN_PROCEED".localized(), for: .normal)
        self.btnProceed?.setFont(name: FontName.SemiBold, size: FontSize.button_21)
        self.btnProceed2?.setTitle("RESERVATION_BTN_PROCEED2".localized(), for: .normal)
        self.btnProceed2.titleLabel?.numberOfLines = 0
        self.btnBack.setFont(name: FontName.Bold, size: FontSize.button_21)
        self.btnBack.setTitle("BTN_CANCEL".localized(), for: .normal)
        self.btnProceed2?.setFont(name: FontName.SemiBold, size: FontSize.button_21)
    }
  
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnProceedDoneTapped(_ sender: Any) {
        Common.appDelegate.loadKycInfoVC(navigaionVC: self.navigationController)
    }
    
    @IBAction func btnProceed2DoneTapped(_ sender: Any) {
        Common.appDelegate.loadCompleteVC(data: CompletionData.init(strHeader: "REQUEST_BOOKING_COMPLETE_TITLE".localized(), strMessage: "REQUEST_BOOKING_COMPLETE_MESSAGE".localized(), strImg: ImageAsset.Completion.bookingCompletion, strButtonTitle: "REQUEST_BOOKING_COMPLETE_BTN_HOME".localized()))
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.openCancelBookingDialog()
    }
    
    func openCancelBookingDialog() {
           let cancelBookingDialog: CustomAlertConfirmation  = CustomAlertConfirmation.fromNib()
           cancelBookingDialog.initialize(title: "cancel", message: "are you sure you want to cancel it?", buttonTitle: "yes cancel".localized(),cancelButtonTitle: "BTN_BACK".localized())
           cancelBookingDialog.show(animated: true)
           cancelBookingDialog.onBtnCancelTapped = {
               [weak cancelBookingDialog, weak self] in
               guard let self = self else { return } ; print(self)
               cancelBookingDialog?.dismiss()
               self.btnBack.isEnabled = true
           }
           cancelBookingDialog.onBtnDoneTapped = {
               [weak cancelBookingDialog, weak self]  in
               guard let self = self else { return } ; print(self)
               cancelBookingDialog?.dismiss()
               Common.appDelegate.loadHomeVC()
           }
       }
    
}


