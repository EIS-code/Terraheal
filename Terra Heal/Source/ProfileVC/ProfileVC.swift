//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




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
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_1".localized(), image: ""),
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_2".localized(), image: ""),
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_3".localized(), image: ""),
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_4".localized(), image: ""),
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_5".localized(), image: ""),
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_6".localized(), image: ""),
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_7".localized(), image: ""),
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_8".localized(), image: ""),
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_9".localized(), image: ""),
        ProfileItemDetail(title: "PROFILE_MENU_ITEM_10".localized(),image: ""),

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

    // MARK: - Other Methods
    func openDatePicker() {
        let datePickerAlert: CustomDatePicker = CustomDatePicker.fromNib()
        datePickerAlert.initialize(title: "Date Of Birth", buttonTitle: "Proceed",cancelButtonTitle: "Back")
        datePickerAlert.show(animated: true)
        datePickerAlert.onBtnCancelTapped = {
            [weak datePickerAlert, weak self] in
            datePickerAlert?.dismiss()
        }
        datePickerAlert.onBtnDoneTapped = {
            [weak datePickerAlert, weak self] (date) in
            datePickerAlert?.dismiss()
            print(Date.milliSecToDate(milliseconds: date, format: "dd-MM-yy"))
        }
    }

    func openGenderPicker() {
        let genderPickerAlert: CustomGenderPicker = CustomGenderPicker.fromNib()
        genderPickerAlert.selectedGender = Gender.Female
        genderPickerAlert.initialize(title: "GENDER_DIALOG_TITLE".localized(), buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_BACK".localized())
        genderPickerAlert.show(animated: true)
        genderPickerAlert.onBtnCancelTapped = {
            [weak genderPickerAlert, weak self] in
            genderPickerAlert?.dismiss()
        }
        genderPickerAlert.onBtnDoneTapped = {
            [weak genderPickerAlert, weak self] (gender) in
            genderPickerAlert?.dismiss()
            print(gender)
        }
    }

}


extension ProfileVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        self.scrVw.delegate = self
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
        print(self.scrVw.contentOffset.y)

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
        if indexPath.row == 3 {
            Common.appDelegate.loadMassagePreferenceVC(navigaionVC: self.navigationController)
        }
        else if indexPath.row == 4 {
            Common.appDelegate.loadMyTherapistVC(navigaionVC: self.navigationController)
        }
    }
}

