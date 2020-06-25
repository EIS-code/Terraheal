//
//  CustomAlert.swift
//  ModalView
//
//  Created by Aatish Rajkarnikar on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit




class CustomCountyPhoneCodePicker: ThemeBottomDialogView {

    @IBOutlet weak var lblTitle: ThemeLabel!
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var txtSearchBar: ThemeTextField!

    var onBtnDoneTapped: ((_ data: CountryPhone) -> Void)? = nil
    var selectedData: CountryPhone? = nil

    var arrForFilteredData: [CountryPhone] = CountryPhone.modelsFromDictionaryArray()
    var arrForForOriginalData: [CountryPhone] = CountryPhone.modelsFromDictionaryArray()
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
        self.btnDone.isHidden = true
        self.btnCancel.isHidden = true
        self.select(data: self.selectedData)
        self.setupTableView(tableView: self.tableView)
        self.setupSearchbar(searchBar: self.txtSearchBar)
    }

    func select(data:CountryPhone?) {
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

extension CustomCountyPhoneCodePicker : UITableViewDelegate,UITableViewDataSource {

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
        tableView.register(CustomCountyPhoneCodePickerCell.nib()
            , forCellReuseIdentifier: CustomCountyPhoneCodePickerCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForFilteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCountyPhoneCodePickerCell.name, for: indexPath) as?  CustomCountyPhoneCodePickerCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForFilteredData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedData = self.arrForFilteredData[indexPath.row]
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

extension CustomCountyPhoneCodePicker : UITextFieldDelegate {

    private func setupSearchbar(searchBar: UITextField) {
        txtSearchBar.delegate = self
        txtSearchBar.setFont(name: FontName.Regular, size: FontSize.label_14)
        txtSearchBar.addTarget(self, action: #selector(searching(_:)), for: .editingChanged)
        txtSearchBar.changePlaceHolder(color: UIColor.themePrimary)
        txtSearchBar.placeholder = "PROFILE_TXT_SEARCH_COUNTRY".localized()
    }

    func searchData(for text: String) {
        if text.isEmpty {
            self.arrForFilteredData.removeAll()
            for data in self.arrForForOriginalData {
                self.arrForFilteredData.append(data)
            }
        } else {
            self.arrForFilteredData.removeAll()
            for data: CountryPhone in self.arrForForOriginalData {

                if data.countryName.lowercased().hasPrefix(text.lowercased()) {
                    self.arrForFilteredData.append(data)
                }
            }
        }
        self.reloadTableDateToFitHeight(tableView: tableView)
    }

    @IBAction func searching(_ sender: UITextField) {
        searchData(for: sender.text ?? "")
    }
}



public class CountryPhone:NSObject
{
    public var countryPhoneCode : String!
    public var countryName : String!
    public var countryCode : String!
    public var phoneNumberLength : Int!
    public var phoneNumberMinLength : Int!
    public var countryFlag : String!

    public class func modelsFromDictionaryArray() -> [CountryPhone]
    {
        var models:[CountryPhone] = []

        guard let path = Bundle.main.path(forResource: "country_list", ofType: "json") else
        {
            return  []

        }
        let url = URL(fileURLWithPath: path)

        do {

            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            //print(json)

            guard let array = json as? [Any] else
            {
                return []
            }
            for country in array
            {
                models.append(CountryPhone(dictionary: country as! [String:Any])!)
            }
        }
        catch {
            print(error)
        }

        return models
    }

    required public init?(dictionary: [String:Any])
    {
        countryPhoneCode = (dictionary["country_phone_code"] as? String) ?? "+91"
        countryName = (dictionary["country_name"] as? String) ?? "India"
        countryCode = (dictionary["country_code"] as? String) ?? "INR"
        phoneNumberMinLength = (dictionary["minimum_phone_number_length"] as? Int) ?? 8
        phoneNumberLength = (dictionary["maximum_phone_number_length"] as? Int) ?? 10
        countryFlag = (dictionary["country_flag"] as? String) ?? "INR"


    }


}
