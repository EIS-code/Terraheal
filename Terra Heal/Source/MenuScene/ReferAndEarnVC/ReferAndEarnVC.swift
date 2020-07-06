//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct ReferralDetail {
    var date:String = ""
    var amount:String = ""
    var description:String = ""
    var isCredit:Bool = false
    func getDemoData() -> [ReferralDetail] {
        return [
            ReferralDetail(date: "25 Oct", amount: "20", description: "gift card worth $100", isCredit: false),
            ReferralDetail(date: "20 Oct", amount: "50", description: "referral bonus", isCredit: true),
            ReferralDetail(date: "23 Oct", amount: "20", description: "referral bonus", isCredit: true)]
    }
}
class ReferAndEarnVC: MainVC {


    @IBOutlet weak var scrVw: UIScrollView!
    /*Earning Point Top View*/
    @IBOutlet weak var vwEarningPoints: UIView!
    @IBOutlet weak var ivEarningPoints: UIImageView!
    @IBOutlet weak var lblTotalBalance: ThemeLabel!
    @IBOutlet weak var lblTotalBalanceValue: ThemeLabel!
    @IBOutlet weak var lblLifeTimeEarning: ThemeLabel!
    @IBOutlet weak var lblLifeTimeEarningValue: ThemeLabel!
    @IBOutlet weak var lblLifeTimeBurning: ThemeLabel!
    @IBOutlet weak var lblLifeTimeBurningValue: ThemeLabel!
    /*Refer And Earn Point By Inviting Friend*/
    @IBOutlet weak var lblReferAndEarn: ThemeLabel!
    @IBOutlet weak var lblInviteFriendMsg: ThemeLabel!
    @IBOutlet weak var ivInviteFriend: UIImageView!
    @IBOutlet weak var btnReferNow: ThemeButton!
    @IBOutlet weak var vwInviteFriend: UIView!

    /*Referred Friends*/
    @IBOutlet weak var vwReferredFrinds: UIView!
    @IBOutlet weak var lblFriendRefered: ThemeLabel!
    @IBOutlet weak var cltFriends: UICollectionView!
    
    @IBOutlet weak var btnFilter: ThemeButton!
    @IBOutlet weak var lblHistory: ThemeLabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var hTblVw: NSLayoutConstraint!
    @IBOutlet weak var vwEmptyHistoryView: UIView!
    @IBOutlet weak var lblNoHistory: ThemeLabel!
    var arrForReferredFriends: [String] = ["Rahul", "Jaydeep", "Rahul", "Jaydeep", "Rahul",  "Jaydeep"]
    var arrForReferredHistory: [ReferralDetail] = []
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
        self.updateHistoryUi()
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

            self.tableView.reloadData(heightToFit: self.hTblVw) {
                self.ivEarningPoints.setRound()
                self.ivInviteFriend.setRound()
                self.cltFriends.reloadData()
                self.btnReferNow.setHighlighted(isHighlighted: false)
                self.btnFilter.setHighlighted(isHighlighted: true)
                self.vwInviteFriend.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
            }
        }
    }

    private func initialViewSetup() {
        self.setTitle(title: "REFER_AND_EARN_TITLE".localized())

        self.lblTotalBalance.text = "REFER_AND_EARN_LBL_TOTAL_BALANCE".localized()
        self.lblTotalBalance.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblTotalBalanceValue.text = "--".localized()
        self.lblTotalBalanceValue.setFont(name: FontName.Bold, size: FontSize.label_22)

        self.lblLifeTimeEarning.text = "REFER_AND_EARN_LBL_LIFETIME_EARNING".localized()
        self.lblLifeTimeEarning.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblLifeTimeEarningValue.text = "--".localized()
        self.lblLifeTimeEarningValue.setFont(name: FontName.Bold, size: FontSize.label_22)

        self.lblLifeTimeBurning.text = "REFER_AND_EARN_LBL_LIFETIME_BURNING".localized()
        self.lblLifeTimeBurning.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.lblLifeTimeBurningValue.text = "--".localized()
        self.lblLifeTimeBurningValue.setFont(name: FontName.Bold, size: FontSize.label_22)


        self.lblReferAndEarn.text = "REFER_AND_EARN_LBL_INVITE_FRIEND_TITLE".localized()
        self.lblReferAndEarn.setFont(name: FontName.SemiBold, size: FontSize.label_18)

        self.lblInviteFriendMsg.text = "REFER_AND_EARN_LBL_INVITE_FRIEND_MSG".localized()
        self.lblInviteFriendMsg.setFont(name: FontName.Regular, size: FontSize.label_14)


        self.btnReferNow.setTitle("REFER_AND_EARN_BTN_REFER_NOW".localized(), for: .normal)
        self.btnReferNow.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnReferNow.setHighlighted(isHighlighted: false)

        self.lblFriendRefered.text = "REFER_AND_EARN_LBL_FRIEND_REFERRED_TITLE".localized()
        self.lblFriendRefered.setFont(name: FontName.SemiBold, size: FontSize.label_18)

        self.lblHistory.text = "REFER_AND_EARN_LBL_HISTORY".localized()
        self.lblHistory.setFont(name: FontName.SemiBold, size: FontSize.label_18)

        self.lblNoHistory.text = "REFER_AND_EARN_LBL_NO_HISTORY".localized()
        self.lblNoHistory.setFont(name: FontName.Regular, size: FontSize.label_14)

        self.btnFilter.setTitle("last month".localized(), for: .normal)
        self.btnFilter.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnFilter.setHighlighted(isHighlighted: true)
        self.setupCollectionView(collectionView: self.cltFriends)
        self.setupTableView(tableView: self.tableView)
    }

    // MARK: - Action Methods
    @IBAction func btnReferralTapped(_ sender: Any) {
         self.btnReferNow.isEnabled = false
        self.openShareReferralCode()
    }

    @IBAction func btnFilterTapped(_ sender: Any) {
        btnFilter.isEnabled = false
        self.openHistoryFilterDialog()
    }
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        self.navigationController?.popViewController(animated: true)
    }
    func openShareReferralCode() {
        let alert: CustomShareReferralDialog = CustomShareReferralDialog.fromNib()
        alert.initialize(title: "SHARE_REFERRAL_TITLE".localized(), buttonTitle: "BTN_INVITE_VIA_SOCIAL_MEDIA".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)
            self.btnReferNow.isEnabled = true
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)


            self.btnReferNow.isEnabled = true
        }
    }
    func openHistoryFilterDialog() {
        let alert: CustomHistoryFilterPicker = CustomHistoryFilterPicker.fromNib()
        alert.initialize(title: "HISTORY_FILTER_TITLE".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)
            self.btnFilter.isEnabled = true
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            alert?.dismiss()
             guard let self = self else { return } ; print(self)
            if description.id == "0" {
                self.arrForReferredHistory = []
            } else {
                self.arrForReferredHistory = ReferralDetail().getDemoData()
            }
            self.updateHistoryUi()
            self.btnFilter.setTitle(description.strFilterType, for: .normal)
            self.btnFilter.isEnabled = true
        }
    }

    func updateHistoryUi() {
        if arrForReferredHistory.isEmpty {
            self.vwEmptyHistoryView.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.vwEmptyHistoryView.isHidden = true
            self.tableView.isHidden = false
        }
        self.tableView.reloadData()
    }
}

// MARK: - CollectionView Methods
extension ReferAndEarnVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ReferAndEarnUserCltCell.nib()
            , forCellWithReuseIdentifier: ReferAndEarnUserCltCell.name)

    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForReferredFriends.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReferAndEarnUserCltCell.name, for: indexPath) as! ReferAndEarnUserCltCell
        cell.setData(data: self.arrForReferredFriends[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.height
        return CGSize(width: size , height: size)
    }


}

extension ReferAndEarnVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        self.scrVw.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(ReferAndEarnTblCell.nib()
            , forCellReuseIdentifier: ReferAndEarnTblCell.name)
        tableView.tableFooterView = UIView()





    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForReferredHistory.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReferAndEarnTblCell.name, for: indexPath) as?  ReferAndEarnTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForReferredHistory[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


