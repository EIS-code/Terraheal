//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class AccessorySelectionDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var onBtnDoneTapped: ((_ data:Int) -> Void)? = nil
    var arrForData: [CustomButtonDetail] = [CustomButtonDetail(isSelected: false, id: 0, title: "ACCESSORY_BTN_YES".localized(), type: 0),CustomButtonDetail(isSelected: false, id: 1, title: "ACCESSORY_BTN_NO".localized(), type: 1)]
    
    @IBOutlet weak var vwProceed: UIView!
    @IBOutlet weak var txtData: ACFloatingTextfield!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDateToFitHeight(tableView: self.tableView)
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
            self.btnNext.isHidden = true
        } else {
            self.btnNext.setTitle(buttonTitle, for: .normal)
            self.btnNext.isHidden = false
        }
        self.setupTableView(tableView: self.tableView)
        self.updateAccessory(isYesSelected: false)
    }
    
    func select(data:CustomButtonDetail) {
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.tableView.reloadData()
    }
    
    func setDataSource(data: [CustomButtonDetail]) {
        self.arrForData.removeAll()
        for value in data {
            self.arrForData.append(value)
        }
        self.reloadTableDateToFitHeight(tableView: self.tableView)
        //self.select(data: self.selectedData)
    }
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.txtData.placeholder = "ACCESSORY_TXT_NUMBER_OF_TABLES".localized()
        self.txtData?.delegate = self
        self.txtData.configureTextField(InputTextFieldDetail.getNumberConfiguration())
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if txtData.validate().isValid {
                if self.onBtnDoneTapped != nil {
                    self.onBtnDoneTapped!(txtData.text!.toInt);
                }
        }
    }
    
    func updateAccessory(isYesSelected:Bool) {
        if isYesSelected {
            txtData.isHidden = false
            vwProceed.isHidden = false
        } else  {
            txtData.isHidden = true
            vwProceed.isHidden = true
        }
    }
    
}

extension AccessorySelectionDialog : UITableViewDelegate,UITableViewDataSource {
    
    private func reloadTableDateToFitHeight(tableView: UITableView) {
        tableView.reloadData(heightToFit: self.hTblVw) {
            
        }
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(CustomButtonTblCell.nib()
            , forCellReuseIdentifier: CustomButtonTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomButtonTblCell.name, for: indexPath) as?  CustomButtonTblCell
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
        if indexPath.row == 0 {
            self.updateAccessory(isYesSelected: true)
        } else {
            self.updateAccessory(isYesSelected: false)
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



extension AccessorySelectionDialog: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textField.resignFirstResponder()
        return true
    }
}
