//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class MyTherapistVC: BaseVC {
    
    @IBOutlet weak var tableView: UITableView!
    
    var arrForData: [Therapist] = []
    var arrForTherapist: [MyTherapistDetail] = []
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
        self.getTherapistList()
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
        self.setTitle(title: "MYTHERAPIST_TITLE".localized())
    }
    
    func openRateViewPicker(therapist: Therapist) {
        let alert: CustomRateViewDialog = CustomRateViewDialog.fromNib()
        alert.initialize(title: therapist.name, data: "", buttonTitle: "BTN_PROCEED".localized(),cancelButtonTitle: "BTN_SKIP".localized())
        alert.show(animated: true)
        alert.onBtnCancelTapped = {
            [weak alert, weak self] in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
        }
        alert.onBtnDoneTapped = {
            [weak alert, weak self] (review,rating) in
            guard let self = self else {return}; print(self)
            alert?.dismiss()
            var request:TherapistWebService.RequestSaveRating  =   TherapistWebService.RequestSaveRating.init()
            request.therapist_id = therapist.id
            request.rating = rating.toString()
            request.message = review
            self.rateTherapist(request: request)
            
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


extension MyTherapistVC: UITableViewDelegate,UITableViewDataSource, UIScrollViewDelegate {
    
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
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
        
        self.openRateViewPicker(therapist: self.arrForData[indexPath.row])
    }
    
}

//MARK:- My Therapist API

extension MyTherapistVC {
    
    func getTherapistList() {
        AppWebApi.getBookingTherapistList { (response) in
            self.arrForTherapist.removeAll()
            if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                for data in response.therapistList {
                    self.arrForTherapist.append(data.toViewModel())
                    self.arrForData.append(data)
                }
                self.setData()
            }
        }
    }
    
    func rateTherapist(request:TherapistWebService.RequestSaveRating)  {
        AppWebApi.rateTherapist(params: request) { (response) in
            if ResponseModel.isSuccess(response: response, withSuccessToast:false, andErrorToast: true) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    func setData() {
        self.tableView.reloadData()
    }
    
}
