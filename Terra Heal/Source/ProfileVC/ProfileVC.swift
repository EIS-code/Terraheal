//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




enum ProfileMenu: String {
    case MyProfile = "1"
    case MyBookings = "2"
    case MyPlaces = "3"
    case MyMassagePreference = "4"
    case MyTherapist = "5"
    case TherapistQuestionaries = "6"
    case ManageAddress = "7"
    case MangagePeople = "8"
    case PaymentPreference = "9"
    case Settings = "10"
    func name() -> String {
        switch self {
        case .MyProfile:
            return "PROFILE_MENU_ITEM_1".localized()
        case .MyBookings:
            return  "PROFILE_MENU_ITEM_2".localized()
        case .MyPlaces:
            return  "PROFILE_MENU_ITEM_3".localized()
        case .MyMassagePreference:
            return  "PROFILE_MENU_ITEM_4".localized()
        case .MyTherapist:
            return  "PROFILE_MENU_ITEM_5".localized()
        case .TherapistQuestionaries:
            return  "PROFILE_MENU_ITEM_6".localized()
        case .ManageAddress:
            return  "PROFILE_MENU_ITEM_7".localized()
        case .MangagePeople:
            return  "PROFILE_MENU_ITEM_8".localized()
        case .PaymentPreference:
            return  "PROFILE_MENU_ITEM_9".localized()
        case .Settings:
            return  "PROFILE_MENU_ITEM_10".localized()
        }
    }
}

struct ProfileItemDetail {
    var type: ProfileMenu = ProfileMenu.MyProfile
    var title: String = ""
    var image: String = ""
}


class ProfileVC: MainVC {

    @IBOutlet weak var btnProfile: FloatingRoundButton!
    @IBOutlet weak var btnMenu: FloatingRoundButton!
    @IBOutlet weak var lblEmail: ThemeLabel!
    @IBOutlet weak var lblUserName: ThemeLabel!
    @IBOutlet weak var lblMobile: ThemeLabel!
    @IBOutlet weak var ivQrCode: UIImageView!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var tableView: UITableView!
    var kTableHeaderHeight:CGFloat = 300.0
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var headerView: UIView!

    @IBOutlet weak var hVwContent: NSLayoutConstraint!

    var arrForMenu: [ProfileItemDetail] = [
        ProfileItemDetail(type: ProfileMenu.MyProfile, title: ProfileMenu.MyProfile.name(),  image: ""),
        ProfileItemDetail(type: ProfileMenu.MyBookings, title: ProfileMenu.MyBookings.name(),  image: ""),
        ProfileItemDetail(type: ProfileMenu.MyPlaces, title: ProfileMenu.MyPlaces.name(),  image: ""),
        ProfileItemDetail(type: ProfileMenu.MyMassagePreference, title: ProfileMenu.MyMassagePreference.name(),  image: ""),
        ProfileItemDetail(type: ProfileMenu.MyTherapist, title: ProfileMenu.MyTherapist.name(),  image: ""),
        ProfileItemDetail(type: ProfileMenu.TherapistQuestionaries, title: ProfileMenu.TherapistQuestionaries.name(),  image: ""),
        ProfileItemDetail(type: ProfileMenu.ManageAddress, title: ProfileMenu.ManageAddress.name(),  image: ""),
        ProfileItemDetail(type: ProfileMenu.MangagePeople, title: ProfileMenu.MangagePeople.name(),  image: ""),
        ProfileItemDetail(type: ProfileMenu.PaymentPreference, title: ProfileMenu.PaymentPreference.name(),  image: ""),
        ProfileItemDetail(type: ProfileMenu.Settings, title: ProfileMenu.Settings.name(),  image: ""),
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
        self.vwBg?.setRound(withBorderColor: UIColor.clear, andCornerRadious: 20.0, borderWidth: 1.0)
        self.vwBg?.setShadow()
        }
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.lblEmail?.text = appSingleton.user.email
        self.lblEmail?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblMobile?.text = appSingleton.user.telNumber
        self.lblMobile?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblUserName?.text = appSingleton.user.name
        self.lblUserName?.setFont(name: FontName.SemiBold, size: FontSize.label_14)
        self.lblDescription?.text = "description goes here."//appSingleton.user.name
        self.lblDescription?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.setupTableView(tableView: self.tableView)
    }

   // MARK: - Action Methods
    @IBAction func btnMenuTapped(_ sender: Any) {
        //SideVC.shared.show()
        //self.openGenderPicker()
    }

    @IBAction func btnProfileTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension ProfileVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        self.scrVw.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ProfileTblCell.nib()
            , forCellReuseIdentifier: ProfileTblCell.name)
        tableView.tableFooterView = UIView()

        scrVw.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)



    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    func updateHeaderView() {
        if self.scrVw.contentOffset.y < 0 {
            let y = abs(self.scrVw.contentOffset.y)
            let transLation = y/kTableHeaderHeight
            headerView.alpha = transLation
            headerView.transform = CGAffineTransform.init(scaleX: transLation, y: transLation)
            
        } else {
            headerView.alpha = 0.0
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForMenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTblCell.name, for: indexPath) as?  ProfileTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForMenu[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedType = arrForMenu[indexPath.row].type
        switch selectedType {
        case .MyProfile:
                Common.appDelegate.loadEditProfileVC(navigaionVC: self.navigationController)
        case .MyBookings:
                Common.showAlert(message: "Under Construction")
        case .MyPlaces:
                Common.showAlert(message: "Under Construction")
        case .MyMassagePreference:
                Common.appDelegate.loadMassagePreferenceVC(navigaionVC: self.navigationController)
        case .MyTherapist:
                 Common.appDelegate.loadMyTherapistVC(navigaionVC: self.navigationController)
        case .TherapistQuestionaries:
                Common.showAlert(message: "Under Construction")
        case .ManageAddress:
                Common.showAlert(message: "Under Construction")
        case .MangagePeople:
                Common.showAlert(message: "Under Construction")
        case .PaymentPreference:
                Common.showAlert(message: "Under Construction")
        case .Settings:
                Common.appDelegate.loadSettingVC(navigaionVC: self.navigationController)
        }
    }
}

