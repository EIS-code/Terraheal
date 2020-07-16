//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

struct MyPlaceTblDetail{
    var title: String = ""
    var isSelected: Bool = false
}

class MyPlaceVC: MainVC {

    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var tableView: UITableView!

    var arrForMyPlaces: [ServiceCenterDetail] = [
        ServiceCenterDetail(name: "terra heal massage center", address: "Lorem ipsum dolor sit,lisbon, portugal -25412", numberOfServices: "25",latitude: "22.35",longitude: "70.90", servicesList: []),
        ServiceCenterDetail(name: "terra heal massage center 2", address: "Lorem ipsum dolor sit,lisbon, portugal -25112", numberOfServices: "35",  latitude: "22.50",longitude: "70.50", servicesList: []),
        ServiceCenterDetail(name: "terra heal massage center 3", address: "Lorem ipsum dolor sit,lisbon, portugal -25212", numberOfServices: "15", latitude: "22.70",longitude: "70.30", servicesList: [])]
    
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
        self.setTitle(title: "MY_PLACE_TITLE".localized())
         self.btnBack.setBackButton()
    }

    func openPlaceDetailDialog(data: ServiceCenterDetail) {
        let alert: ServiceCenterDetailDialog = ServiceCenterDetailDialog.fromNib()
        alert.initialize(data: data, buttonTitle: "Service")
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self]  in
            guard let self = self else { return } ; print(self)
            alert?.dismiss()
        }
    }

    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }


}


extension MyPlaceVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(MyPlaceTblCell.nib()
            , forCellReuseIdentifier: MyPlaceTblCell.name)
        tableView.tableFooterView = UIView()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return arrForMyPlaces.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {


            let cell = tableView.dequeueReusableCell(withIdentifier: MyPlaceTblCell.name, for: indexPath) as?  MyPlaceTblCell
            cell?.layoutIfNeeded()
            cell?.setData(data: arrForMyPlaces[indexPath.row])
            cell?.layoutIfNeeded()
            return cell!

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.openPlaceDetailDialog(data: self.arrForMyPlaces[indexPath.row])
    }
    
}

