//
//  CustomAlert.swift
//  ModalView
//
//  Created by Jaydeep Vyas on 3/20/17.
//  Copyright © 2017 Aatish. All rights reserved.
//

import UIKit



class RecipientSelectionDialog: ThemeBottomDialogView {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    
    var onBtnDoneTapped: ((_ data:People) -> Void)? = nil
    var selectedData:People = People.init(fromDictionary: [:])
    var arrForData: [People] = []
    var arrForGenderPreference: [PreferenceOption] = []
    
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
        self.wsGetPeoples()
    }
    
    func select(data:People) {
        self.selectedData = data
        for i in 0..<arrForData.count {
            arrForData[i].isSelected = false
            if arrForData[i].id == data.id {
                arrForData[i].isSelected = true
            }
        }
        self.tableView.reloadData()
    }
    
    func setDataSource(data: [People]) {
        self.arrForData.removeAll()
        for value in data {
            self.arrForData.append(value)
            if value.isSelected {
                self.selectedData = value
            }
        }
        self.reloadTableDateToFitHeight(tableView: self.tableView)
        //self.select(data: self.selectedData)
    }
    override func initialSetup() {
        super.initialSetup()
        self.lblTitle.setFont(name: FontName.SemiBold, size: FontSize.button_22)
        self.setDataForStepUpAnimation()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.reloadTableDateToFitHeight(tableView: self.tableView)
    }
    
    @IBAction func btnDoneTapped(_ sender: Any) {
        self.openAddPeopleDialog()
    }
    
    func openAddPeopleDialog() {
        
        let alert: CustomAddPeopleDialog = CustomAddPeopleDialog.fromNib()
        alert.initialize(title: "MANAGE_PEOPLE_BTN_ADD_NEW".localized(), data: nil, genderPreference: arrForGenderPreference, buttonTitle: "BTN_SAVE".localized(),cancelButtonTitle: "BTN_SKIP".localized())
        alert.select(gender: Gender.Male)
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.btnDone.isEnabled = true
            
        }
        alert.onBtnDeleteTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (people,doc) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.btnDone.isEnabled = true
            self.wsSavePeople(request: people.toAddRequest(), doc: doc)
        }
        
    }
    
}

extension RecipientSelectionDialog : UITableViewDelegate,UITableViewDataSource {
    
    private func reloadTableDateToFitHeight(tableView: UITableView) {
        self.tableView.reloadData(heightToFit: self.hTblVw, maxHeight: self.dialogView.bounds.height * 0.5) {
            
        }
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(RecipientTblCell.nib()
            , forCellReuseIdentifier: RecipientTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipientTblCell.name, for: indexPath) as?  RecipientTblCell
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
            self.onBtnDoneTapped!(selectedData);
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}




extension RecipientSelectionDialog {
    func updateUI()  {
        if arrForData.isEmpty {
            self.tableView.isHidden = true
        } else {
            self.tableView.isHidden = false
        }
        self.reloadTableDateToFitHeight(tableView: self.tableView)
    }
    func wsSavePeople(request:ManagePeople.RequestAddPeoples, doc: UploadDocumentDetail?) {
           Loader.showLoading()
           AppWebApi.addPeople(params: request, image: doc, completionHandler: { (response) in
                   if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                       self.arrForData.append(response.people)
                       self.tableView.reloadData()
                       self.updateUI()
                   }
                   Loader.hideLoading()
           })
       }
    func wsGetPeoples() {
        Loader.showLoading()
        AppWebApi.getPeopleList { (response) in
            self.arrForData.removeAll()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.peopleList {
                    self.arrForData.append(data)
                }
                for data in response.preferenceOptions {
                    self.arrForGenderPreference.append(data)
                }
                self.tableView.reloadData()
               
            }
            self.updateUI()
            Loader.hideLoading()
        }
    }
}
