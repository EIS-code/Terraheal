//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



struct PackDetail {
    var code: String = ""
    var name: String = ""
    var description: String = ""
    var isSelected: Bool = false
}

class PackVC: MainVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: ThemeButton!
    
    var arrForData: [PackDetail] = [PackDetail.init(code:"9S75894",name: "terra heal massage center", description: "five 60 min massages"),PackDetail.init(code:"ABCDEF",name: "terra heal therapy center", description: "FLAT 50 % OFF")
        
    ]
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
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setupFilledButton()
        
    }
    
    
    
    
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        btnSubmit.isEnabled = false
        self.openBuyPackDialog()
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
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
            Common.appDelegate.loadCompleteVC(data: CompletionData.init(strHeader: "PACK_PURCHASE_COMPLETE_TITLE".localized(), strMessage: "PACK_PURCHASE_COMPLETE_MESSAGE".localized(), strImg: ImageAsset.Completion.bookingCompletion, strButtonTitle: "EVENT_BOOKING_BTN_HOME".localized()))
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
            Common.appDelegate.loadCompleteVC(data: CompletionData.init(strHeader: "PACK_PURCHASE_COMPLETE_TITLE".localized(), strMessage: "PACK_PURCHASE_COMPLETE_MESSAGE".localized(), strImg: ImageAsset.Completion.bookingCompletion, strButtonTitle: "EVENT_BOOKING_BTN_HOME".localized()))
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

