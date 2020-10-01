//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class HomeVC: BaseVC {

    @IBOutlet weak var scrHomeData: UIScrollView!
    @IBOutlet weak var lblName: ThemeLabel!
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var btnBookNow: RoundedBorderButton!
    @IBOutlet weak var tableView: UITableView!

    var arrForData: [ServiceDetail] = []
    var headerData: HomeItemDetail =  HomeItemDetail(title:appSingleton.user.name, buttonTitle: "HOME_ITEM_ACTION_1".localized(), image: ImageAsset.HomeItem.header,homeItemtype: .Header )
    var arrForHomeDetails: [HomeItemDetail] = []
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
        self.tableView.isScrollEnabled = false
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
            self.scrHomeData.contentInset = UIEdgeInsets.init(top: JDDeviceHelper.offseter(offset: 80), left: 0, bottom:  JDDeviceHelper.offseter(offset: 52), right: 0)
            self.tableView?.reloadData({
            })
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.setupTableView(tableView: self.tableView)
        self.lblName?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblHeader?.setFont(name: FontName.Bold, size: FontSize.large)
        self.lblDescription?.setFont(name: FontName.Regular, size: FontSize.detail)
        self.setData(data: headerData)
    }
    
    
    func updateEventData() {
        self.scrHomeData.gone()
        self.tableView.isScrollEnabled = true
        arrForHomeDetails = [
            HomeItemDetail(title: "HOME_ITEM_1".localized(), buttonTitle: "HOME_ITEM_ACTION_1".localized(), image: ImageAsset.HomeItem.sub1, homeItemtype: .MassageCenter),
            HomeItemDetail(title: "HOME_ITEM_2".localized(), buttonTitle: "HOME_ITEM_ACTION_2".localized(), image: ImageAsset.HomeItem.sub2, homeItemtype: .HotelOrRoom),
            HomeItemDetail(title: "HOME_ITEM_3".localized(), buttonTitle: "HOME_ITEM_ACTION_3".localized(), image: ImageAsset.HomeItem.sub3, homeItemtype: .EventAndCorporate)
        ]
        self.tableView.reloadData()
        self.tableView.visible()
    }
    
    func setData(data: HomeItemDetail ) {
        self.tableView.isHidden = true
        self.scrHomeData.isHidden = false
        if data.title.isEmpty() {
            self.lblName.text = "HOME_LBL_HI".localized() + "HOME_LBL_USER".localized()
        }  else {
            self.lblName.text = "HOME_LBL_HI".localized() + data.title
        }
        self.btnBookNow.setTitle(data.buttonTitle, for: .normal)
        self.lblHeader.text = "HOME_INFO_LBL_1".localized()
        self.lblDescription.text = "HOME_INFO_LBL_2".localized()
    }
    @IBAction func btnBookNowTapped(_ sender: UIButton) {
        
        self.updateEventData()
    }
    
}

//MARK: Tableview DataSource and Delegate
extension HomeVC: UITableViewDelegate,UITableViewDataSource {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 160
        tableView.register(HomeTblCell.nib()
            , forCellReuseIdentifier: HomeTblCell.name)
        tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 80)))
        tableView.tableFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.bounds.width, height: JDDeviceHelper.offseter(offset: 52)))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForHomeDetails.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrForHomeDetails[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTblCell.name, for: indexPath) as?  HomeTblCell
        cell?.parentVC = self
        cell?.layoutIfNeeded()
        cell?.setData(data: data)
        cell?.layoutIfNeeded()
        return cell!
    }
    
}

