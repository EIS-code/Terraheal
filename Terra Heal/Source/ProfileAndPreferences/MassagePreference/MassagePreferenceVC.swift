//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


//MARK: Massage Preference Menu
enum MassagePreferenceMenu: String {
    case Pressure = "1"
    case GenderPreference = "2"
    case TreatMent = "3"
    case Problems = "4"
    case PastSurgery = "5"
    case Allergies = "6"
    case HealthCondition = "7"
    func name() -> String {
        switch self {
        case .Pressure:
            return "MASSAGE_PREFERENCE_MENU_ITEM_1".localized()
        case .GenderPreference:
            return  "MASSAGE_PREFERENCE_MENU_ITEM_2".localized()
        case .TreatMent:
            return  "MASSAGE_PREFERENCE_MENU_ITEM_3".localized()
        case .Problems:
            return  "MASSAGE_PREFERENCE_MENU_ITEM_4".localized()
        case .PastSurgery:
            return  "MASSAGE_PREFERENCE_MENU_ITEM_5".localized()
        case .Allergies:
            return  "MASSAGE_PREFERENCE_MENU_ITEM_6".localized()
        case .HealthCondition:
            return  "MASSAGE_PREFERENCE_MENU_ITEM_7".localized()
        }
    }

}




class MassagePreferenceVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: ThemeButton!

    var arrForMenu: [MassagePreferenceDetail] = []
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
        
        self.wsGetMassagePreferenceList()

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
           
            self.btnSubmit?.setHighlighted(isHighlighted: true)
        }


    }
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.setTitle(title: "MASSAGE_PREFERENCE_TITLE".localized())
        self.btnSubmit.setTitle("BTN_SUBMIT".localized(), for: .normal)
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setHighlighted(isHighlighted: true)
        self.btnBack.setBackButton()
    }

    func openMassagerPressurePicker(index:Int = 0) {
        let alert: CustomPressurePicker = CustomPressurePicker.fromNib()

        alert.initialize(title: arrForMenu[index].name, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.setDataSource(data: arrForMenu[index])
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
             [weak alert, weak self] (preferenceData) in
             guard let self = self else { return } ; print(self)
            alert?.dismiss()
            appSingleton.myMassagePreference.pressure = preferenceData
            self.arrForMenu[index].isSelected = true
            self.arrForMenu[index].selectedPreference = preferenceData
            var request: MassagePreference.SaveMassagePrefenceList = MassagePreference.SaveMassagePrefenceList()
            request.data = [MassagePreference.PreferenceData.init(id: preferenceData.id, value: "")]
            self.wsSaveMassagePreferenceList(request: request)
        }
    }

    func openPreferGenderPicker(index:Int = 0) {
        let alert: CustomPreferGenderPicker = CustomPreferGenderPicker.fromNib()
        alert.initialize(title: arrForMenu[index].name, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.setDataSource(data: arrForMenu[index].preferenceOptions)
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (preferenceData) in
             guard let self = self else { return } ; print(self)

            alert?.dismiss()
            self.arrForMenu[index].isSelected = true
            self.arrForMenu[index].selectedPreference = preferenceData
            var request: MassagePreference.SaveMassagePrefenceList = MassagePreference.SaveMassagePrefenceList()
            request.data = [MassagePreference.PreferenceData.init(id: preferenceData.id, value: "")]
            self.wsSaveMassagePreferenceList(request: request)
        }
    }

    func openTextViewPicker(index:Int = 0) {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
        alert.initialize(title: arrForMenu[index].name
            , data: arrForMenu[index].selectedPreference.value, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            self.arrForMenu[index].isSelected = true
            self.arrForMenu[index].selectedPreference.value = description
            var request: MassagePreference.SaveMassagePrefenceList = MassagePreference.SaveMassagePrefenceList()
            request.data = [MassagePreference.PreferenceData.init(id: self.arrForMenu[index].preferenceOptions.first?.id ?? self.arrForMenu[index].id, value: description)]
            self.wsSaveMassagePreferenceList(request: request)
            //self.tableView.reloadData()
        }
    }

    @IBAction func btnBackTapped(_ sender: Any) {
         _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }


}


extension MassagePreferenceVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(MassagePreferenceTblCell.nib()
            , forCellReuseIdentifier: MassagePreferenceTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForMenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MassagePreferenceTblCell.name, for: indexPath) as?  MassagePreferenceTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForMenu[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let massagePreference = self.arrForMenu[indexPath.row]
        switch massagePreference.type {
        case .Pressure:
            self.openMassagerPressurePicker(index: indexPath.row)
        case .GenderPreference:
            self.openPreferGenderPicker(index: indexPath.row)
        case .TreatMent:
            self.openTextViewPicker(index: indexPath.row)
        case .Problems:
            self.openTextViewPicker(index: indexPath.row)
        case .PastSurgery:
            self.openTextViewPicker(index: indexPath.row)
        case .Allergies:
            self.openTextViewPicker(index: indexPath.row)
        case .HealthCondition:
            self.openTextViewPicker(index: indexPath.row)
        }
    }
    
}

//MARK: Web Service Call
extension MassagePreferenceVC {
    func wsGetMassagePreferenceList() {
        
        Loader.showLoading()
        AppWebApi.massagePreferencceList { (response) in
                self.arrForMenu.removeAll()
                if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                    for data in response.massagePreferenceList {
                        self.arrForMenu.append(data)
                    }
                    self.tableView.reloadData()
                }
                Loader.hideLoading()
        }
    }
    
    func wsSaveMassagePreferenceList(request:MassagePreference.SaveMassagePrefenceList) {
       
        AppWebApi.saveMassagePreferencceList(params: request) { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                self.tableView.reloadData()
            }
            Loader.hideLoading()
        }
        
    }
}
