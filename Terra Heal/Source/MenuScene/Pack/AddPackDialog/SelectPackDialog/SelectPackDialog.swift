//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit


class SelectPackDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var tableView: UITableView!
    
    var onBtnDoneTapped: ((_ data:PackageDetail) -> Void)? = nil
    var selectedData:PackageDetail = PackageDetail.init()
    var arrForData: [PackageDetail] = []
    var arrForOriginalData: [Package] = []
    
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
    
    func select(data:PackageDetail) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.reloadTableDataToFitHeight(tableView: self.tableView)
    }
    
    func setDataSource(dataList:[PackageDetail]) {
        self.arrForData.removeAll()
        for data in dataList {
            self.arrForData.append(data)
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
        if selectedData.id == "" {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData);
            }
        }
    }
    
}

extension SelectPackDialog : UITableViewDelegate,UITableViewDataSource {
    
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
        tableView.register(SelectPackTblCell.nib()
            , forCellReuseIdentifier: SelectPackTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectPackTblCell.name, for: indexPath) as?  SelectPackTblCell
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
        if self.onBtnDoneTapped != nil {
            appSingleton.purchasePackage = self.arrForOriginalData[indexPath.row]
            self.onBtnDoneTapped!(selectedData);
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



extension SelectPackDialog {
    func wsGetPackageList(shopId:String) {
        let reuest: PackageWebService.RequestPackageList =
            PackageWebService.RequestPackageList.init(shop_id:"5")
        AppWebApi.getPackageList(params: reuest) { (response) in
            self.arrForData.removeAll()
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData = response.dataList
                for data in self.arrForOriginalData {
                    self.arrForData.append(data.toViewModel())
                }
                self.show(animated: true)
            } else {
                Common.showAlert(message: "No Any Package Available for this center")
            }
            
        }
    }
}
