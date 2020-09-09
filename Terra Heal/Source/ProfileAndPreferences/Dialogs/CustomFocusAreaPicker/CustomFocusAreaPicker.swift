//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

class CustomFocusAreaPicker: ThemeBottomDialogView {

    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!

    var onBtnDoneTapped: ((_ pressure:PreferenceOption) -> Void)? = nil
    var selectedData:PreferenceOption = PreferenceOption.init(fromDictionary: [:])
    var arrForData: [PreferenceOption] = []
    
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
        self.select(data: self.selectedData)
        self.setupTableView(tableView: self.tableView)

    }

    func select(data:PreferenceOption) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.tableView.reloadData()
    }

    func setDataSource(data:  MassagePreferenceDetail) {
        self.arrForData.removeAll()
        for option in data.preferenceOptions {
            self.arrForData.append(option)
            if option.isSelected {
                self.selectedData = option
            }
        }
        self.select(data: self.selectedData)
    }
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
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

extension CustomFocusAreaPicker : UITableViewDelegate,UITableViewDataSource {

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
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(PressureSelectionTblCell.nib()
            , forCellReuseIdentifier: PressureSelectionTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


        let cell = tableView.dequeueReusableCell(withIdentifier: PressureSelectionTblCell.name, for: indexPath) as?  PressureSelectionTblCell
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
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



