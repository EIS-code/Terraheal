//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct MyAddressDetail {
    var addressLine1: String = ""
    var addressLine2: String = ""
    var landMark: String = ""
    var pincode: String = ""
    var state: String = ""
    var city: String = ""
    var name: String = ""
}
class MyAddressVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwForEmpty: UIView!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var lblEmptyTitle: ThemeLabel!
    @IBOutlet weak var lblEmptyMsg: ThemeLabel!
    @IBOutlet weak var btnSubmit: ThemeButton!

    var arrForMyPlaces: [MyAddressDetail] = [

    MyAddressDetail(addressLine1: "lorem ipsum dolor", addressLine2: "sit amet lisbon", landMark: "portugal 12451.", pincode: "360003", state: "Gujarat", city: "Rajkot", name: "Home")
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
        self.wsGetAddress()
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
           self.vwBg?.layoutIfNeeded()
           self.vwBg?.setRound()
           self.tableView?.reloadData({
           })
           self.btnSubmit?.setHighlighted(isHighlighted: true)
           self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)
        }
    }

    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "MANAGE_ADDRESS_TITLE".localized())
        self.lblEmptyTitle.text = "NO_ADDRESS_TITLE".localized()
        self.lblEmptyMsg.text = "NO_ADDRESS_MSG".localized()
        self.btnSubmit?.setTitle("MANAGE_ADDRESS_BTN_ADD_NEW_ADDRESS".localized(), for: .normal)
        self.btnSubmit?.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnSubmit?.setHighlighted(isHighlighted: true)
        self.btnBack.setBackButton()
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        self.openNewAddressDialog()
    }

    func updateUI()  {
        if arrForMyPlaces.isEmpty {
            self.vwForEmpty.isHidden = false
            self.tableView.isHidden = true
        } else {
            self.vwForEmpty.isHidden = true
            self.tableView.isHidden = false
        }
        self.tableView.reloadData()
    }
    func openNewAddressDialog(index:Int = -1) {

        let alert: CustomAddNewAddressDialog = CustomAddNewAddressDialog.fromNib()
        var address: MyAddressDetail = MyAddressDetail.init()
        if index != -1 {
            address = arrForMyPlaces[index]
        }
        alert.initialize(title: self.btnSubmit.title(for: .normal) ?? "", data: address, buttonTitle: "BTN_SAVE".localized(), cancelButtonTitle: "BTN_CANCEL".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (address) in
            guard let self = self else {
                return
            }
            alert?.dismiss()
            if index == -1 {
                self.arrForMyPlaces.append(address)
            } else {
                self.arrForMyPlaces[index] = address
            }

            self.tableView.reloadData()
        }
    }

    func openConfirmationDialog(index:Int) {

        let alert: CustomAlertConfirmation = CustomAlertConfirmation.fromNib()

        alert.initialize(message: "Are you you want to delete this address")
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
            alert?.dismiss()
            guard  let self = self else {
                return
            }
            self.arrForMyPlaces.remove(at: index)
            self.tableView.reloadData()
        }
    }
    @objc func removeAddress(button: UIButton) {
        self.openConfirmationDialog(index: button.tag)
    }
    @objc func editAddress(button: UIButton) {
        self.openNewAddressDialog(index: button.tag)
    }
}


extension MyAddressVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(MyAddressTblCell.nib()
            , forCellReuseIdentifier: MyAddressTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForMyPlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


            let cell = tableView.dequeueReusableCell(withIdentifier: MyAddressTblCell.name, for: indexPath) as?  MyAddressTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForMyPlaces[indexPath.row])
            cell?.btnEdit.tag = indexPath.row
            cell?.btnDelete.tag = indexPath.row
            cell?.btnDelete.addTarget(self, action: #selector(removeAddress(button:)), for: .touchUpInside)
            cell?.btnEdit.addTarget(self, action: #selector(editAddress(button:)), for: .touchUpInside)
            cell?.layoutIfNeeded()
            return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //self.openNewAddressDialog(index: indexPath.row)
    }
    
}


//MARK:- Web Service Calls
extension MyAddressVC {

    func wsGetAddress() {
        
        self.updateUI()
    }
}
