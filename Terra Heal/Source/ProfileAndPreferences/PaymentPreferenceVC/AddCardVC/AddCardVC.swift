//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class AddCardVC: MainVC {
    
    
    @IBOutlet weak var lblTitleMessage: ThemeLabel!
    @IBOutlet weak var btnAddCard: ThemeButton!
    @IBOutlet weak var lblNameOfCard: ThemeLabel!
    @IBOutlet weak var txtCardName: ACFloatingTextfield!
    @IBOutlet weak var lblCardNumber: ThemeLabel!
    @IBOutlet weak var txtCardNumber: ACFloatingTextfield!
    @IBOutlet weak var lblExpiryDate: ThemeLabel!
    @IBOutlet weak var txtExpiryDate: ACFloatingTextfield!
    @IBOutlet weak var lblNickNameOfCard: ThemeLabel!
    @IBOutlet weak var btnPersonal: ThemeButton!
    @IBOutlet weak var btnBusiness: ThemeButton!
    @IBOutlet weak var btnOther: ThemeButton!
    @IBOutlet weak var lblAccept: ThemeLabel!
    @IBOutlet weak var btnCheckBox: ThemeButton!
    @IBOutlet weak var lblSaveDetailMsg: ThemeLabel!
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
        if self.isViewAvailable() {
            self.btnAddCard.setHighlighted(isHighlighted: true)
            self.btnCheckBox.setHighlighted(isHighlighted: true)
            self.btnPersonal.setRound(withBorderColor: .themePrimary, andCornerRadious: 5.0, borderWidth: 1.0)
            self.btnBusiness.setRound(withBorderColor: .themePrimary, andCornerRadious: 5.0, borderWidth: 1.0)
            self.btnOther.setRound(withBorderColor: .themePrimary, andCornerRadious: 5.0, borderWidth: 1.0)
        }
    }
    
    private func initialViewSetup() {
        
        
        self.btnAddCard?.setTitle("ADD_CARD_BTN_ADD_CARD".localized(), for: .normal)
        self.btnAddCard?.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        
        self.lblTitle?.text = "ADD_CARD_TITLE".localized()
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_22)
        
        self.lblTitleMessage?.text = "ADD_CARD_TITLE_MESSAGE".localized()
        self.lblTitleMessage?.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        
        self.lblCardNumber?.text = "ADD_CARD_LBL_CARD_NUMBER".localized()
        self.lblCardNumber?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        
        self.lblExpiryDate?.text = "ADD_CARD_LBL_EXPIRY".localized()
        self.lblExpiryDate?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        
        self.lblNameOfCard?.text = "ADD_CARD_LBL_NAME_OF_CARD".localized()
        self.lblNameOfCard?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        
        self.lblNickNameOfCard?.text = "ADD_CARD_LBL_CARD_NICK_NAME".localized()
        self.lblNickNameOfCard?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        
        
        
        
        self.btnOther.setTitle("ADD_CARD_TYPE_OTHER".localized(), for: .normal)
        self.btnOther.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        
        self.btnPersonal.setTitle("ADD_CARD_TYPE_PERSONAL".localized(), for: .normal)
        self.btnPersonal.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        
        self.btnBusiness.setTitle("ADD_CARD_TYPE_BUSINESS".localized(), for: .normal)
        self.btnBusiness.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        
        self.txtCardName?.placeholder = "ADD_CARD_TXT_NAME".localized()
        self.txtCardName?.delegate = self
        self.txtCardName?.disableFloatingLabel = true
        
        self.txtCardNumber?.placeholder = "ADD_CARD_TXT_CARD_NUMBER".localized()
        self.txtCardNumber?.delegate = self
        self.txtCardNumber?.disableFloatingLabel = true
        
        self.txtExpiryDate?.placeholder = "ADD_CARD_TXT_EXPIRY".localized()
        self.txtExpiryDate?.delegate = self
        self.txtExpiryDate?.disableFloatingLabel = true
        
        self.btnAddCard?.setTitle("ADD_CARD_BTN_ADD_CARD".localized(), for: .normal)
        self.btnAddCard?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        
       
        
        self.lblAccept?.text = "ADD_CARD_SAVE_CARD_DETAILS".localized()
        self.lblAccept?.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        
        self.lblSaveDetailMsg?.text = "ADD_CARD_SAVE_CARD_DETAIL_MESSAGE".localized()
        self.lblSaveDetailMsg?.setFont(name: FontName.Regular, size: FontSize.label_14)
    }
    
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnCheckBoxTapped(_ sender: Any) {
        self.btnCheckBox.isSelected.toggle()
        self.btnCheckBox.setHighlighted(isHighlighted: self.btnCheckBox.isSelected)
    }

    @IBAction func btnAddCardTapped(_ sender: Any) {
    
    }
    func openMonthYearDialog() {
        
       let monthYearPicker: MonthYearDialog = MonthYearDialog.fromNib()
        monthYearPicker.initialize(title: "DATE_DIALOG_LBL_SELECT_TIME".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        monthYearPicker.show(animated: true)
        monthYearPicker.onBtnCancelTapped = {
            [weak monthYearPicker, weak self] in
            guard let self = self else { return } ; print(self)
            monthYearPicker?.dismiss()
        }
        monthYearPicker.onBtnDoneTapped = {
            [weak monthYearPicker, weak self] (month,year) in
            guard let self = self else { return } ; print(self)
            monthYearPicker?.dismiss()
            self.txtExpiryDate.text = month.toString() + "/" + year.toString()
        }
    }
    
}



extension AddCardVC : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtExpiryDate {
            self.openMonthYearDialog()
            return false
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) else { return true }
        if textField == txtCardNumber {
            txtCardNumber.text = currentText.grouping(every: 4, with: " ")
        }
        if textField == txtExpiryDate {
            txtExpiryDate.text = currentText.grouping(every: 2, with: "/")
        }
        
        
        return true
    }
    
}
