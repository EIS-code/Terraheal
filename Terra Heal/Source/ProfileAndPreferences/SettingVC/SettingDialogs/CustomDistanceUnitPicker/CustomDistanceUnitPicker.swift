//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

enum DistanceUnit: String {
    case Kilometre = "km"
    case Mile = "miles"

    func name() -> String {
        switch self
        {
        case .Kilometre:
            return "kilometre"
        case .Mile:
            return "Mile"
        }
    }
    func symbol() -> String {
        switch self
        {
        case .Kilometre:
            return "km"
        case .Mile:
            return "miles"
        }
    }
}

struct DistanceDetail {
    var type: DistanceUnit = DistanceUnit.Kilometre
    var isSelected: Bool = false
}
class CustomDistanceUnitPicker: ThemeBottomDialogView {

    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    var onBtnDoneTapped: ((_ data:DistanceUnit) -> Void)? = nil
    var selectedData:DistanceUnit = DistanceUnit.Kilometre
    var arrForData: [DistanceDetail] = [DistanceDetail.init(type: DistanceUnit.Kilometre, isSelected: false),DistanceDetail.init(type: DistanceUnit.Mile, isSelected: false)]


    //Animation Properties
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

    
    func select(data:DistanceUnit) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].type == data {
              arrForData[i].isSelected = true
            }
        }
        self.tableView.reloadData()
    }

    @IBAction func btnDoneTapped(_ sender: Any) {
            if self.onBtnDoneTapped != nil {
                self.onBtnDoneTapped!(selectedData);
            }
    }


}


extension CustomDistanceUnitPicker : UITableViewDelegate,UITableViewDataSource {

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
        tableView.register(CustomDistancePickerCell.nib()
            , forCellReuseIdentifier: CustomDistancePickerCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CustomDistancePickerCell.name, for: indexPath) as?  CustomDistancePickerCell
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
        self.selectedData = self.arrForData[indexPath.row].type
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}



