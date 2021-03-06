//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit


class AddPackDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var tableView: UITableView!
    
    var onBtnDoneTapped: ((_ data:PackageWebService.RequestBuyPackage) -> Void)? = nil
    var selectedData:AddPackageDetail = AddPackageDetail.init()
    var arrForData: [AddPackageDetail] = []
    
    var selectedCenter: ServiceCenterDetail? = nil
    var requestPackage: PackageWebService.RequestBuyPackage = PackageWebService.RequestBuyPackage.init()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        if buttonTitle.isEmpty() {
            self.btnDone.isHidden = true
        } else {
            self.btnDone.setTitle(buttonTitle, for: .normal)
            self.btnDone.isHidden = false
        }
        self.setupTableView(tableView: self.tableView)
        
    }
    func setDataSource(data:[AddPackageDetail]) {
        self.arrForData = data
        self.reloadTableDataToFitHeight(tableView: self.tableView)
        
    }
    func select(data:AddPackageDetail) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.reloadTableDataToFitHeight(tableView: self.tableView)
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.setDataForStepUpAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDataToFitHeight(tableView: self.tableView)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        var isDataSelected:Bool = true
        for data in arrForData {
            if !data.isSelected {
                isDataSelected = false
                break
            }
        }
        if isDataSelected == false {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(requestPackage);
            }
        }
    }
    
}

extension AddPackDialog : UITableViewDelegate,UITableViewDataSource {
    
    private func reloadTableDataToFitHeight(tableView: UITableView) {
        tableView.reloadData() {
            
        }
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(AddPackTblCell.nib()
            , forCellReuseIdentifier: AddPackTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddPackTblCell.name, for: indexPath) as?  AddPackTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            self.openCenterSelectionDialog(index: indexPath.row)
        case 1:
            self.openPackSelectionDialog(index: indexPath.row)
        case 2:
            self.openRecipientDetailDialog(index: indexPath.row)
        case 3:
            self.openGiverDetailDialog(index: indexPath.row)
        case 4:
            self.openSendingPreferenceDialog(index: indexPath.row)
        default:
            self.openPackSelectionDialog(index: indexPath.row)
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func openPackSelectionDialog(index:Int) {
        if let center = selectedCenter {
                let alert: SelectPackDialog = SelectPackDialog.fromNib()
                alert.initialize(title: "select a pack", buttonTitle: "Get This Pack", cancelButtonTitle: "BTN_CANCEL".localized())
                alert.wsGetPackageList(shopId: center.id)
                alert.onBtnCancelTapped = {
                    [weak alert, weak self] in
                    alert?.dismiss()
                    guard let self = self else { return } ; print(self)
                }
                alert.onBtnDoneTapped = {
                    [weak alert, weak self] (data) in
                    alert?.dismiss()
                    guard let self = self else { return } ; print(self)
                    self.arrForData[index].isSelected = true
                    self.requestPackage.user_pack_id = data.id
                    self.tableView.reloadData()
                }
        }
        else {
            
        }
    }
    
    
    
    func openGiverDetailDialog(index:Int) {
        let alert: CustomGiverDetailDialog = CustomGiverDetailDialog.fromNib()
        alert.initialize(title: "giver details", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (data) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            
            self.requestPackage.giver_email = data.email
            self.requestPackage.giver_first_name = data.name
            self.requestPackage.giver_mobile = data.mobileNumber
            self.requestPackage.giver_message_to_recipient = data.message
            self.requestPackage.giver_last_name = data.name
            self.arrForData[index].isSelected = true
            self.tableView.reloadData()
        }
    }
    
    func openSendingPreferenceDialog(index:Int) {
        let alert: CustomSendingPreferenceDialog = CustomSendingPreferenceDialog.fromNib()
        alert.initialize(title: "DIALOG_TITLE_SEND_PREFERENCE".localized(), placeholder: "TXT_EMAIL".localized(), data: "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (data) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.arrForData[index].isSelected = true
            self.requestPackage.preference_email = data.email
            self.requestPackage.preference_email_date = data.dateToSend
            self.tableView.reloadData()
        }
    }
    
    func openRecipientDetailDialog(index:Int) {
        let alert: CustomRecipientDetailDialog = CustomRecipientDetailDialog.fromNib()
        alert.initialize(title: "recipients details", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (data) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.arrForData[index].isSelected = true
            self.tableView.reloadData()
            self.requestPackage.recipient_email = data.email
            self.requestPackage.recipient_last_name = data.lastname
            self.requestPackage.recipient_mobile = data.mobileNumber
            self.requestPackage.recipient_name = data.name
            self.requestPackage.recipient_second_name = data.secondName
        }
    }
    
    func openCenterSelectionDialog(index:Int) {
        
        let alert: CustomServiceCenterSelectionDialog = CustomServiceCenterSelectionDialog.fromNib()
        alert.initialize(title: "select center", buttonTitle: "select")
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            //appSingleton.myBookingPackageData.packId = 
            
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (data) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.arrForData[index].isSelected = true
            self.selectedCenter = data
            self.tableView.reloadData()
        }
    }
}

