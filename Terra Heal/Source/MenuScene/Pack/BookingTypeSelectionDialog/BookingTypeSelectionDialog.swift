//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Jaydeep. All rights reserved.
//

import UIKit

class BookingTypeSelectionDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var onBtnDoneTapped: ((_ data:BookingType) -> Void)? = nil
    var selectedData:BookingType? = nil
    var arrForData: [SelectionCellDetailWithImage] = [
        SelectionCellDetailWithImage(image: BookingType.AtHotelOrRoom.getImage(), name:BookingType.AtHotelOrRoom.name(), id: BookingType.AtHotelOrRoom.getParameterId(), isSelected: false),
        SelectionCellDetailWithImage(image: BookingType.MassageCenter.getImage(), name: BookingType.MassageCenter.name(), id: BookingType.MassageCenter.getParameterId(), isSelected: false)
    ]
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
            self.btnDone?.isHidden = true
        } else {
            self.btnDone?.setTitle(buttonTitle, for: .normal)
            self.btnDone?.isHidden = false
        }
        self.setupTableView(tableView: self.tableView)
        
    }
    
    func select(data:BookingType) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.getParameterId() {
                arrForData[i].isSelected = true
            }
        }
        self.tableView.reloadData()
    }
    
    func setDataSource(data: [SelectionCellDetailWithImage]) {
        self.arrForData.removeAll()
        for value in data {
            self.arrForData.append(value)
            if value.isSelected {
                self.selectedData = BookingType.init(rawValue: value.id)
            }
        }
        self.reloadTableDataToFitHeight(tableView: self.tableView)
        //self.select(data: self.selectedData)
    }
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.Bold, size: FontSize.header)
    }
    
    
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        if selectedData != nil {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData!);
            }
        }
        
    }
    
}

extension BookingTypeSelectionDialog : UITableViewDelegate,UITableViewDataSource {
    
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
        tableView.register(BookingTypeSelectionCell.nib()
            , forCellReuseIdentifier: BookingTypeSelectionCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingTypeSelectionCell.name, for: indexPath) as?  BookingTypeSelectionCell
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
        self.selectedData = BookingType.init(rawValue: self.arrForData[indexPath.row].id)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



