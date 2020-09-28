//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




struct PackageServiceDetail {
    var id: String = ""
    var name: String = "head, neck and shoulders"
    var image: String = "demo-massage"
    var duration: String = "60"
    var isSelected: Bool = false
    var isUsed: Bool = false
}

class PackageDetailVC: BaseVC {
    
    @IBOutlet weak var btnSubmit: FilledRoundedButton!
    @IBOutlet weak var cltView: UICollectionView!
    
    var sessionSelectionDialog: SessionDialog!
    var recipentMassageManageDialog: PackageDetailDialog!
    var dialogForAccessory: AccessorySelectionDialog!
    var dateTimeSelectionDialog: DateTimeDialog!
    var textViewDialog: TextViewDialog!
    var languagePicker: CustomLanguagePicker!
    var pressureFocusSelectionDialog: CustomFocusAreaPicker!
    var pressureSelectionDialog: CustomPressurePicker!
    
    var packageDetail: PurchasedPackage? = nil
    var arrForData: [PackageServiceDetail] = []
    var arrForOriginalData: [PackService] = []
    
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
        }
    }
    
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped()
        _ = (self.navigationController as? NC)?.popVC()
    }
    
    private func initialViewSetup() {
        self.setTitle(title: "PACK_NO".localized() + " : " + packageDetail!.code)
        self.setupCollectionView(collectionView: self.cltView)
        self.btnSubmit.setTitle("BTN_PROCEED".localized(), for: .normal)
        self.wsGetPackServiceList()
    }
    @IBAction func btnSubmitTapped(_ sender: Any) {
        var selectedService: [PackService] = []
        selectedService.removeAll()
        for i in 0..<arrForOriginalData.count {
            let data = arrForData[i]
            if data.isSelected {
                selectedService.append(arrForOriginalData[i])
            }
        }
        if selectedService.count > 0 {
            appSingleton.requestUsePurchasePackage = MyBookingPackageData.init()
            appSingleton.requestUsePurchasePackage?.selectedServices = selectedService
            self.openBookingTypeSelectionDialog()
        } else {
            Common.showAlert(message: "Please select service first")
        }
    }
    
    @objc func openBookingProcess(sender: UIButton) {
        self.openBookingTypeSelectionDialog()
    }
}


//MARK: - PackageDetailVC

extension PackageDetailVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PackageServiceCltCell.nib()
            , forCellWithReuseIdentifier: PackageServiceCltCell.name)
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PackageServiceCltCell.name, for: indexPath) as! PackageServiceCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if !arrForData[indexPath.row].isUsed{
            arrForData[indexPath.row].isSelected.toggle()
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size)
    }
    
    
    
    
}


extension PackageDetailVC {
    func wsGetPackServiceList() {
        if let purchasePackId:String = packageDetail?.id {
            AppWebApi.getPackageServiceList(params: PackageWebService.RequestPackageServiceList.init(user_pack_id:purchasePackId)) { (response) in
                self.arrForData.removeAll()
                if ResponseModel.isSuccess(response: response) {
                    self.arrForOriginalData = response.dataList
                    for data in self.arrForOriginalData {
                        self.arrForData.append(data.toViewModel())
                    }
                    self.cltView.reloadData()
                }
            }
        }
        
    }
}
