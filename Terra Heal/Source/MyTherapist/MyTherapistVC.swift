//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class MyTherapistVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!

    var arrForTherapist: [MyTherapistDetail] = [
        MyTherapistDetail(title: "lorea josis 1", isSelected: false),
        MyTherapistDetail(title: "lorea josis 2", isSelected: false),
        MyTherapistDetail(title: "lorea josis 3", isSelected: false),
        MyTherapistDetail(title: "lorea josis 4", isSelected: false),
        MyTherapistDetail(title: "lorea josis 5", isSelected: false),
        MyTherapistDetail(title: "lorea josis 6", isSelected: false),
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
           self.tableView?.contentInset = UIEdgeInsets(top: headerGradient.frame.height, left: 0, bottom: footerGradient.frame.height, right: 0)
        }


    }
    private func initialViewSetup() {
        self.vwBar?.backgroundColor = UIColor.clear
        self.setupTableView(tableView: self.tableView)
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "MYTHERAPIST_TITLE".localized())
         self.btnBack.setBackButton()
    }

    func openRateViewPicker(name: String) {
        let alert: CustomRateViewDialog = CustomRateViewDialog.fromNib()
        alert.initialize(title: name, data: "", buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (review,rating) in
            alert?.dismiss()
            print(review)
            print(rating)
        }
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }


}


extension MyTherapistVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(MyTherapistTblCell.nib()
            , forCellReuseIdentifier: MyTherapistTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForTherapist.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


            let cell = tableView.dequeueReusableCell(withIdentifier: MyTherapistTblCell.name, for: indexPath) as?  MyTherapistTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForTherapist[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.openRateViewPicker(name: self.arrForTherapist[indexPath.row].title)
    }
    
}

