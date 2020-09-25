//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

struct CustomDataForTable {
    var id: String = ""
    var name: String = ""
    var isSelected: Bool = false
}
class CustomTableDataSelectionDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var txtSearchBar: ThemeTextField!
    
    var onBtnDoneTapped: ((_ data: CustomDataForTable) -> Void)? = nil
    var selectedData: CustomDataForTable? = nil
    var arrForFilteredData: [CustomDataForTable] = []
    var arrForForOriginalData: [CustomDataForTable] = []
    
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
        self.setupSearchbar(searchBar: self.txtSearchBar)
    }
    
    func select(data:CustomDataForTable?) {
        self.selectedData = data
    }
    func setDataSource(dataList:[CustomDataForTable]) {
        self.arrForForOriginalData.removeAll()
        self.arrForFilteredData.removeAll()
        for data in dataList {
            self.arrForFilteredData.append(data)
            self.arrForForOriginalData.append(data)
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
        self.searchVw.setRound(withBorderColor: .clear, andCornerRadious: self.searchVw.bounds.height/2.0, borderWidth: 1.0)
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

extension CustomTableDataSelectionDialog : UITableViewDelegate,UITableViewDataSource {
    
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
        tableView.estimatedRowHeight = 70
        tableView.register(CustomTableDataSelectionCell.nib()
            , forCellReuseIdentifier: CustomTableDataSelectionCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForFilteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableDataSelectionCell.name, for: indexPath) as?  CustomTableDataSelectionCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForFilteredData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForFilteredData.count {
            arrForFilteredData[i].isSelected = false
        }
        self.arrForFilteredData[indexPath.row].isSelected = true
        self.selectedData = self.arrForFilteredData[indexPath.row]
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CustomTableDataSelectionDialog : UITextFieldDelegate {
    
    private func setupSearchbar(searchBar: UITextField) {
        txtSearchBar.delegate = self
        txtSearchBar.setFont(name: FontName.Regular, size: FontSize.textField_regular)
        txtSearchBar.addTarget(self, action: #selector(searching(_:)), for: .editingChanged)
        txtSearchBar.textColor = UIColor.themeDarkText
        txtSearchBar.changePlaceHolder(color: UIColor.themeDarkText)
        txtSearchBar.placeholder = "PROFILE_TXT_SEARCH_CITY".localized()
        
    }
    @IBAction func searching(_ sender: UITextField) {
        searchData(for: sender.text ?? "")
    }
    
    func searchData(for text: String) {
        if text.isEmpty {
            self.arrForFilteredData.removeAll()
            for data in self.arrForForOriginalData {
                self.arrForFilteredData.append(data)
            }
        } else {
            self.arrForFilteredData.removeAll()
            for data in self.arrForForOriginalData {
                if data.name.lowercased().hasPrefix(text.lowercased()) {
                    self.arrForFilteredData.append(data)
                }
            }
        }
        self.reloadTableDataToFitHeight(tableView: tableView)
    }
}



