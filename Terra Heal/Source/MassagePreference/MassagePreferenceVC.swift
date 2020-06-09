//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import CoreLocation



class MassagePreferenceVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var btnSubmit: ThemeButton!

    @IBOutlet weak var headerGradient: UIView!
    @IBOutlet weak var footerGradient: UIView!

    let topGradientLayer: CAGradientLayer? = CAGradientLayer()
    let bottomGradientLayer: CAGradientLayer? = CAGradientLayer()

    var arrForMenu: [MassagePreferenceDetail] = [
        MassagePreferenceDetail(title: "MASSAGE_PREFERENCE_MENU_ITEM_1".localized(), isSelected: false),
        MassagePreferenceDetail(title: "MASSAGE_PREFERENCE_MENU_ITEM_2".localized(), isSelected: false),
        MassagePreferenceDetail(title: "MASSAGE_PREFERENCE_MENU_ITEM_3".localized(), isSelected: false),
        MassagePreferenceDetail(title: "MASSAGE_PREFERENCE_MENU_ITEM_4".localized(), isSelected: false),
        MassagePreferenceDetail(title: "MASSAGE_PREFERENCE_MENU_ITEM_5".localized(), isSelected: false),
        MassagePreferenceDetail(title: "MASSAGE_PREFERENCE_MENU_ITEM_6".localized(), isSelected: false),
        MassagePreferenceDetail(title: "MASSAGE_PREFERENCE_MENU_ITEM_7".localized(), isSelected: false),
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
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.tableView?.reloadData({

            })
            topGradientLayer?.frame = headerGradient.bounds
            bottomGradientLayer?.frame = footerGradient.bounds
            self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)
            self.btnSubmit?.setHighlighted(isHighlighted: true)
        }


    }
    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "MASSAGE_PREFERENCE_TITLE".localized())
        self.btnSubmit.setTitle("BTN_SUBMIT".localized(), for: .normal)
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setHighlighted(isHighlighted: true)
        self.btnBack.setBackButton()
    }

    func openMassagerPressurePicker() {
        let alert: CustomPressurePicker = CustomPressurePicker.fromNib()
        alert.initialize(title: "MASSAGE_PREFERENCE_MENU_ITEM_1".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
             [weak alert, weak self] (pressure) in
            alert?.dismiss()
            print(pressure.name())
        }
    }

    func openPreferGenderPicker() {
        let alert: CustomPreferGenderPicker = CustomPreferGenderPicker.fromNib()
        alert.initialize(title: "MASSAGE_PREFERENCE_MENU_ITEM_2".localized(), buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (gender) in
            alert?.dismiss()
            print(gender.name())
        }
    }

    func openTextViewPicker() {
        let alert: CustomTextViewDialog = CustomTextViewDialog.fromNib()
        alert.initialize(title: "MASSAGE_PREFERENCE_MENU_ITEM_3".localized(), data: "", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (gender) in
            alert?.dismiss()
            print(gender)
        }
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }


    func addTopFade() {
        let gradientColor = UIColor.white
        topGradientLayer!.frame = headerGradient.bounds
        topGradientLayer!.colors = [gradientColor.withAlphaComponent(1.0).cgColor,gradientColor.withAlphaComponent(0.8).cgColor, gradientColor.withAlphaComponent(0.5).cgColor,gradientColor.withAlphaComponent(0.0).cgColor]
        topGradientLayer!.name = "topGradient"

        if let oldLayer:  CAGradientLayer = self.headerGradient.layer.sublayers?.last(where: { (currentLayer) -> Bool in
            return currentLayer.name == "topGradient"
        }) as?  CAGradientLayer {
            oldLayer.removeFromSuperlayer()
        }

        self.headerGradient.layer.addSublayer(topGradientLayer!)
    }

    func addBottomFade() {
        let gradientColor = UIColor.white
        bottomGradientLayer!.frame = footerGradient.bounds
        bottomGradientLayer!.colors = [gradientColor.withAlphaComponent(0.0).cgColor,gradientColor.withAlphaComponent(0.5).cgColor, gradientColor.withAlphaComponent(0.8).cgColor,gradientColor.withAlphaComponent(1.0).cgColor]
        bottomGradientLayer!.name = "bottomGradient"

        if let oldLayer:  CAGradientLayer = self.footerGradient.layer.sublayers?.last(where: { (currentLayer) -> Bool in
            return currentLayer.name == "bottomGradient"
        }) as?  CAGradientLayer {
            oldLayer.removeFromSuperlayer()
        }

        self.footerGradient.layer.addSublayer(bottomGradientLayer!)
    }

}


extension MassagePreferenceVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(MassagePreferenceTblCell.nib()
            , forCellReuseIdentifier: MassagePreferenceTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForMenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


            let cell = tableView.dequeueReusableCell(withIdentifier: MassagePreferenceTblCell.name, for: indexPath) as?  MassagePreferenceTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForMenu[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.openMassagerPressurePicker()
        self.openTextViewPicker()
    }
    
}

