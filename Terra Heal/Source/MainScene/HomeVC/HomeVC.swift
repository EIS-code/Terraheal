//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class HomeVC: MainVC {
    
    @IBOutlet weak var btnProfile: FloatingRoundButton!
    @IBOutlet weak var btnMenu: FloatingRoundButton!
    @IBOutlet weak var lblMenu: ThemeLabel!
    @IBOutlet weak var lblUserName: ThemeLabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwFloatingBottom: JDSegmentedControl!
    @IBOutlet weak var ivUser: RoundedImageView!
    
    var arrForHomeDetails: [HomeItemDetail] = [
        HomeItemDetail(title:appSingleton.user.name, buttonTitle: "HOME_ITEM_ACTION_1".localized(), image: ImageAsset.HomeItem.header),
        HomeItemDetail(title: "HOME_ITEM_1".localized(), buttonTitle: "HOME_ITEM_ACTION_1".localized(), image: ImageAsset.HomeItem.sub1, homeItemtype: .MassageCenter),
        HomeItemDetail(title: "HOME_ITEM_2".localized(), buttonTitle: "HOME_ITEM_ACTION_2".localized(), image: ImageAsset.HomeItem.sub2, homeItemtype: .HotelOrRoom),
        HomeItemDetail(title: "HOME_ITEM_3".localized(), buttonTitle: "HOME_ITEM_ACTION_3".localized(), image: ImageAsset.HomeItem.sub3, homeItemtype: .EventAndCorporate)
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
        vwFloatingBottom.allowChangeThumbWidth = false
        vwFloatingBottom.itemTitles = ["HOME_BTN_HOME".localized(),"HOME_BTN_EXPLORE".localized(),"HOME_BTN_MY_FAV".localized()]
        vwFloatingBottom.itemImages =  [UIImage.init(named: "asset-home")!, UIImage.init(named: "asset-explore")!, UIImage.init(named: "asset-fav")!]
        vwFloatingBottom.itemSelectedImages = [UIImage.init(named: "asset-home-selected")!, UIImage.init(named: "asset-home-selected")!, UIImage.init(named: "asset-home-selected")!]
        vwFloatingBottom.changeThumbColor(UIColor.themePrimary)
        vwFloatingBottom.changeBackgroundColor(UIColor.themeLightTextColor)
        vwFloatingBottom.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else { return } ; print(self)
            Common.appDelegate.loadServiceMapVC(navigaionVC: self.navigationController)
        }
        self.addLocationObserver()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let lc = LocationCenter.init()
         lc.requestLocationOnce()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       // SlideVC.addRightToVC(self, sideVC: ProfileVC.shared)
        SlideVC.addLeftToVC(self, sideVC: SideVC.shared)
        SlideVC.addRightToVC(self, sideVC: ProfileVC.shared)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tableView?.reloadData({
            })
            vwFloatingBottom.setRound(withBorderColor: .themePrimary, andCornerRadious: self.vwFloatingBottom.bounds.height/2.0, borderWidth: 0.1)
            vwFloatingBottom.setShadow()
            
            self.tableView?.contentInset = self.getGradientInset()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.setupTableView(tableView: self.tableView)
         if appSingleton.user.name.isEmpty() {
            self.ivUser.image = UIImage.init(named: ImageAsset.Placeholder.user)
         } else {
            self.ivUser.downloadedFrom(link: appSingleton.user.profilePhoto)
         }
    }
    
    
    //MARK: Action Methods
    
    @IBAction func btnMenuTapped(_ sender: Any) {
        SideVC.shared.show()
    }
    
    
    func openPartialPaymentBookingDialog() {
        let paymentPercentageDialog: PaymentPercentatgeSelectionDialog  = PaymentPercentatgeSelectionDialog.fromNib()
        
        paymentPercentageDialog.initialize(title: "Payment", buttonTitle: "BTN_NEXT".localized(), cancelButtonTitle: "BTN_BACK".localized())
        paymentPercentageDialog.show(animated: true)
        paymentPercentageDialog.onBtnCancelTapped = {
            [weak paymentPercentageDialog, weak self] in
            guard let self = self else { return } ; print(self)
            paymentPercentageDialog?.dismiss()
           
        }
        paymentPercentageDialog.onBtnDoneTapped = {
            [weak paymentPercentageDialog, weak self]  (button) in
            guard let self = self else { return } ; print(self)
            paymentPercentageDialog?.dismiss()
            Common.appDelegate.loadPaymentReferenceVC(navigaionVC: self.navigationController,isFromMenu: false)
        }
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        if PreferenceHelper.shared.getUserId().isEmpty() {
            Common.appDelegate.loadWelcomeVC()
        } else {
            ProfileVC.shared.show()
            //Common.appDelegate.loadProfileVC(navigaionVC: self.navigationController)
        }
    }
    //MARK: Location Observer
    override func locationUpdate(_ ntf: Notification = Common.defaultNtf) {
        if let locationDict: [String: Any]  = ntf.userInfo?["ncd"] as? [String:Any] {
            if let location = locationDict["location"]  {
                if let coordinate =  (location as?  CLLocation)?.coordinate {
                    print(coordinate.latitude)
                }
            }
        }
    }
    
    override func locationFail(_ ntf: Notification = Common.defaultNtf) {
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
        tableView.register(ProfileTblUserInfoCell.nib()
            , forCellReuseIdentifier: ProfileTblUserInfoCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForHomeDetails.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTblUserInfoCell.name, for: indexPath) as?  ProfileTblUserInfoCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForHomeDetails[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomeTblCell.name, for: indexPath) as?  HomeTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForHomeDetails[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!
        }
    }
    
}

