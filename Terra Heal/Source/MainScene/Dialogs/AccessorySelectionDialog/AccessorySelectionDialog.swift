//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit



class AccessorySelectionDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var onBtnDoneTapped: ((_ data:Int ,_ type:AccessoryType) -> Void)? = nil
    var arrForData: [AccessoryDetail] = [AccessoryDetail(isSelected: false, id: 1, title: "table".localized()),AccessoryDetail(isSelected: false, id: 2, title: "tatami/futon".localized())]
    
    @IBOutlet weak var vwProceed: UIView!
    @IBOutlet weak var btnDecrement: ThemeButton!
    @IBOutlet weak var lblQuatity: ThemeLabel!
    @IBOutlet weak var btnIncrement: ThemeButton!
    @IBOutlet weak var lblHowMany: ThemeLabel!
    var selectedType:AccessoryType = AccessoryType.None
    var quatity:Int = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.lblQuatity?.setRound(withBorderColor: .clear, andCornerRadious: 3.0, borderWidth: 1.0)
        self.reloadTableDataToFitHeight(tableView: self.tableView)
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
        self.lblQuatity.text =  quatity.toString()
        self.setupTableView(tableView: self.tableView)
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
    
    func setDataSource(data: [AccessoryDetail]) {
        self.arrForData.removeAll()
        for value in data {
            self.arrForData.append(value)
        }
        self.reloadTableDataToFitHeight(tableView: self.tableView)
        //self.select(data: self.selectedData)
    }
    override func initialSetup() {
        super.initialSetup()
        self.lblHowMany.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblQuatity.setFont(name: FontName.Bold, size: FontSize.header)
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
        self.btnDecrement.setFont(name: FontName.Bold, size: FontSize.header)
        self.btnIncrement.setFont(name: FontName.Bold, size: FontSize.header)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if quatity != 0 {
                if self.onBtnDoneTapped != nil {
                    self.onBtnDoneTapped!(quatity,selectedType);
                }
        } else {
            Common.showAlert(message: "Please enter valid quantity")
        }
    }
    @IBAction func btnDecrementTapped(_ sender: Any) {
        if quatity != 0 {
            quatity = quatity - 1
            lblQuatity.setTextWithAnimation(text: quatity.toString())
        }
        
    }
    
    @IBAction func btnIncrementTapped(_ sender: Any) {
        quatity = quatity + 1
        lblQuatity.setTextWithAnimation(text: quatity.toString())
    }
    
}

extension AccessorySelectionDialog : UITableViewDelegate,UITableViewDataSource {
    
    private func reloadTableDataToFitHeight(tableView: UITableView) {
        tableView.reloadData(heightToFit: self.hTblVw) {
            
        }
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(AccessoryTblCell.nib()
            , forCellReuseIdentifier: AccessoryTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AccessoryTblCell.name, for: indexPath) as?  AccessoryTblCell
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
            selectedType = AccessoryType.Table
        } else {
            selectedType = AccessoryType.Futon
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
