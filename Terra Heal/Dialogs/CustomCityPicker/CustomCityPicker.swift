//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit




class CustomCityPicker: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchVw: UIView!

    @IBOutlet weak var txtSearchBar: ThemeTextField!

    var onBtnDoneTapped: ((_ data: City) -> Void)? = nil
    var selectedData: City? = nil

    var arrForFilteredData: [City] = []//City.getDemoArray()
    var arrForForOriginalData: [City] = []//City.getDemoArray()
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
        self.setupSearchbar(searchBar: self.txtSearchBar)
        
    }

    func select(data:City?) {
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
        self.btnDone?.setHighlighted(isHighlighted: true)
        self.reloadTableDateToFitHeight(tableView: self.tableView)
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

extension CustomCityPicker : UITableViewDelegate,UITableViewDataSource {

    private func reloadTableDateToFitHeight(tableView: UITableView) {
        DispatchQueue.main.async {

            tableView.reloadData {

            }
            /*tableView.reloadData(heightToFit: self.hTblVw) {

            }*/
        }

    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(CustomCityPickerCell.nib()
            , forCellReuseIdentifier: CustomCityPickerCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForFilteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCityPickerCell.name, for: indexPath) as?  CustomCityPickerCell
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

extension CustomCityPicker : UITextFieldDelegate {

    private func setupSearchbar(searchBar: UITextField) {
        txtSearchBar.delegate = self
        txtSearchBar.setFont(name: FontName.Regular, size: FontSize.label_10)
        txtSearchBar.placeholder = "search country"
        
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
        self.reloadTableDateToFitHeight(tableView: tableView)
    }


}
//MARK: Web Service Call
extension CustomCityPicker {

    func getCityList(countryId:String) {
        var request = Cities.RequestCitylist()
        request.country_id = countryId
        AppWebApi.cityList(params: request) { (response) in
            self.arrForForOriginalData.removeAll()
            self.arrForFilteredData.removeAll()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.cityList {
                    self.arrForForOriginalData.append(data)
                    self.arrForFilteredData.append(data)
                }
                self.reloadTableDateToFitHeight(tableView: self.tableView)
            }
        }
    }


}

