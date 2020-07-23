//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class PriceLocationVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    @IBOutlet weak var btnSubmit: ThemeButton!
    @IBOutlet weak var txtSearchBar: ThemeTextField!
    @IBOutlet weak var searchVw: UIView!

    var arrForFilteredData: [PricingLocation] = []
    var arrForForOriginalData: [PricingLocation] = []
     var selectedData: PricingLocation? = nil
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
        self.addBottomFade()
        self.addTopFade()
        self.wsGetLocationList()
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
           self.vwBg?.layoutIfNeeded()
           self.vwBg?.setRound()
           self.tableView?.reloadData({
           })
            self.searchVw.setRound(withBorderColor: .clear, andCornerRadious: self.searchVw.bounds.height/2.0, borderWidth: 1.0)
           self.btnSubmit?.setHighlighted(isHighlighted: true)
           self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)
        }
    }

    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.setupSearchbar(searchBar: self.txtSearchBar)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "PRICE_AND_LOCATION_TITLE".localized())
        self.lblEmptyTitle.text = "NO_LOCATION_TITLE".localized()
        self.lblEmptyMsg.text = "NO_LOCATION_MSG".localized()
        self.btnSubmit?.setTitle("BTN_PROCEED".localized(), for: .normal)
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setHighlighted(isHighlighted: true)
        self.btnBack.setBackButton()
    }

    @IBAction func btnBackTapped(_ sender: Any) {
         _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.openLocationServiceDialog()
    }

    func updateUI()  {
        if arrForForOriginalData.isEmpty {
            self.vwForEmpty.isHidden = false
            self.tableView.isHidden = true
            self.btnSubmit.isHidden = true
        } else {
            self.vwForEmpty.isHidden = true
            self.tableView.isHidden = false
            self.btnSubmit.isHidden = false
        }
        self.tableView.reloadData()
    }
    func openLocationServiceDialog() {
        if selectedData == nil {
            Common.showAlert(message: "VALIDATION_MSG_PLEASE_SELECT_LOCATION".localized())
            return
        }
        let locationServiceDialog: CustomLocationServiceDialog  = CustomLocationServiceDialog.fromNib()
        locationServiceDialog.initialize(title: selectedData!.name, buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        
        
        locationServiceDialog.show(animated: true)
        locationServiceDialog.onBtnCancelTapped = {
            [weak locationServiceDialog, weak self] in
            guard let self = self else { return } ; print(self)
            locationServiceDialog?.dismiss()
        }
        locationServiceDialog.onBtnDoneTapped = {
            [weak locationServiceDialog, weak self]  in
            guard let self = self else { return } ; print(self)
            locationServiceDialog?.dismiss()
        }
        
       
    }


}


extension PriceLocationVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func reloadTableDateToFitHeight(tableView: UITableView) {
        DispatchQueue.main.async {

            tableView.reloadData {

            }
            self.updateUI()
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
        tableView.register(PriceLocationTblCell.nib()
            , forCellReuseIdentifier: PriceLocationTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForFilteredData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: PriceLocationTblCell.name, for: indexPath) as?  PriceLocationTblCell
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


extension PriceLocationVC : UITextFieldDelegate {

    private func setupSearchbar(searchBar: UITextField) {
        txtSearchBar.delegate = self
        txtSearchBar.setFont(name: FontName.Regular, size: FontSize.textField_20)
        txtSearchBar.addTarget(self, action: #selector(searching(_:)), for: .editingChanged)
        txtSearchBar.changePlaceHolder(color: UIColor.themePrimary)
        txtSearchBar.placeholder = "PRICE_AND_LOCATION_TXT_SEARCH_LOCATION".localized()

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

//MARK:- Web Service Calls
extension PriceLocationVC {

    func wsGetLocationList() {
        Loader.showLoading()
        AppWebApi.locationList() { (response) in
            self.arrForForOriginalData.removeAll()
            self.arrForFilteredData.removeAll()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.locationList {
                    self.arrForForOriginalData.append(data)
                    self.arrForFilteredData.append(data)
                }
                self.reloadTableDateToFitHeight(tableView: self.tableView)
            }
            Loader.hideLoading()
        }
    }
}
