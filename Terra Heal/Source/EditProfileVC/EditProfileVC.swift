//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




class EditProfileVC: MainVC {
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var ivProfilePic: UIImageView!
    @IBOutlet weak var vwBg: UIView!
    var kTableHeaderHeight:CGFloat = 150.0
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var hVwContent: NSLayoutConstraint!

    @IBOutlet weak var txtName: EditProfileTextfield!
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

        self.lblTitle?.text = "Edit Profile"//appSingleton.user.name
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.btnBack.setBackButton()
        scrVw.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
        
    }

    @IBAction func btnBackTapped(_ sender: Any) {
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


extension EditProfileVC:  UIScrollViewDelegate {


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


}

