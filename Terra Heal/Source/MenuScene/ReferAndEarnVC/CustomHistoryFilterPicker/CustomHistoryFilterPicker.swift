//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit

struct HistoryFilter {
    var id: String = ""
    var strFilterType: String = ""
    var isSelected: Bool = false
}


class CustomHistoryFilterPicker: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
   @IBOutlet weak var tableView: UITableView!


    var onBtnDoneTapped: ((_ data: HistoryFilter) -> Void)? = nil
    var selectedData: HistoryFilter? = nil

    var arrForFilteredData: [HistoryFilter] = [HistoryFilter(id:"0", strFilterType: "last month", isSelected: false),
                                               HistoryFilter(id:"1",strFilterType: "last 6 month", isSelected: false),
                                               HistoryFilter(id:"2",strFilterType: "last 12 month", isSelected: false)]

    func initialize(title:String,buttonTitle:String,cancelButtonTitle:String) {
        self.initialSetup()
        self.lblTitle.text = title
        self.btnDone.setTitle(buttonTitle, for: .normal)
        if cancelButtonTitle.isEmpty() {
            self.btnCancel.isHidden = true
        } else {
            self.btnCancel.setTitle(cancelButtonTitle, for: .normal)
            self.btnCancel.isHidden = false
        }
        self.select(data: self.selectedData)
        self.setupTableView(tableView: self.tableView)

    }

    func select(data:HistoryFilter?) {
        self.selectedData = data
    }

    func initialSetup() {
        dialogView.clipsToBounds = true
        self.backgroundColor = .clear
        self.backgroundView.backgroundColor = UIColor.black
        self.backgroundView.alpha = 0.0
        self.backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTappedOnBackgroundView)))
        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnDone.setHighlighted(isHighlighted: true)
        self.btnCancel.setFont(name: FontName.Bold, size: FontSize.button_22)
        dialogView.setRound(withBorderColor: .clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        transitionAnimator = UIViewPropertyAnimator.init(duration: 0.25, curve: UIView.AnimationCurve.easeInOut, animations: nil)
        self.addPanGesture(view: dialogView)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        vwTopBar?.setRound(withBorderColor: .clear, andCornerRadious: 2.5, borderWidth: 1.0)
        self.btnDone?.layoutIfNeeded()
        self.btnDone?.setHighlighted(isHighlighted: true)
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

extension CustomHistoryFilterPicker : UITableViewDelegate,UITableViewDataSource {

    private func reloadTableDateToFitHeight(tableView: UITableView) {
        DispatchQueue.main.async {

            tableView.reloadData {

            }
            
        }

    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(CustomHistoryFilterPickerCell.nib()
            , forCellReuseIdentifier: CustomHistoryFilterPickerCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForFilteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CustomHistoryFilterPickerCell.name, for: indexPath) as?  CustomHistoryFilterPickerCell
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



