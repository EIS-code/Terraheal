//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class MyBookingVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var vwTab: JDSegmentedControl!
    @IBOutlet weak var vwBg: UIView!
    
    var arrForPastBooking: [MyPastBookingData] = []
    var arrForFutureBooking: [MyPastBookingData] = []
    var arrForData: [MyBookingTblCellDetail] = []
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
        self.getPastBookingList()
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
            self.vwTab?.setRound(withBorderColor: .themePrimary, andCornerRadious: self.vwTab.bounds.height/2.0, borderWidth: 0.1)
            self.vwBg?.setRound(withBorderColor: UIColor.clear, andCornerRadious: 20.0, borderWidth: 1.0)
            self.vwBg?.setShadow()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        self.setupTableView(tableView: self.tableView)
        self.setTitle(title: "MY_BOOKING_TITLE".localized())
        self.vwTab.allowChangeThumbWidth = false
        self.vwTab.itemTitles = ["pending","upcoming","past"]
        self.vwTab.changeBackgroundColor(UIColor.themeLightTextColor)
        self.vwTab.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else { return } ; print(self)
            switch index {
            case 0:
                self.getPastBookingList()
            default:
                self.getPastBookingList()
            }
        }
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        Common.appDelegate.loadMainVC()
    }
    
    
}


extension MyBookingVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 170
        tableView.register(MyBookingTblCell.nib()
            , forCellReuseIdentifier: MyBookingTblCell.name)
        tableView.register(MyBookingExpandTblCell.nib()
        , forCellReuseIdentifier: MyBookingExpandTblCell.name)
        tableView.tableFooterView = UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingExpandTblCell.name, for: indexPath) as?  MyBookingExpandTblCell
            cell?.setData(data: arrForPastBooking[indexPath.section])
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: MyBookingTblCell.name, for: indexPath) as?  MyBookingTblCell
            cell?.setData(data: arrForData[indexPath.row])
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.arrForData[indexPath.row].isSelected.toggle()
        self.tableView.reloadRows(at: [indexPath], with: .fade)
    }
    
}

extension MyBookingVC {
    
    func getPastBookingList() {
        Loader.showLoading()
        arrForPastBooking.removeAll()
        AppWebApi.getPastBookingList { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForPastBooking =  response.bookingList
                self.setDataSourceForPastBooking(dataSource: self.arrForPastBooking)
                self.tableView.reloadData()
            }
        }
    }
    func getFutureBookingList() {
        Loader.showLoading()
        arrForFutureBooking.removeAll()
        AppWebApi.getPastBookingList { (response) in
            Loader.hideLoading()
            if ResponseModel.isSuccess(response: response) {
                self.arrForFutureBooking =  response.bookingList
                self.setDataSourceForPastBooking(dataSource: self.arrForFutureBooking)
                self.tableView.reloadData()
            }
        }
    }

    func setDataSourceForPastBooking(dataSource:[MyPastBookingData]) {
        self.arrForData.removeAll()
        for data in dataSource {
            self.arrForData.append(MyBookingTblCellDetail.init(data: data))
        }
    }
}
