//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit



struct PromocodeDetail {
    var code: String = ""
    var expiry: String = ""
    var description: String = ""
    var isSelected: Bool = false
}

class PromoCodeVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnSubmit: ThemeButton!

    var arrForData: [PromocodeDetail] = [PromocodeDetail.init(code:"9S75894",expiry: "expire in 6 days", description: "FLAT 30 % OFF"),PromocodeDetail.init(code:"ABCDEF",expiry: "expire in 6 days", description: "FLAT 50 % OFF")

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
            self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)

        }


    }
    private func initialViewSetup() {
        
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "PROMOCODE_TITLE".localized())
        self.btnSubmit?.setTitle("PROMOCODE_BTN_ADD_NEW".localized(), for: .normal)
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setHighlighted(isHighlighted: true)
        self.btnBack.setBackButton()
    }


    @IBAction func btnSubmitTapped(_ sender: Any) {
        btnSubmit.isEnabled = false
        self.openTextFieldPicker()
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    func openTextFieldPicker() {
        let alert: CustomTextFieldDialog = CustomTextFieldDialog.fromNib()
        alert.initialize(title: "PROMOCODE_TITLE".localized(), data:"", buttonTitle: "PROMOCODE_BTN_ADD_NEW".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.txtData.placeholder = "code"
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
            guard let self = self else { return }
            self.btnSubmit.isEnabled = true
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (description) in
            alert?.dismiss()
            guard let self = self else { return }

            self.arrForData.append(PromocodeDetail.init(code:description,expiry: "expire in 6 days", description: "FLAT 50 % OFF"))
            self.tableView.reloadData()
            self.btnSubmit.isEnabled = true
        }
    }



}


extension PromoCodeVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(PromoCodeTblCell.nib()
            , forCellReuseIdentifier: PromoCodeTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PromoCodeTblCell.name, for: indexPath) as?  PromoCodeTblCell
        cell?.layoutIfNeeded()
        cell?.setData(data: arrForData[indexPath.row])
        cell?.layoutIfNeeded()
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
}
