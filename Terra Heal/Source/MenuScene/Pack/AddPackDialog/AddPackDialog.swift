//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class AddPackDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var tableView: UITableView!
    
    var onBtnDoneTapped: ((_ data:AddPackageDetail) -> Void)? = nil
    var selectedData:AddPackageDetail = AddPackageDetail.init()
    var arrForData: [AddPackageDetail] = AddPackageDetail.getDemoArray()
    
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
    
    func select(data:AddPackageDetail) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.reloadTableDateToFitHeight(tableView: self.tableView)
        
    }
    
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
        self.setDataForStepUpAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDateToFitHeight(tableView: self.tableView)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedData.id == "" {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData);
            }
        }
    }
    
}

extension AddPackDialog : UITableViewDelegate,UITableViewDataSource {
    
    private func reloadTableDateToFitHeight(tableView: UITableView) {
        tableView.reloadData() {
            
        }
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
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
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
        }
        self.arrForData[indexPath.row].isSelected = true
        self.selectedData = self.arrForData[indexPath.row]
        tableView.reloadData()
        self.openPackSelectionDialog()
       /* if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(selectedData);
        }*/
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        
    }
    
    func openPackSelectionDialog() {
        
        let alert: SelectPackDialog = SelectPackDialog.fromNib()
        alert.initialize(title: "select a pack", buttonTitle: "Get This Pack", cancelButtonTitle: "BTN_CANCEL".localized())
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
            self.tableView.reloadData()
        }
        
        
    }
}



