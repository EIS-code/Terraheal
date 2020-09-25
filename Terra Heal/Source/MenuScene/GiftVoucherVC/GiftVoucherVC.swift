//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



class GiftVoucherVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnBuyGiftVoucher: FilledRoundedButton!
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMessage: ThemeLabel!
    @IBOutlet weak var btnBuyNow: FilledRoundedButton!
    @IBOutlet weak var vwForBuyGiftInfo: UIView!
    
    @IBOutlet weak var lblBody: ThemeLabel!
    @IBOutlet weak var lblSubHeader: ThemeLabel!
    @IBOutlet weak var lblHeader: ThemeLabel!
    var arrForData: [Voucher] = []
    
    @IBOutlet weak var btnGetStarted: FilledRoundedButton!
    
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
        self.wsGetVoucherInfo()
        self.wsGetVoucherList()
        self.arrForData.removeAll()
        self.updateUI()
        self.btnGetStarted.isHidden = true
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
            self.view.layoutIfNeeded()
            self.tableView?.reloadData({
                self.tableView.contentInset = self.getGradientInset()
            })
            
        }
    }
    
    @IBAction func btnBuyNowTapped(_ sender: Any) {
        
        /*self.arrForData = []
        self.updateUI()
        self.btnBuyGiftVoucher.isHidden = false
        self.btnBuyNow.isHidden = true*/
        
        updateUIForInformation()
    }
    
    @IBAction func btnBuyGiftVoucherTapped(_ sender: Any) {
        updateUIForInformation()
    }
    
    @IBAction func btnGetStartedTapped(_ sender: Any) {
        Common.appDelegate.loadAddGiftVoucherVC(navigaionVC: self.navigationController)
    }
    
    func updateUIForInformation() {
        vwForEmpty.gone()
        tableView.gone()
        vwForBuyGiftInfo.visible()
        btnGetStarted.visible()
    }
    
    private func initialViewSetup() {
        self.setTitle(title: "GIFT_VOUCHER_TITLE".localized())
        self.setupTableView(tableView: self.tableView)
        self.lblHeader.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblSubHeader.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblBody.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblEmptyTitle.text = "GIFT_VOUCHER_EMPTY_TITLE".localized()
        self.lblEmptyTitle.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblEmptyMessage.setFont(name: FontName.Regular, size: FontSize.detail)
        self.btnBuyGiftVoucher?.setTitle("GIFT_VOUCHER_BTN_BUY_GIFT_VOUCHER".localized(), for: .normal)
        self.btnBuyNow?.setTitle("GIFT_VOUCHER_BTN_BUY_NOW".localized(), for: .normal)
        self.btnGetStarted?.setTitle("GIFT_VOUCHER_BTN_GET_STARTED".localized(), for: .normal)
    }
    
    
    // MARK: - Action Methods
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
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


extension GiftVoucherVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.bounds.height / 2.0
        tableView.register(GiftVoucherTblCell.nib()
            , forCellReuseIdentifier: GiftVoucherTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GiftVoucherTblCell.name, for: indexPath) as?  GiftVoucherTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        Common.appDelegate.loadGiftVoucherDetailVC(navigaionVC: self.navigationController, data: self.arrForData[indexPath.row])
    }
    
    func completeVoucher() {
        Common.appDelegate.loadCompleteVC(data: CompletionData.init(strHeader: "BUY_GIFT_VOUCHER_COMPLETE_TITLE".localized(), strMessage: "BUY_GIFT_VOUCHER_COMPLETE_MESSAGE".localized(), strImg: ImageAsset.Completion.requestBookingCompletion, strButtonTitle: "HOME_BTN_HOME".localized()))
    }
}

extension GiftVoucherVC {
    func wsGetVoucherInfo() {
        Loader.showLoading()
        AppWebApi.getGiftVoucherInfo { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.lblHeader.text = response.voucherInfo.title //"GIFT_VOUCHER_HEADER".localized()
                self.lblSubHeader.text = response.voucherInfo.shortDescription//"GIFT_VOUCHER_SUB_HEADER".localized()
                self.lblBody.text = response.voucherInfo.detail//"GIFT_VOUCHER_BODY".localized()
            }
        }
    }
    
    func wsGetVoucherList() {
        Loader.showLoading()
        AppWebApi.getGiftVoucherList { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForData = response.voucherList
                self.tableView.reloadData()
                self.updateUI()
            }
        }
    }
}
