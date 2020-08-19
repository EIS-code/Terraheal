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

    var arrForMyPlaces: [ServiceCenterDetail] = []
    
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
        //self.addBottomFade()
        //self.addTopFade()
        self.getPlacesList()
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
            self.tableView?.contentInset = self.getGradientInset()
        }
    }

    private func initialViewSetup() {
        self.setupTableView(tableView: self.tableView)
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
         _ = (self.navigationController as? NC)?.popVC()
    }

    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadHomeVC()
    }


}


extension MyPlaceVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {

    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
tableView.backgroundColor = .clear
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


extension MyPlaceVC {
    
    func getPlacesList() {
        AppWebApi.massageCenterList(params: ServiceCenter.RequestServiceCenterlist()) { (response) in
            self.arrForMyPlaces.removeAll()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.serviceCenterList {
                    self.arrForMyPlaces.append(data)
                }
                self.setData()
            }
        }
    }
    
    func setData() {
        self.tableView.reloadData()
    }
    
}
