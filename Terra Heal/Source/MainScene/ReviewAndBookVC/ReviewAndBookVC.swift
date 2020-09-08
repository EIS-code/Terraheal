//
//  ReviewAndBookVC.swift
//  Dumparoo
//  Created by Jaydeep Vyas on 03/05/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit

class ReviewAndBookVC: MainVC {
    
    @IBOutlet weak var vwBar: UIView!
    @IBOutlet weak var lblTitleDetail: ThemeLabel!
    @IBOutlet weak var btnCancel: CancelButton!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var contentVw: UIView!
    
    //BookingDetails
    @IBOutlet weak var vwBookingDetailHeader: UIView!
    @IBOutlet weak var lblBookingDetail: ThemeLabel!
    @IBOutlet weak var btnExpandBookingDetails: ThemeButton!
    @IBOutlet weak var vwBookingDetails: UIView!
    @IBOutlet weak var lblServiceCenterName: ThemeLabel!
    @IBOutlet weak var lblServiceCenterAddress: ThemeLabel!
    @IBOutlet weak var lblBookingDate: ThemeLabel!
    @IBOutlet weak var vwBookingDetailFooter: UIView!
    //SessionDetails
    @IBOutlet weak var vwSessionDetailHeader: UIView!
    @IBOutlet weak var lblSessionDetail: ThemeLabel!
    @IBOutlet weak var btnExpandSessionDetails: ThemeButton!
    @IBOutlet weak var tblVwForSessions: UITableView!
    @IBOutlet weak var hTblSession: NSLayoutConstraint!
    @IBOutlet weak var vwSessionDetailFooter: UIView!
    //SummaryDetails
    @IBOutlet weak var vwSummaryDetailHeader: UIView!
    @IBOutlet weak var lblSummaryDetail: ThemeLabel!
    @IBOutlet weak var tblVwForSummary: UITableView!
    @IBOutlet weak var hTblSummary: NSLayoutConstraint!
    @IBOutlet weak var vwSummaryDetailFooter: UIView!
    @IBOutlet weak var lblSubTotal: ThemeLabel!
    @IBOutlet weak var lblSubTotalValue: ThemeLabel!
    @IBOutlet weak var lblOther: ThemeLabel!
    @IBOutlet weak var lblOtherValue: ThemeLabel!
    @IBOutlet weak var lblTotal: ThemeLabel!
    @IBOutlet weak var lblTotalValue: ThemeLabel!
    
    @IBOutlet weak var vwForPromoCode: UIView!
    @IBOutlet weak var lblHavePromoCode: ThemeLabel!
    @IBOutlet weak var txtPromoCode: ACFloatingTextfield!
    @IBOutlet weak var btnApplyPromoCode: UIButton!
    
    
    @IBOutlet weak var vwTermsAndCondition: UIView!
    @IBOutlet weak var btnTermsCondition: UnderlineTextButton!
    @IBOutlet weak var lblAccept: ThemeLabel!
    @IBOutlet weak var btnCheckBox: JDCheckboxButton!
    
    @IBOutlet weak var vwPayment: UIView!
    @IBOutlet weak var btnWithoutPayment: RoundedBorderButton!
    @IBOutlet weak var btnPrepayment: ThemeButton!
    
    @IBOutlet weak var vwTotalBg: UIView!
    
    var arrForData: [BookingInfo] = appSingleton.myBookingData.booking_info
    var arrForSummaryData: [SummaryValueDetail] = SummaryValueDetail.getDemoArray()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
        self.setData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.btnPrepayment?.layoutIfNeeded()
            self.btnWithoutPayment?.layoutIfNeeded()
            self.btnPrepayment?.setupFilledButton()
            self.btnWithoutPayment?.setupBorderedButton()
            vwBookingDetailFooter?.createDashedLine(from: CGPoint.zero, to: CGPoint(x: vwBookingDetailFooter.bounds.maxX, y: 0), color: UIColor.themeDarkText, strokeLength: 10, gapLength: 5, width: 1.0)
            vwSessionDetailFooter?.createDashedLine(from: CGPoint.zero, to: CGPoint(x: vwSessionDetailFooter.bounds.maxX, y: 0), color: UIColor.themeDarkText, strokeLength: 10, gapLength: 5, width: 1.0)
            self.reloadTableDataToFitHeight(tableView: self.tblVwForSessions, height:self.hTblSession)
            self.reloadTableDataToFitHeight(tableView: self.tblVwForSummary, height:self.hTblSummary)
            vwTotalBg.setRound(withBorderColor: .themePrimary, andCornerRadious: 5.0, borderWidth: 1.0)
        }
        
    }
    
    func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.lblTitle?.text = "REVIEW_AND_BOOK_TITLE".localized()
      
        self.lblTitleDetail?.text = "REVIEW_AND_BOOK_TITLE_DETAIL".localized()
        self.lblTitleDetail?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblBookingDetail?.text = "REVIEW_AND_BOOK_LBL_BOOKING_DETAIL".localized()
        self.lblBookingDetail?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblServiceCenterName?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblServiceCenterAddress?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblBookingDate?.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblSessionDetail?.text = "REVIEW_AND_BOOK_LBL_SESSION_DETAIL".localized()
        self.lblSessionDetail?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblSummaryDetail?.text = "REVIEW_AND_BOOK_LBL_SUMMARY".localized()
        self.lblSummaryDetail?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblHavePromoCode?.text = "REVIEW_AND_BOOK_LBL_HAVE_A_COUPEN".localized()
        self.lblHavePromoCode?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblTotal?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblTotal?.text = "REVIEW_AND_BOOK_LBL_TOTAL".localized()
        self.lblTotalValue?.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.lblTotalValue?.text = "$210".localized()
        self.lblSubTotal?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblSubTotal?.text = "REVIEW_AND_BOOK_LBL_SUB_TOTAL".localized()
        self.lblSubTotalValue?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblSubTotalValue?.text = "$190".localized()
        self.lblOther?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblOther?.text = "REVIEW_AND_BOOK_LBL_OTHER".localized()
        self.lblOtherValue?.setFont(name: FontName.SemiBold, size: FontSize.label_18)
        self.lblOtherValue?.text = "$20".localized()
        self.setupTableView(tableView: self.tblVwForSessions)
        self.setupTableView(tableView: self.tblVwForSummary)
        self.registerNibForSessionTable(tableView: self.tblVwForSessions)
        self.registerNibForSummaryTable(tableView:self.tblVwForSummary)
        self.lblAccept?.text = "REGISTR_LBL_ACCEPT".localized()
        self.lblAccept?.setFont(name: FontName.SemiBold, size: FontSize.label_12)
        self.btnTermsCondition?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnTermsCondition?.setTitle("REGISTR_BTN_TERMS_AND_CONDITION".localized(), for: .normal)
        self.txtPromoCode?.placeholder = "REVIEW_AND_BOOK_TXT_PROMO_PLACEHOLDER".localized()
        self.txtPromoCode?.delegate = self
        self.txtPromoCode?.configureTextField(InputTextFieldDetail.getNameConfiguration())
    }
    
    @IBAction func btnCheckBoxTapped(_ sender: Any) {
        self.btnCheckBox.checkboxAnimation {
        }
    }
    
    @IBAction func btnCloseTapped(_ sender: Any) {
        self.btnCancel.isEnabled = false
        self.openCancelBookingDialog()
    }
    @IBAction func onBtnExpandBookingDetailTapped(_ sender: Any) {
        if btnExpandBookingDetails.isSelected {
            vwBookingDetails.gone()
        } else {
            vwBookingDetails.visible()
        }
        btnExpandBookingDetails.isSelected.toggle()
    }
    
    @IBAction func onBtnExpandSessionDetailTapped(_ sender: Any) {
        if btnExpandSessionDetails.isSelected {
            tblVwForSessions.gone()
        } else {
            tblVwForSessions.visible()
        }
        btnExpandSessionDetails.isSelected.toggle()
    }
    
    @IBAction func onBtnApplyPromoTapped(_ sender: Any) {
        
        
    }
    
    @IBAction func onBtnWithoutPaymentTapped(_ sender: Any) {
        if checkValidation() {
            
            print(appSingleton.myBookingData.toDictionary())
            Common.appDelegate.loadReservationVC()
            
        }
    }
    
    @IBAction func onBtnPrePaymentTapped(_ sender: Any) {
        if checkValidation() {
            print(appSingleton.myBookingData.toDictionary())
            self.openPartialPaymentBookingDialog()
        }
    }
    
    func openPartialPaymentBookingDialog() {
        let paymentPercentageDialog: PaymentPercentatgeSelectionDialog  = PaymentPercentatgeSelectionDialog.fromNib()
        
        paymentPercentageDialog.initialize(title: "PAYMENT_DIALOG_TITLE".localized(), buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
        paymentPercentageDialog.show(animated: true)
        paymentPercentageDialog.onBtnCancelTapped = {
            [weak paymentPercentageDialog, weak self] in
            guard let self = self else { return } ; print(self)
            paymentPercentageDialog?.dismiss()
            self.btnCancel.isEnabled = true
        }
        paymentPercentageDialog.onBtnDoneTapped = {
            [weak paymentPercentageDialog, weak self]  (button) in
            guard let self = self else { return } ; print(self)
            paymentPercentageDialog?.dismiss()
            Common.appDelegate.loadPaymentReferenceVC(navigaionVC: self.navigationController, isFromMenu: false)
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
            Common.appDelegate.loadHomeVC()
        }
    }
    
    func setData() {
        self.setServiceCenterDetail()
    }
    func setServiceCenterDetail(serviceCenter: ServiceCenterDetail = appSingleton.myBookingData.serviceCenterDetail){
        self.lblServiceCenterName.text = serviceCenter.name
        self.lblServiceCenterAddress.text = serviceCenter.address
        self.lblBookingDate.text = Date.milliSecToDate(milliseconds: appSingleton.myBookingData.date.toDouble, format: DateFormat.ReviewBookingDateDisplay)
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
        var total: Double = 0.0
        for  data in arrForData {
            for service in data.services {
                total = total + (service.selectedDuration.pricing.price).toDouble
            }
        }
        self.lblTotalValue.text = total.toString()
    }
}

extension ReviewAndBookVC : UITextFieldDelegate  {
    
}
// MARK: - Table View Delegate & Data source

extension ReviewAndBookVC: UITableViewDelegate, UITableViewDataSource {
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
    
    func registerNibForSessionTable(tableView: UITableView){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 70
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.register(ReviewReciepentTblCell.nib()
            , forCellReuseIdentifier: ReviewReciepentTblCell.name)
        tableView.register(ReciepentTblFooter.nib(), forHeaderFooterViewReuseIdentifier: ReciepentTblFooter.name)
        tableView.register(ReviewReciepentTblSection.nib(), forHeaderFooterViewReuseIdentifier: ReviewReciepentTblSection.name)
    }
    func registerNibForSummaryTable(tableView: UITableView){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.register(ReviewSummaryTblCell.nib()
            , forCellReuseIdentifier: ReviewSummaryTblCell.name)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblVwForSessions {
            return arrForData[section].services.count
        } else  {
            return arrForSummaryData.count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == tblVwForSessions {
            return arrForData.count
        }
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == tblVwForSessions {
            guard let view = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: ReviewReciepentTblSection.name)
                as? ReviewReciepentTblSection
                else {
                    return nil
            }
            view.setData(data: arrForData[section].reciepent)
            return view
        } else {
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == tblVwForSessions {
            return  40
        }
        else {
            return 1
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblVwForSessions {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewReciepentTblCell.name, for: indexPath) as?  ReviewReciepentTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForData[indexPath.section].services[indexPath.row])
            cell?.btnDelete.addTarget(self
                , action: #selector(removeService(sender:)), for: .touchUpInside)
            cell?.btnEdit.addTarget(self, action: #selector(editService(sender:)), for: .touchUpInside)
            cell?.layoutIfNeeded()
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: ReviewSummaryTblCell
                .name, for: indexPath) as?  ReviewSummaryTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForSummaryData[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40//UITableView.automaticDimension
    }
    
    @objc func editService(sender: UIButton) {
        let buttonPostion = sender.convert(sender.bounds.origin, to: tblVwForSessions)
        if let indexPath = tblVwForSessions.indexPathForRow(at: buttonPostion) {
            self.openServiceDurationSelection(index: indexPath)
            
        }
        
        
    }
    
    @objc func removeService(sender: UIButton) {
        let buttonPostion = sender.convert(sender.bounds.origin, to: tblVwForSessions)
        if let indexPath = tblVwForSessions.indexPathForRow(at: buttonPostion) {
            self.arrForData[indexPath.section].services.remove(at: indexPath.row)
            self.calculateTotal()
            self.reloadTableDataToFitHeight(tableView: self.tblVwForSessions, height: self.hTblSession)
        }
    }
    
    func openServiceDurationSelection(index: IndexPath) {
        let durationSelectionDialog: DurationSelectionDialog = DurationSelectionDialog.fromNib()
        durationSelectionDialog.initialize(title: "Select duration",message: "note:- 23% VAT is included", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        durationSelectionDialog.setDataSource(data: arrForData[index.section].services[index.row].duration)
        durationSelectionDialog.show(animated: true)
        durationSelectionDialog.onBtnCancelTapped = {
            [weak durationSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            durationSelectionDialog?.dismiss()
        }
        durationSelectionDialog.onBtnDoneTapped = {
            [weak durationSelectionDialog, weak self]  (hour) in
            guard let self = self else { return } ; print(self)
            durationSelectionDialog?.dismiss()
            for i in 0..<self.arrForData[index.section].services[index.row].duration.count {
                self.arrForData[index.section].services[index.row].duration[i].isSelected = false
                if self.arrForData[index.section].services[index.row].duration[i].id == hour.id {
                    self.arrForData[index.section].services[index.row].duration[i].isSelected = true
                    self.arrForData[index.section].services[index.row].selectedDuration = hour
                }
            }
            self.calculateTotal()
            self.reloadTableDataToFitHeight(tableView: self.tblVwForSessions, height: self.hTblSession)
        }
    }
}
