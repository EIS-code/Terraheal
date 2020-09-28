//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



struct PackDetail {
    var code: String = ""
    var name: String = ""
    var price: String = ""
    var date: String = "expiry date: 10 dec, 2020"
    var description: String = ""
    var isSelected: Bool = false
}

class PackVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: FilledRoundedButton!
    @IBOutlet weak var btnUseThisPack: RoundedBorderButton!
    var selectedData: PurchasedPackage? = nil
    var arrForOriginalData: [PurchasedPackage] = []
    var arrForData: [PackDetail] = []
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
        self.setupTableView(tableView: self.tableView)
        self.setTitle(title: "PACK_TITLE".localized())
        self.btnSubmit?.setTitle("PACK_BTN_BUY_NEW".localized(), for: .normal)
        self.btnUseThisPack?.setTitle("PACK_BTN_USE_THIS_PACK".localized(), for: .normal)
        self.wsGetPurchasePackList()
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        btnSubmit.isEnabled = false
        self.openBuyPackDialog()
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    @IBAction func btnUseThisPackTapped(_ sender: Any) {
        if let selectedPackage = selectedData {
                Common.appDelegate.loadPackageDetailVC(navigaionVC: self.navigationController, data: selectedPackage)
        } else {
            Common.showAlert(message: "Please select package first")
        }
        
    }
    
}


extension PackVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 250
        tableView.register(PackTblCell.nib()
            , forCellReuseIdentifier: PackTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PackTblCell.name, for: indexPath) as?  PackTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        for i in 0..<arrForData.count {
            self.arrForData[i].isSelected = false
        }
        self.arrForData[indexPath.row].isSelected = true
        self.selectedData = self.arrForOriginalData[indexPath.row]
        self.tableView.reloadData()
    }
    
    
    
    func openBuyPackForSelfDialog() {
        let alert: AddPackDialog = AddPackDialog.fromNib()
        alert.initialize(title: "ADD_PACK_DIALOG_TITLE".localized(), buttonTitle: "PACK_BTN_PROCEED_TO_BUY".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.setDataSource(data: AddPackageDetail.getDemoArrayForSelf())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (data) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            appSingleton.myBuyPackageData = data
            Common.appDelegate.loadReviewAndBookPackVC()
        }
    }
    
    func openBuyPackForGiftDialog() {
        let alert: AddPackDialog = AddPackDialog.fromNib()
        alert.initialize(title: "ADD_PACK_DIALOG_TITLE".localized(), buttonTitle: "PACK_BTN_PROCEED_TO_BUY".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.setDataSource(data: AddPackageDetail.getDemoArrayForGift())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (data) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            appSingleton.myBuyPackageData = data
            Common.appDelegate.loadReviewAndBookPackVC()
        }
    }
    
    func openBuyPackDialog() {
        
        let alert: BuyPackageDialog = BuyPackageDialog.fromNib()
        alert.initialize(title: "BUY_PACK_DIALOG_TITLE".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (data) in
            alert?.dismiss()
            guard let self = self else { return } ; print(self)
            self.btnSubmit.isEnabled = true
            if (data.id == 0) {
                self.openBuyPackForSelfDialog()
            } else {
                self.openBuyPackForGiftDialog()
            }
        }
    }
}


extension PackVC {
    func wsGetPurchasePackList() {
     
        AppWebApi.getPurchasedPackageList { (response) in
            self.arrForData.removeAll()
            if ResponseModel.isSuccess(response: response) {
                self.arrForOriginalData = response.dataList
                for data in self.arrForOriginalData {
                    self.arrForData.append(data.toViewModel())
                }
                self.tableView.reloadData()
            } else {
               
            }
        }
    }
}

func wsGetPackageList(shopId:String) {
    
}
