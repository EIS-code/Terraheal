//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




enum ProfileMenu: String {
    case MyProfile = "1"
    case MyBookings = "3"
    case Varification = "2"
    case MyPlaces = "4"
    case MyMassagePreference = "5"
    case MyTherapist = "6"
    case TherapistQuestionaries = "7"
    case ManageAddress = "8"
    case MangagePeople = "9"
    case PaymentPreference = "10"
    case Settings = "11"
    case KycVerification = "12"
    func name() -> String {
        switch self {
        case .MyProfile:
            return "PROFILE_MENU_Profile".localized()
        case .Varification:
            return "PROFILE_MENU_VARIFICATION".localized()
        case .MyBookings:
            return  "PROFILE_MENU_MY_BOOKING".localized()
        case .MyPlaces:
            return  "PROFILE_MENU_MY_PLACES".localized()
        case .MyMassagePreference:
            return  "PROFILE_MENU_MY_MASSAGE_PREFERENCE".localized()
        case .MyTherapist:
            return  "PROFILE_MENU_MY_THERAPIST".localized()
        case .TherapistQuestionaries:
            return  "PROFILE_MENU_THERAPIST_QUESTIONARIES".localized()
        case .ManageAddress:
            return  "PROFILE_MENU_MANAGE_ADDRESS".localized()
        case .MangagePeople:
            return  "PROFILE_MENU_MANAGE_PEOPLE".localized()
        case .PaymentPreference:
            return  "PROFILE_MENU_PAYMENT_PREFERENCE".localized()
        case .Settings:
            return  "PROFILE_MENU_SETTING".localized()
        case .KycVerification:
            return "kyc verification"
        }
    }
}

struct ProfileItemDetail {
    var type: ProfileMenu = ProfileMenu.MyProfile
    var image: String = ""
}


class ProfileVC: BaseVC {
    
    @IBOutlet weak var btnCancel: CancelButton!
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
    @IBOutlet weak var ivUser: RoundedImageView!
    @IBOutlet weak var hVwContent: NSLayoutConstraint!
    
    
    
    var arrForMenu: [ProfileItemDetail] = [
        ProfileItemDetail(type: ProfileMenu.MyProfile,  image: ImageAsset.ProfileMenu.myProfile),
        ProfileItemDetail(type: ProfileMenu.Varification, image: ImageAsset.ProfileMenu.varification),
        ProfileItemDetail(type: ProfileMenu.MyBookings, image:  ImageAsset.ProfileMenu.myBookings),
        ProfileItemDetail(type: ProfileMenu.MyPlaces, image: ImageAsset.ProfileMenu.myPlaces),
        ProfileItemDetail(type: ProfileMenu.MyMassagePreference, image: ImageAsset.ProfileMenu.myMassagePreference),
        ProfileItemDetail(type: ProfileMenu.MyTherapist, image: ImageAsset.ProfileMenu.myTherapy),
        ProfileItemDetail(type: ProfileMenu.TherapistQuestionaries, image: ImageAsset.ProfileMenu.therapyQuastionary),
        ProfileItemDetail(type: ProfileMenu.ManageAddress, image: ImageAsset.ProfileMenu.manageAddress),
        ProfileItemDetail(type: ProfileMenu.MangagePeople, image: ImageAsset.ProfileMenu.managePeople),
        ProfileItemDetail(type: ProfileMenu.PaymentPreference, image: ImageAsset.ProfileMenu.paymentPreference),
        ProfileItemDetail(type: ProfileMenu.Settings,  image: ImageAsset.ProfileMenu.setting)
        //,ProfileItemDetail(type: ProfileMenu.KycVerification,  image: ""),
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
        self.headerView.layoutIfNeeded()
        self.kTableHeaderHeight = self.headerView.frame.height
        scrVw.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if appSingleton.user.profilePhoto.isEmpty() {
            self.ivUser.image = UIImage.init(named: ImageAsset.Placeholder.user)
        } else {
            self.ivUser.downloadedFrom(link: appSingleton.user.profilePhoto)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if self.isViewAvailable() {
            
            //self.updateHeaderView()
            self.vwBg?.setRound(withBorderColor: UIColor.clear, andCornerRadious: 20.0, borderWidth: 1.0)
            self.vwBg?.setShadow(radius: 2.0, opacity: 1.0, offset: CGSize.init(width: 1.0, height: 0.0), color: UIColor.init(hex: "#B2B3B5"))
            
            
        }
    }
    
    private func initialViewSetup() {
        self.view.backgroundColor = UIColor.themeBackground
        self.lblEmail?.text = appSingleton.user.email
        self.lblEmail?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblMobile?.text = appSingleton.user.telNumber
        self.lblMobile?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.lblUserName?.text = appSingleton.user.name
        self.lblUserName?.setFont(name: FontName.SemiBold, size: FontSize.regular)
        self.lblDescription?.text = "description goes here."//appSingleton.user.name
        self.lblDescription?.setFont(name: FontName.Regular, size: FontSize.regular)
        self.setupTableView(tableView: self.tableView)
        
    }
    
    // MARK: - Action Methods
    @IBAction func btnMenuTapped(_ sender: Any) {
        
    }
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.revealViewController()?.revealRightView()
    }
}


extension ProfileVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        self.scrVw.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.register(ProfileTblCell.nib()
            , forCellReuseIdentifier: ProfileTblCell.name)
        tableView.tableFooterView = UIView()
        self.updateHeaderView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    func updateHeaderView() {
        
        if self.scrVw.contentOffset.y < -20 {
            let y = abs(self.scrVw.contentOffset.y)
            let transLation = y/kTableHeaderHeight
            self.tableView.isScrollEnabled = false
            headerView.alpha = transLation
            headerView.transform = CGAffineTransform.init(scaleX: transLation, y: transLation)
            
        } else {
            headerView.alpha = 0.0
            self.tableView.isScrollEnabled = true
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
        
        return tableView.frame.width * 0.2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedType = arrForMenu[indexPath.row].type
        switch selectedType {
        case .MyProfile:
            Common.appDelegate.loadEditProfileVC(navigaionVC: self.navigationController)
        case .Varification:
            Common.appDelegate.loadVerificationVC(navigaionVC: self.navigationController)
        case .MyBookings:
            Common.appDelegate.loadMyBookingVC(navigaionVC: self.navigationController)
        case .MyPlaces:
            Common.appDelegate.loadMyPlacesVC(navigaionVC: self.navigationController)
        case .MyMassagePreference:
            Common.appDelegate.loadMassagePreferenceVC(navigaionVC: self.navigationController)
        case .MyTherapist:
            Common.appDelegate.loadMyTherapistVC(navigaionVC: self.navigationController)
        case .TherapistQuestionaries:
            Common.appDelegate.loadTherapistQuestionaryVC(navigaionVC: self.navigationController)
        case .ManageAddress:
            Common.appDelegate.loadManageAddressVC(navigaionVC: self.navigationController)
        case .MangagePeople:
            Common.appDelegate.loadManagePeopleVC(navigaionVC: self.navigationController)
        case .PaymentPreference:
            Common.appDelegate.loadPaymentReferenceVC(navigaionVC: self.navigationController, fromVC: nil)
        case .Settings:
            Common.appDelegate.loadSettingVC(navigaionVC: self.navigationController)
        case .KycVerification:
            Common.appDelegate.loadKycInfoVC(navigaionVC: self.navigationController)
        }
    }
}

