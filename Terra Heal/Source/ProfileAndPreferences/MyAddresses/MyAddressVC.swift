//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class MyAddressVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!
    
    var arrForData: [Address] = []
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
        self.wsGetAddress()
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
            self.tableView?.contentInset = self.getGradientInset()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.setupTableView(tableView: self.tableView)
        self.setTitle(title: "MANAGE_ADDRESS_TITLE".localized())
        self.lblEmptyTitle.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblEmptyMsg.setFont(name: FontName.Regular, size: FontSize.label_12)
        self.lblEmptyTitle.text = "NO_ADDRESS_TITLE".localized()
        self.lblEmptyMsg.text = "NO_ADDRESS_MSG".localized()
        self.btnSubmit?.setTitle("MANAGE_ADDRESS_BTN_ADD_NEW_ADDRESS".localized(), for: .normal)
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.openNewAddressDialog()
    }
    
    func updateUI()  {
        if arrForData.isEmpty {
            self.setBackground(color: UIColor.themeBackground)
            self.vwForEmpty.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.setBackground(color: UIColor.themeLightBackground)
            self.vwForEmpty.isHidden = true
            self.tableView.isHidden = false
        }
        self.tableView.reloadData()
    }
    
    func openNewAddressDialog(index:Int = -1) {
        
        let alert: CustomAddNewAddressDialog = CustomAddNewAddressDialog.fromNib()
        var address: Address = Address.init(fromDictionary: [:])
        if index != -1 {
            address = arrForData[index]
        }
        alert.initialize(title: self.btnSubmit.title(for: .normal) ?? "", data: address, buttonTitle: "BTN_SAVE".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (address) in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
            if index == -1 {
                self.wsSaveAddress(request: address.toAddRequest())
                
            } else {
                self.wsUpdateAddress(request: address.toUpdateRequest())
            }
            self.updateUI()
        }
    }
    
    func openConfirmationDialog(index:Int) {
        
        let alert: CustomAlertConfirmation = CustomAlertConfirmation.fromNib()
        
        alert.initialize(title: "Remove Address", message: "Are you you want to delete this address",buttonTitle: "Ok", cancelButtonTitle: "Cancel")
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
            alert?.dismiss()
            guard  let self = self else {
                return
            }
            self.wsRemoveAddress(request: Addresses.RequestDeleteAddress.init(id: self.arrForData[index].id))
        }
    }
    @objc func removeAddress(button: UIButton) {
        self.openConfirmationDialog(index: button.tag)
    }
    @objc func editAddress(button: UIButton) {
        self.openNewAddressDialog(index: button.tag)
    }
}


extension MyAddressVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(MyAddressTblCell.nib()
            , forCellReuseIdentifier: MyAddressTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: MyAddressTblCell.name, for: indexPath) as?  MyAddressTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.btnEdit.tag = indexPath.row
        cell?.btnDelete.tag = indexPath.row
        cell?.btnDelete.addTarget(self, action: #selector(removeAddress(button:)), for: .touchUpInside)
        cell?.btnEdit.addTarget(self, action: #selector(editAddress(button:)), for: .touchUpInside)
        cell?.layoutIfNeeded()
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.openNewAddressDialog(index: indexPath.row)
    }
    
}


//MARK:- Web Service Calls
extension MyAddressVC {
    
    func wsGetAddress() {
        Loader.showLoading()
        AppWebApi.getAddress { (response) in
            self.arrForData.removeAll()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.addressList {
                    self.arrForData.append(data)
                }
                self.tableView.reloadData()
            }
            self.updateUI()
            Loader.hideLoading()
        }
        
    }
    
    func wsSaveAddress(request:Addresses.RequestAddAddress) {
        AppWebApi.addAddress(params: request, completionHandler: { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                self.arrForData.append(response.address)
                self.tableView.reloadData()
                self.updateUI()
            }
            Loader.hideLoading()
        })
    }
    func wsUpdateAddress(request:Addresses.RequestUpdateAddress) {
        AppWebApi.updateAddress(params: request, completionHandler: { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                if let index = (self.arrForData.firstIndex { (address) -> Bool in
                    address.id == request.id
                }) {
                    self.arrForData[index]  = response.address
                }
                self.tableView.reloadData()
                self.updateUI()
            }
            Loader.hideLoading()
        })
    }
    func wsRemoveAddress(request:Addresses.RequestDeleteAddress) {
        AppWebApi.removeAddress(params: request, completionHandler: { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                if let index = (self.arrForData.firstIndex { (address) -> Bool in
                    address.id == request.id
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
