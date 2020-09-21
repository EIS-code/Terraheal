//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class ManagePeopleVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAddNewPeople: FilledRoundedButton!
    
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    
    var arrForData: [People] = []
    var arrForGenderPreference: [PreferenceOption] = []
    // MARK: Object lifecycle
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    private func setup() {
        
        
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialViewSetup()
        
        self.wsGetPeoples()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tableView?.reloadData({
                
            })
        }
    }
    
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.setTitle(title: "MANAGE_PEOPLE_TITLE".localized())
        self.btnAddNewPeople?.setTitle("MANAGE_PEOPLE_BTN_ADD_NEW".localized(), for: .normal)
        self.lblEmptyTitle.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblEmptyMsg.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblEmptyTitle.text = "NO_PEOPLE_TITLE".localized()
        self.lblEmptyMsg.text = "NO_PEOPLE_MSG".localized()
        self.view.backgroundColor  = UIColor.themePrimaryLightBackground
    }
    
    func openAddPeopleDialog(index: Int = -1) {
        let alert: CustomAddPeopleDialog = CustomAddPeopleDialog.fromNib()
        if index == -1 {
            alert.initialize(title: "MANAGE_PEOPLE_BTN_ADD_NEW".localized(), data: nil, genderPreference: arrForGenderPreference, buttonTitle: "BTN_SAVE".localized(),cancelButtonTitle: "BTN_SKIP".localized())
            alert.select(gender: Gender.Male)
            
        } else {
            alert.initialize(title: self.arrForData[index].name, data: self.arrForData[index], genderPreference: arrForGenderPreference, buttonTitle: "BTN_SAVE".localized(),cancelButtonTitle: "BTN_SKIP".localized())
        }
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnAddNewPeople.isEnabled = true
            
        }
        alert.onBtnDeleteTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.wsDeletePeople(request: ManagePeople.RequestDeletePeople(id: self.arrForData[index].id))
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (people,doc) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnAddNewPeople.isEnabled = true
            if index == -1 {
                self.wsSavePeople(request: people.toAddRequest(), doc: doc)
                
            }else {
                self.wsUpdatePeople(request: people.toUpdateRequest(), doc: doc)
            }
        }
    }
 
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }
    @IBAction func btnAddNewPeopleTapped(_ sender: Any) {
        btnAddNewPeople.isEnabled = false
        self.openAddPeopleDialog()
    }
    
    func updateUI()  {
        if arrForData.isEmpty {
            self.vwForEmpty.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.vwForEmpty.isHidden = true
            self.tableView.isHidden = false
        }
        self.tableView.reloadData()
    }
}


extension ManagePeopleVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.backgroundColor = UIColor.themePrimaryLightBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ManagePeopleTblCell.nib()
            , forCellReuseIdentifier: ManagePeopleTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ManagePeopleTblCell.name, for: indexPath) as?  ManagePeopleTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.openAddPeopleDialog(index: indexPath.row)
        //self.openRateViewPicker(name: self.arrForData[indexPath.row].title)
    }
    
}


//MARK:- Web Service Calls
extension ManagePeopleVC {
    
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
    
    func wsUpdatePeople(request:ManagePeople.RequestUpdatePeople, doc: UploadDocumentDetail?) {
        Loader.showLoading()
        AppWebApi.updatePeople(params: request, image: doc, completionHandler: { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                if let index = (self.arrForData.firstIndex { (address) -> Bool in
                    address.id == request.id
                }) {
                    self.arrForData[index]  = response.people
                }
                self.tableView.reloadData()
                self.updateUI()
            }
            Loader.hideLoading()
        })
    }
    func wsDeletePeople(request:ManagePeople.RequestDeletePeople) {
        Loader.showLoading()
        AppWebApi.removePeople(params: request, completionHandler: { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                if let index = (self.arrForData.firstIndex { (people) -> Bool in
                    people.id == request.id
                }) {
                    self.arrForData.remove(at: index)
                }
                self.tableView.reloadData()
                self.updateUI()
            }
            Loader.hideLoading()
        })
    }
}
