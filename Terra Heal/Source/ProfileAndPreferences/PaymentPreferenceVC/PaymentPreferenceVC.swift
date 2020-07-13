//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct CreditCardDetail {
    var id: String  = ""
    var name: String  = ""
    var value: String = ""
    var isSeleced: Bool  = false
}


class PaymentPreferenceVC: MainVC {
    
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: ThemeButton!
    @IBOutlet weak var vwPaypalDetail: UIView!
    @IBOutlet weak var ivPaypal: UIImageView!
    @IBOutlet weak var lblPaypal: ThemeLabel!
    @IBOutlet weak var lblPaypalEmailId: ThemeLabel!
    @IBOutlet weak var btnDefault: ThemeButton!
    @IBOutlet weak var btnExpandPaypal: UIButton!
    @IBOutlet weak var vwCreditCardDetail: UIView!
    @IBOutlet weak var ivCreditCard: UIImageView!
    @IBOutlet weak var lblCreditCard: ThemeLabel!
    @IBOutlet weak var lblCreditCardValue: ThemeLabel!
    @IBOutlet weak var btnExpandCreditCard: ThemeButton!
    
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    var arrForData: [CreditCardDetail] = [CreditCardDetail.init(id: "1", name: "personal", value: "254xxxxxxxxx324841", isSeleced: false),CreditCardDetail.init(id: "2", name: "business", value: "254xxxxxxxxx324841", isSeleced: true)]
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.ivPaypal?.layoutIfNeeded()
            self.ivPaypal?.setRound()
            self.ivCreditCard?.layoutIfNeeded()
            self.ivCreditCard?.setRound()
            self.vwPaypalDetail?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
            self.vwCreditCardDetail?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
            self.btnDefault.setRound(withBorderColor: .themePrimary, andCornerRadious: 5.0, borderWidth: 1.0)
            self.reloadTableDataToFitHeight(tableView: self.tableView, height: self.hTblVw)
            self.btnSubmit?.setHighlighted(isHighlighted: true)
        }
    }
    
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "PAYMENT_PREFERENCE_TITLE".localized())
        self.lblPaypal.text = "PAYMENT_LBL_PAYPAL".localized()
        self.lblPaypal.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblPaypalEmailId.text = "PAYMENT_PAYPAL_EMAIL_ID".localized()
        self.lblPaypalEmailId.setFont(name: FontName.Regular, size: FontSize.label_18)
        self.lblCreditCard.text = "PAYMENT_LBL_CARDS".localized()
        self.lblCreditCard.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblCreditCardValue.text = "XXXX-XXXX-XXXX-5555".localized()
        self.lblCreditCardValue.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.btnDefault?.setTitle("PAYMENT_LBL_DEFAULT".localized(), for: .normal)
        self.btnDefault?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setTitle("PAYMENT_BTN_ADD_NEW".localized(), for: .normal)
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setHighlighted(isHighlighted: true)
        self.setupTableView(tableView: self.tableView)
        self.btnBack.setBackButton()
    }
    
    
    @IBAction func onBtnExpandCreditCardDetailTapped(_ sender: Any) {
        if btnExpandCreditCard.isSelected {
            tableView.gone()
        } else {
            tableView.visible()
        }
        self.reloadTableDataToFitHeight(tableView: tableView, height: hTblVw)
        btnExpandCreditCard.isSelected.toggle()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.openAddPaymentDialog()
    }
    func openAddPaymentDialog() {
           let addPercentageDialog: AddPaymentPreferenceDialog  = AddPaymentPreferenceDialog.fromNib()
           addPercentageDialog.initialize(title: "Add New", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
           addPercentageDialog.show(animated: true)
           addPercentageDialog.onBtnCancelTapped = {
               [weak addPercentageDialog, weak self] in
               guard let self = self else { return } ; print(self)
               addPercentageDialog?.dismiss()
           }
           addPercentageDialog.onBtnDoneTapped = {
               [weak addPercentageDialog, weak self]  (button) in
               guard let self = self else { return } ; print(self)
            addPercentageDialog?.dismiss()
                if button.id == 1  {
                    self.openTextFieldPicker()
                }
               
           }
       }
      
    func openTextFieldPicker() {
           let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
           alert.initialize(title: "paypal email", data: "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
           alert.show(animated: true)
        alert.configTextField(data: InputTextFieldDetail.getEmailConfiguration())
           alert.onBtnCancelTapped = {
               [weak alert, weak self] in
               guard let self = self else { return } ; print(self)
               alert?.dismiss()
           }
           alert.onBtnDoneTapped = {
               [weak alert, weak self] (description) in
               guard let self = self else { return } ; print(self)
               alert?.dismiss()
            self.lblPaypalEmailId.text = description
           }
       }
    
}


extension PaymentPreferenceVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func reloadTableDataToFitHeight(tableView: UITableView, height:NSLayoutConstraint) {
        if tableView.isHidden == false {
                DispatchQueue.main.async {
                    tableView.reloadData(heightToFit:height) {
                    }
                }
        } else {
            height.constant = 0
        }
        
        
        
    }
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        tableView.register(CreditCardTblCell.nib()
            , forCellReuseIdentifier: CreditCardTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CreditCardTblCell.name, for: indexPath) as?  CreditCardTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.openNewAddressDialog(index: indexPath.row)
    }
    
}


