//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


//MARK: Massage Preference Menu
enum AddVoucherMenu: String {
    
    case Location = "1"
    case Service = "2"
    case Design = "3"
    case RecipientDetail = "4"
    case GiverDetail = "5"
    case SendingPreference = "6"
    func name() -> String {
        switch self {
        case .Location:
            return "ADD_GIFT_VOUCHER_LOCATION_DETAIL".localized()
        case .Service:
            return  "ADD_GIFT_VOUCHER_SERVICE_DETAIL".localized()
        case .Design:
            return  "ADD_GIFT_VOUCHER_DESIGN_DETAIL".localized()
        case .RecipientDetail:
            return  "ADD_GIFT_VOUCHER_RECIPIENT_DETAIL".localized()
        case .GiverDetail:
            return "ADD_GIFT_VOUCHER_GIVER_DETAIL".localized()
        case .SendingPreference:
            return  "ADD_GIFT_VOUCHER_SENDING_PREFERENCE_DETAIL".localized()
        }
    }
    func placeHolder() -> String {
        switch self {
        case .Location:
            return "ADD_GIFT_VOUCHER_LOCATION_DETAIL_PLACEHOLDER".localized()
        case .Service:
            return  "ADD_GIFT_VOUCHER_SERVICE_DETAIL_PLACEHOLDER".localized()
        case .Design:
            return  "ADD_GIFT_VOUCHER_DESIGN_DETAIL_PLACEHOLDER".localized()
        case .RecipientDetail:
            return  "ADD_GIFT_VOUCHER_RECIPIENT_DETAIL_PLACEHOLDER".localized()
        case .GiverDetail:
            return "ADD_GIFT_VOUCHER_GIVER_DETAIL_PLACEHOLDER".localized()
        case .SendingPreference:
            return  "ADD_GIFT_VOUCHER_SENDING_PREFERENCE_DETAIL_PLACEHOLDER".localized()
        }
    }
    
    func image() -> String {
        return ""
    }
}

struct AddVouncherMenuDetail {
    var type: AddVoucherMenu = AddVoucherMenu.Location
    var value: String = ""
    var isSelected: Bool = false
}

class AddGiftVoucherVC: MainVC {
    
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnPreview: ThemeButton!
    @IBOutlet weak var lblSubTotal: ThemeLabel!
    @IBOutlet weak var lblSubtotalValue: ThemeLabel!
    
    var arrForData: [AddVouncherMenuDetail] = [
        AddVouncherMenuDetail(type: .Location, value: "".localized(),  isSelected: true),
        AddVouncherMenuDetail(type: .Service, value: "".localized(),  isSelected: false),
        AddVouncherMenuDetail(type: .Design, value: "".localized(),  isSelected: false),
        AddVouncherMenuDetail(type: .RecipientDetail, value: "".localized(),  isSelected: false),
        AddVouncherMenuDetail(type: .GiverDetail, value: "".localized(),  isSelected: false),
        AddVouncherMenuDetail(type: .SendingPreference, value: "".localized(),  isSelected: false),
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
            btnPreview.layoutIfNeeded()
            btnPreview.setHighlighted(isHighlighted: true)
        }
    }
    
    private func initialViewSetup() {
        self.setupTableView(tableView: self.tableView)
        self.lblSubTotal.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblSubtotalValue.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.lblSubTotal.text  = "ADD_GIFT_VOUCHER_SUBTOTAL".localized()
        self.setTitle(title: "HOW_IT_WORK_TITLE".localized())
        self.btnBack.setBackButton()
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        _ = (self.navigationController as? NC)?.popVC()
    }
    @IBAction func btnPreviewTapped(_ sender: Any) {
    }
    
}


extension AddGiftVoucherVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(AddGiftVoucherCell.nib()
            , forCellReuseIdentifier: AddGiftVoucherCell.name)
        tableView.tableFooterView = UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AddGiftVoucherCell.name, for: indexPath) as?  AddGiftVoucherCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedData = self.arrForData[indexPath.row]
        let type = selectedData.type
        tableView.reloadData()
        switch type{
        case .Location:
            self.openCenterSelectionDialog()
        case .Service:
            self.openServiceSelectionDialog()
            //self.openPackSelectionDialog()
        case .Design:
            self.openCenterSelectionDialog()
        case .RecipientDetail:
            self.openRecipientDetailDialog()
            
        case .GiverDetail:
            self.openGiverDetailDialog()
            
        case .SendingPreference:
            self.openSendingPreferenceDialog()
        default:
            self.openGiverDetailDialog()
        }
    }
    
}

extension AddGiftVoucherVC {
    func openGiverDetailDialog() {
           let alert: CustomGiverDetailDialog = CustomGiverDetailDialog.fromNib()
           alert.initialize(title: "giver details", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
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
               self.tableView.reloadData()
           }
       }
       func openSendingPreferenceDialog() {
           let alert: CustomSendingPreferenceDialog = CustomSendingPreferenceDialog.fromNib()
           alert.initialize(title: "sending preference", data: "email", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
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
               self.tableView.reloadData()
           }
       }
       
       func openRecipientDetailDialog() {
           let alert: CustomRecipientDetailDialog = CustomRecipientDetailDialog.fromNib()
           alert.initialize(title: "recipients details", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
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
               self.tableView.reloadData()
           }
       }
    func openCenterSelectionDialog() {
             
             let alert: CustomServiceCenterLocationSelectionDialog = CustomServiceCenterLocationSelectionDialog.fromNib()
             alert.initialize(title: "location", buttonTitle: "select")
             alert.show(animated: true)
             alert.onBtnCancelTapped = {
                 [weak alert, weak self] in
                 alert?.dismiss()
                 guard let self = self else { return } ; print(self)
                 
                 
             }
             alert.onBtnDoneTapped = {
                 [weak alert, weak self] in
                 alert?.dismiss()
                 guard let self = self else { return } ; print(self)
                self.arrForData[0].value = "Terre Heal"
                self.tableView.reloadData()
                
             }
             
             
         }
    
    func openServiceSelectionDialog() {
        let serviceSelectionDialog: ServiceSelectionDialog  = ServiceSelectionDialog.fromNib()
        serviceSelectionDialog.initialize(title: arrForData[0].value, buttonTitle: "BTN_BOOK_HERE".localized())
        serviceSelectionDialog.show(animated: true)
        serviceSelectionDialog.onBtnCancelTapped = {
            [weak serviceSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            serviceSelectionDialog?.dismiss()
        }
        serviceSelectionDialog.onBtnDoneTapped = {
            [weak serviceSelectionDialog, weak self]  in
            guard let self = self else { return } ; print(self)
            serviceSelectionDialog?.dismiss()
           
        }
    }
}
