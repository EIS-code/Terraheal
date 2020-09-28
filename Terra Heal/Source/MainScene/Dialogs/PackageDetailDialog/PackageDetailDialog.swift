//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit


class PackageDetailDialog: ThemeBottomDialogView {
    @IBOutlet weak var btnAddReciepent: ThemeButton!
    @IBOutlet weak var lblTotal: ThemeLabel!
    @IBOutlet weak var lblTotalValue: ThemeLabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalView: UIView!
    var arrForData: [PackageBookingInfo] = appSingleton.requestUsePurchasePackage?.booking_info ?? []
    
    var onBtnNextSelectedTapped: ((_ data: [PackageBookingInfo]) -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func initialize(title:String, buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnNext.isHidden = true
        } else {
            self.btnNext.setTitle(buttonTitle, for: .normal)
            self.btnNext.isHidden = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.tableView.contentInset = self.getGradientInset()
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle?.text = "RECIEPENT_DETAIL_TITLE".localized()
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.large)
        self.btnAddReciepent.setTitle("RECIEPENT_BTN_ADD_RECIEPENT".localized(), for: .normal)
        self.btnNext.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.lblTotal?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblTotal?.text = "RECIEPENT_LBL_TOTAL".localized()
        self.lblTotalValue?.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblTotalValue?.text = "210".localized()
        self.setupTableView(tableView: self.tableView)
        self.setDataForStepUpAnimation()
    }
    
    @IBAction func btnAddReciepentTapped(_ sender: Any) {
        self.btnAddReciepent.isEnabled = false
        self.openRecipientSelectionDialog()
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        self.btnAddReciepent.isEnabled = false
        if self.onBtnNextSelectedTapped != nil {
            self.onBtnNextSelectedTapped!(self.arrForData)
        }
    }
    
    func calculateTotal() {
        var total: Double = 0.0
        for  data in arrForData {
            for service in data.services {
                total = total + (service.amount).toDouble
            }
        }
        self.lblTotalValue.text = total.toString().toCurrency()
    }
    
    func openRecipientSelectionDialog() {
        
        let recipientSelectionDialog: RecipientSelectionDialog  = RecipientSelectionDialog.fromNib()
        recipientSelectionDialog.initialize(title: "RECIEPENT_DIALOG__TITLE".localized(), buttonTitle: "RECIEPENT_DIALOG_BTN_ADD".localized(), cancelButtonTitle: "BTN_BACK".localized())
        recipientSelectionDialog.show(animated: true)
        recipientSelectionDialog.onBtnCancelTapped = {
            [weak recipientSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            recipientSelectionDialog?.dismiss()
            self.btnAddReciepent.isEnabled = true
        }
        recipientSelectionDialog.onBtnDoneTapped = {
            [weak recipientSelectionDialog, weak self] (people) in
            guard let self = self else { return } ; print(self)
            recipientSelectionDialog?.dismiss()
            self.btnAddReciepent.isEnabled = true
            let bookingData: PackageBookingInfo = PackageBookingInfo.init()
            bookingData.reciepent = people
            bookingData.user_people_id = people.id
            bookingData.services = appSingleton.requestUsePurchasePackage!.selectedServices
            self.arrForData.append(bookingData)
            self.tableView.reloadData()
        }
    }
}


// MARK: - Table View Delegate & Data source

extension PackageDetailDialog: UITableViewDelegate, UITableViewDataSource {
    private func reloadTableDataToFitHeight(tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData {
            }
        }
    }
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
            tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        tableView.sectionFooterHeight = UITableView.automaticDimension
        tableView.estimatedSectionFooterHeight = 70
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 50
        tableView.register(ReciepentTblCell.nib()
            , forCellReuseIdentifier: ReciepentTblCell.name)
        tableView.register(ReciepentTblFooter.nib(), forHeaderFooterViewReuseIdentifier: ReciepentTblFooter.name)
        tableView.register(ReciepentTblSection.nib(), forHeaderFooterViewReuseIdentifier: ReciepentTblSection.name)
        tableView.backgroundColor = .themePrimaryLightBackground
        tableView.tableFooterView = UIView.init()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData[section].services.count
    }
   
    func numberOfSections(in tableView: UITableView) -> Int {
        arrForData.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: ReciepentTblSection.name)
            as? ReciepentTblSection
            else {
                return nil
        }
        view.setData(data: arrForData[section].reciepent)
        return view
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReciepentTblCell.name, for: indexPath) as?  ReciepentTblCell
        cell?.layoutIfNeeded()
        cell?.setPackServiceData(data: arrForData[indexPath.section].services[indexPath.row])
        cell?.btnDelete.addTarget(self
            , action: #selector(removeService(sender:)), for: .touchUpInside)
        cell?.layoutIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return JDDeviceHelper.offseter(scaleFactor: 1.0, offset: 40, direction: .vertical)
    }
    
    @objc func removeService(sender: UIButton) {
        let buttonPostion = sender.convert(sender.bounds.origin, to: tableView)
        
        if let indexPath = tableView.indexPathForRow(at: buttonPostion) {
            self.arrForData[indexPath.section].services.remove(at: indexPath.row)
            self.calculateTotal()
            self.tableView.reloadData()
        }
    }
}
