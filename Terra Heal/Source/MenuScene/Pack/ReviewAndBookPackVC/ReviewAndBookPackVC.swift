//
//  ReviewAndBookVC.swift
//  Dumparoo
//  Created by Jaydeep Vyas on 03/05/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit

class ReviewAndBookPackVC: BaseVC {
    
    @IBOutlet weak var vwBar: UIView!
    @IBOutlet weak var lblTitleDetail: ThemeLabel!
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var contentVw: UIView!
    //SummaryDetails
    @IBOutlet weak var vwSummaryDetailHeader: UIView!
    @IBOutlet weak var lblSummaryDetail: ThemeLabel!
    @IBOutlet weak var tblVwForSummary: UITableView!
    @IBOutlet weak var hTblSummary: NSLayoutConstraint!
    @IBOutlet weak var vwSummaryDetailFooter: UIView!
    @IBOutlet weak var lblTotal: ThemeLabel!
    @IBOutlet weak var lblTotalValue: ThemeLabel!
    
    @IBOutlet weak var vwTermsAndCondition: UIView!
    @IBOutlet weak var btnTermsCondition: UnderlineTextButton!
    @IBOutlet weak var lblAccept: ThemeLabel!
    @IBOutlet weak var btnCheckBox: JDCheckboxButton!
    
    @IBOutlet weak var vwPayment: UIView!
    @IBOutlet weak var btnBtnSubmit: FilledRoundedButton!
    @IBOutlet weak var vwTotalBg: UIView!
    
    var arrForSummaryData: [SummaryValueDetail] = []
     var total: Double = 0.0
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
        self.arrForSummaryData.append(SummaryValueDetail.init(title: appSingleton.purchasePackage!.title, subTitle: "", value: appSingleton.purchasePackage!.actualAmount))
        self.calculateTotal()
        self.btnBtnSubmit.setTitle("BTN_PAY".localized(with: [appSingleton.currencySymbol,appSingleton.purchasePackage!.actualAmount]), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.reloadTableDataToFitHeight(tableView: self.tblVwForSummary, height:self.hTblSummary)
            vwTotalBg.setRound(withBorderColor: .themePrimary, andCornerRadious: 5.0, borderWidth: 1.0)
        }
        
    }
    
    func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.lblTitle?.text = "REVIEW_AND_BOOK_TITLE".localized()
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.lblTitleDetail?.text = "REVIEW_AND_BOOK_TITLE_DETAIL".localized()
        self.lblTitleDetail?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblSummaryDetail?.text = "REVIEW_AND_BOOK_LBL_SUMMARY".localized()
        self.lblSummaryDetail?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblTotal?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblTotal?.text = "REVIEW_AND_BOOK_LBL_TOTAL".localized()
        self.lblTotalValue?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblTotalValue?.text = "$210".localized()
        self.setupTableView(tableView: self.tblVwForSummary)
        self.registerNibForSummaryTable(tableView:self.tblVwForSummary)
        self.lblAccept?.text = "REGISTR_LBL_ACCEPT".localized()
        self.lblAccept?.setFont(name: FontName.SemiBold, size: FontSize.detail)
        self.btnTermsCondition?.setFont(name: FontName.SemiBold, size: FontSize.button_13)
        self.btnTermsCondition?.setTitle("REGISTR_BTN_TERMS_AND_CONDITION".localized(), for: .normal)
    }
    
    @IBAction func btnCheckBoxTapped(_ sender: Any) {
        self.btnCheckBox.checkboxAnimation {
        }
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.btnCancel.isEnabled = false
        self.openCancelBookingDialog()
    }
    
    
    @IBAction func onBtnSubmitTapped(_ sender: Any) {
        if checkValidation() {
            Common.appDelegate.loadPaymentReferenceVC( amount: self.total, navigaionVC: self.navigationController, fromVC:self)
        }
    }
    
    func openCancelBookingDialog() {
        let cancelBookingDialog: CustomAlertConfirmation  = CustomAlertConfirmation.fromNib()
        cancelBookingDialog.initialize(title: "cancel", message: "are you sure you want to cancel it?", buttonTitle: "yes cancel".localized(),cancelButtonTitle: "BTN_BACK".localized())
        cancelBookingDialog.show(animated: true)
        cancelBookingDialog.onBtnCancelTapped = {
            [weak cancelBookingDialog, weak self] in
            guard let self = self else { return } ; print(self)
            cancelBookingDialog?.dismiss()
            self.btnCancel.isEnabled = true
        }
        cancelBookingDialog.onBtnDoneTapped = {
            [weak cancelBookingDialog, weak self]  in
            guard let self = self else { return } ; print(self)
            cancelBookingDialog?.dismiss()
            Common.appDelegate.loadMainVC()
        }
    }
    
    func checkValidation() -> Bool {
        if !btnCheckBox.isSelected {
            let alert: CustomAlert = CustomAlert.fromNib()
            alert.initialize(message: "VALIDATION_MSG_SELECT_TERMS_AND_CONDITION".localized())
            alert.show(animated: true)
            alert.onBtnCancelTapped = {
                [weak alert, weak self] in
                guard let self = self else { return } ; print(self)
                alert?.dismiss()
            }
            return false
        }
        return true
    }
    
    func calculateTotal() {
        total = 0.0
        for  data in arrForSummaryData {
            total = total + data.value.toDouble
        }
        self.lblTotalValue.text = total.toString()
    }
}

// MARK: - Table View Delegate & Data source

extension ReviewAndBookPackVC: UITableViewDelegate, UITableViewDataSource {
    private func reloadTableDataToFitHeight(tableView: UITableView, height:NSLayoutConstraint) {
        DispatchQueue.main.async {
            tableView.reloadData(heightToFit:height) {
            }
        }
        
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .themeBackground
        tableView.tableFooterView = UIView()
    }
    
    
    func registerNibForSummaryTable(tableView: UITableView){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.register(ReviewSummaryTblCell.nib()
            , forCellReuseIdentifier: ReviewSummaryTblCell.name)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForSummaryData.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReviewSummaryTblCell
                .name, for: indexPath) as?  ReviewSummaryTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForSummaryData[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40//UITableView.automaticDimension
    }
}
