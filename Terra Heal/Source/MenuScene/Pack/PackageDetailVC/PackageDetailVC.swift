//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




struct SubPackageDetail {
    var code: String = ""
    var name: String = ""
    var price: String = ""
    var date: String = "expiry date: 10 dec, 2020"
    var description: String = ""
    var isUsed: Bool = false
}

class PackageDetailVC: BaseVC {
    

    
    
    
    @IBOutlet weak var tableView: UITableView!
    var packageDetail: PackDetail? = nil
    var arrForData: [SubPackageDetail] = [
        SubPackageDetail.init(code:"9S75894",name: "\"free from pain\"", price: "€250.00", description: "5 Massages & Therapies of 60 mins",isUsed: false),
        SubPackageDetail.init(code:"12345640",name: "\"THE MAGIC OF ORIENT\"", price: "€450.00", description: "10 Different Oriental Massages & Therapies",isUsed: false),
        SubPackageDetail.init(code:"12345640",name: "\"THE MAGIC OF ORIENT\"", price: "€450.00", description: "10 Different Oriental Massages & Therapies",isUsed: true),
        SubPackageDetail.init(code:"12345640",name: "\"THE MAGIC OF ORIENT\"", price: "€450.00", description: "10 Different Oriental Massages & Therapies",isUsed: true),
        SubPackageDetail.init(code:"12345640",name: "\"THE MAGIC OF ORIENT\"", price: "€450.00", description: "10 Different Oriental Massages & Therapies",isUsed: true)
    ]
    
    var sessionSelectionDialog: SessionDialog!
    var recipentMassageManageDialog: RecipentMassageManageDialog!
    var dialogForAccessory: AccessorySelectionDialog!
    var dateTimeSelectionDialog: DateTimeDialog!
    var textViewDialog: TextViewDialog!
    var languagePicker: CustomLanguagePicker!
    
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
        }
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    private func initialViewSetup() {
        self.setupTableView(tableView: self.tableView)
        self.setTitle(title: "PACK_NO".localized() + " : " + packageDetail!.code)
    }
    
}

//MARK: - PackageDetailVC

extension PackageDetailVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = tableView.bounds.height / 2.0
        tableView.register(BookPackageCell.nib()
            , forCellReuseIdentifier: BookPackageCell.name)
        tableView.register(UsedPackageCell.nib()
            , forCellReuseIdentifier: UsedPackageCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let packageData = arrForData[indexPath.row]
        if packageData.isUsed {
            let cell = tableView.dequeueReusableCell(withIdentifier: UsedPackageCell.name, for: indexPath) as?  UsedPackageCell
            cell?.layoutIfNeeded()
            cell?.setData(data: packageData)
            cell?.layoutIfNeeded()
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: BookPackageCell.name, for: indexPath) as?  BookPackageCell
            cell?.layoutIfNeeded()
            cell?.setData(data: packageData)
            cell?.btnBook.addTarget(self, action: #selector(openBookingProcess(sender:)), for: .touchUpInside)
            cell?.layoutIfNeeded()
            return cell!
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @objc func openBookingProcess(sender: UIButton) {
        self.openSessionSelectionDialog()
    }
    
}
