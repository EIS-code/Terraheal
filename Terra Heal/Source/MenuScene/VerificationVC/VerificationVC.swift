//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class VerificationVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnVerified: ThemeButton!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var lblIdPassport: ThemeLabel!
    @IBOutlet weak var lblIdFrontSide: ThemeLabel!
    @IBOutlet weak var lblIdBackSide: ThemeLabel!
    @IBOutlet weak var imgFrontSide: UIImageView!
    @IBOutlet weak var imgBackSide: UIImageView!

    var arrForProfile: [EditProfileTextFieldDetail] = [
        EditProfileTextFieldDetail(placeholder: "Mobile", value: appSingleton.user.telNumber, contentType: TextFieldContentType.Phone),
        EditProfileTextFieldDetail(placeholder: "Email", value: appSingleton.user.email, contentType: TextFieldContentType.Email),
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
            self.tableView?.reloadData(heightToFit: self.hTblVw, {

            })
            self.btnVerified?.setupFilledButton()
        }


    }
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.setupTableView(tableView: self.tableView)
        self.btnBack.setBackButton()
        self.setTitle(title: "VERIFICATION_TITLE".localized())
        self.lblIdBackSide.text = "VERIFICATION_LBL_BACK_SIDE".localized()
        self.lblIdFrontSide.text = "VERIFICATION_LBL_FRONT_SIDE".localized()
        self.lblIdPassport.text = "VERIFICATION_LBL_ID_PASSPORT".localized()
        self.lblIdBackSide.setFont(name: FontName.Bold, size: FontSize.label_10)
        self.lblIdFrontSide.setFont(name: FontName.Bold, size: FontSize.label_10)
        self.lblIdPassport.setFont(name: FontName.SemiBold, size: FontSize.label_12)
        self.btnVerified.setTitle("VERIFICATION_BTN_VERIFIED".localized(), for: .normal)
    }

    @IBAction func btnBackTapped(_ sender: Any) {
         _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnVerifiedTapped(_ sender: Any) {
        Common.appDelegate.loadManageDocumentVC(navigaionVC: self.navigationController)
    }

}


extension VerificationVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(VerificationTblCell.nib()
            , forCellReuseIdentifier: VerificationTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForProfile.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


            let cell = tableView.dequeueReusableCell(withIdentifier: VerificationTblCell.name, for: indexPath) as?  VerificationTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForProfile[indexPath.row])
            cell?.btnVerify.tag = indexPath.row
            cell?.btnVerify.addTarget(self, action: #selector(btnVerifyTapped(_:)), for: .touchUpInside)
            cell?.layoutIfNeeded()
            return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.width * 0.2
    }
    
    @IBAction func btnVerifyTapped(_ sender: UIButton) {
            let data = self.arrForProfile[sender.tag]
           if data.contentType == .Email {
               self.openEmailVerification()
           } else if data.contentType == .Phone {
               self.openMobileVerification()
           }
       }
    
    func openEmailVerification() {
        let alertForVerification: VerificationAlert  = VerificationAlert.fromNib()
        alertForVerification.initialize(message: "VERIFICATION_EMAIL_TITLE".localized(), data: Singleton.shared.user.email)
        alertForVerification.show(animated: true)
        alertForVerification.setVerificationFor(type: .Email)
        alertForVerification.onBtnDoneTapped = { [weak alertForVerification, weak self] (code:String) in
            guard let self = self else {return}; print(self)
            alertForVerification?.dismiss()
        }

        alertForVerification.onBtnResendTapped = { [weak self] in
            guard let self = self else {return}; print(self)
        }
        alertForVerification.onBtnCancelTapped = { [weak alertForVerification,  weak self] in
            guard let self = self else {return}; print(self)
            alertForVerification?.dismiss()
        }
    }
    func openMobileVerification() {
        let alertForVerification: VerificationAlert  = VerificationAlert.fromNib()
        alertForVerification.initialize(message: "VERIFICATION_MOBILE_TITLE".localized(), data: Singleton.shared.user.telNumber)
        alertForVerification.show(animated: true)
        alertForVerification.setVerificationFor(type: .Phone)
        alertForVerification.onBtnDoneTapped = { [weak alertForVerification, weak self] (code:String) in
            guard let self = self else {return}; print(self)
            alertForVerification?.dismiss()
        }

        alertForVerification.onBtnResendTapped = { [weak self] in
            guard let self = self else {return}; print(self)
        }
        alertForVerification.onBtnCancelTapped = { [weak alertForVerification,  weak self] in
            guard let self = self else {return}; print(self)
            alertForVerification?.dismiss()
        }
    }
    
}

