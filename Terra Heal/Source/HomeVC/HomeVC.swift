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
    @IBOutlet weak var btnHome: FloatingRoundButton!
    @IBOutlet weak var btnExplore: FloatingRoundButton!
    @IBOutlet weak var btnMyFav: FloatingRoundButton!

    var arrForHomeDetails: [HomeItemDetail] = [
        HomeItemDetail(title:appSingleton.user.name, buttonTitle: "HOME_ITEM_ACTION_1".localized(), image: ""),
        HomeItemDetail(title: "HOME_ITEM_1".localized(), buttonTitle: "HOME_ITEM_ACTION_1".localized(), image: ""),
        HomeItemDetail(title: "HOME_ITEM_2".localized(), buttonTitle: "HOME_ITEM_ACTION_2".localized(), image: ""),
        HomeItemDetail(title: "HOME_ITEM_3".localized(), buttonTitle: "HOME_ITEM_ACTION_3".localized(), image: "")
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
        self.addLocationObserver()
        self.addBottomFade()
        self.addTopFade()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let lc = LocationCenter.init()
        lc.requestLocationOnce()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        SideVC.addToVC(self)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tableView?.reloadData({

            })
            self.btnHome?.setShadow()
            self.btnExplore?.setShadow()
            self.btnMyFav?.setShadow()
            self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)
        }
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblMenu.text = "HOME_LBL_MENU".localized()
        self.lblMenu.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        if appSingleton.user.name.isEmpty() {
            self.lblUserName.text = "HOME_LBL_USER".localized()
        } else {
            self.lblUserName.text = appSingleton.user.name
        }
        self.lblUserName.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        self.setupTableView(tableView: self.tableView)
        self.btnHome.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnExplore.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnMyFav.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnHome.setTitle("HOME_BTN_HOME".localized(), for: .normal)
        self.btnExplore.setTitle("HOME_BTN_EXPLORE".localized(), for: .normal)
        self.btnMyFav.setTitle("HOME_BTN_MY_FAV".localized(), for: .normal)
        self.btnHome.setHomeSelected(isSelected: true)
        self.btnExplore.setHomeSelected(isSelected: false)
        self.btnMyFav.setHomeSelected(isSelected: false)
    }

     //MARK: Action Methods

    @IBAction func btnMenuTapped(_ sender: Any) {
        SideVC.shared.show()
    }

    @IBAction func btnProfileTapped(_ sender: Any) {
        if PreferenceHelper.shared.getUserId().isEmpty() {
            Common.appDelegate.loadWelcomeVC()
        } else {
            Common.appDelegate.loadProfileVC(navigaionVC: self.navigationController)
        }
    }

    @IBAction func btnHomeTapped(_ sender: Any) {
        self.btnHome.setHomeSelected(isSelected: true)
        self.btnExplore.setHomeSelected(isSelected: false)
        self.btnMyFav.setHomeSelected(isSelected: false)
        self.btnHome?.setShadow()
        self.btnExplore?.setShadow()
        self.btnMyFav?.setShadow()
        Common.appDelegate.loadWelcomeVC()
    }

    @IBAction func btnExploreTapped(_ sender: Any) {
        self.btnExplore.setHomeSelected(isSelected: true)
        self.btnMyFav.setHomeSelected(isSelected: false)
        self.btnHome.setHomeSelected(isSelected: false)
        self.btnHome?.setShadow()
        self.btnExplore?.setShadow()
        self.btnMyFav?.setShadow()
        PreferenceHelper.shared.setIsTutorialShow(true)
    }

    @IBAction func btnMyFavTapped(_ sender: Any) {
        self.btnMyFav.setHomeSelected(isSelected: true)
        self.btnExplore.setHomeSelected(isSelected: false)
        self.btnHome.setHomeSelected(isSelected: false)
        self.btnHome?.setShadow()
        self.btnExplore?.setShadow()
        self.btnMyFav?.setShadow()
    }

    //MARK: Location Observer

    override func locationUpdate(_ ntf: Notification = Common.defaultNtf) {
        if let locationDict: [String: Any]  = ntf.userInfo?["ncd"] as? [String:Any] {
            if let location = locationDict["location"]  {
                if let coordinate =  (location as?  CLLocation)?.coordinate {
                    LocationCenter().getAddressFromGeocodeCoordinate(coordinate: coordinate)
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

        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(HomeTblCell.nib()
            , forCellReuseIdentifier: HomeTblCell.name)
        tableView.register(ProfileTblUserInfoCell.nib()
            , forCellReuseIdentifier: ProfileTblUserInfoCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForHomeDetails.count
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

