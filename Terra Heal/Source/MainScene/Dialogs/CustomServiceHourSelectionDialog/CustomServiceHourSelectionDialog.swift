//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit




class CustomServiceHourSelectionDialog: ThemeBottomDialogView {

    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var onBtnDoneTapped: ((_ data: HoursDetails) -> Void)? = nil
    var selectedData: HoursDetails? = nil

    var arrForData: [HoursDetails] = HoursDetails().getDemoArray()
    
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
        self.btnDone.isHidden = true
        self.btnCancel.isHidden = true
        self.select(data: self.selectedData)
        self.setupTableView(tableView: self.tableView)
        
    }

    func select(data:HoursDetails?) {
        self.selectedData = data
    }
    func setDataSource(data: [HoursDetails]) {
        self.arrForData.removeAll()
        for value in data {
            self.arrForData.append(value)
            if value.isSelected {
                self.selectedData = value
            }
        }
        self.tableView.reloadData()
    }
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.label_22)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDateToFitHeight(tableView: self.tableView)
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedData == nil {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData!);
            }
        }

    }

}

extension CustomServiceHourSelectionDialog : UITableViewDelegate,UITableViewDataSource {

    private func reloadTableDateToFitHeight(tableView: UITableView) {
        DispatchQueue.main.async {

            tableView.reloadData(heightToFit: self.hTblVw) {
            }
        }

    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(CustomServiceHourSelectionCell.nib()
            , forCellReuseIdentifier: CustomServiceHourSelectionCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CustomServiceHourSelectionCell.name, for: indexPath) as?  CustomServiceHourSelectionCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedData = self.arrForData[indexPath.row]
        if selectedData == nil {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_DATA".localized())
        } else {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData!);
            }
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

