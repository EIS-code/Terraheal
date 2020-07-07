//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




class ServiceDetailVC: MainVC {
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var ivPicture: UIImageView!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var lblServiceName: ThemeLabel!
    @IBOutlet weak var lblServiceDetail: ThemeLabel!
    @IBOutlet weak var collectionVw: UICollectionView!
    var serviceDetail: ServiceDetail = ServiceDetail.init()
    var arrForData: [ServiceDurationDetail] = []
    @IBOutlet weak var hCltVw: NSLayoutConstraint!
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
        self.setCollectionData()
        self.setupCollectionView(collectionView: collectionVw)
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
            
            self.ivPicture?.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
            self.collectionVw.reloadData(heightToFit: self.hCltVw) {
                
            }
            //self.collectionVwForProfile?.reloadData()
        }
    }
    
    private func initialViewSetup() {
        self.lblTitle?.text = ""//appSingleton.user.name
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.lblServiceName?.text = serviceDetail.name
        self.lblServiceName?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.lblServiceDetail?.text = serviceDetail.serviceDetails
        self.lblServiceDetail?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.btnBack.setBackButton()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
   
    // MARK: - Other Methods
    
   
    func setCollectionData() {
        
        self.ivPicture.downloadedFrom(link: appSingleton.user.profilePhoto)
        self.arrForData = [ ServiceDurationDetail(amount: "100", duration: "120 min"),
                            ServiceDurationDetail(amount: "100", duration: "120 min"),
                            ServiceDurationDetail(amount: "100", duration: "120 min"),
                            ServiceDurationDetail(amount: "100", duration: "120 min")]
        self.collectionVw.reloadData(heightToFit: self.hCltVw) {
            
        }
        
    }
}

// MARK: - CollectionView Methods
extension ServiceDetailVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SeviceDurationCltCell.nib()
            , forCellWithReuseIdentifier: SeviceDurationCltCell.name)
        scrVw.delegate = self
        
        
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeviceDurationCltCell.name, for: indexPath) as! SeviceDurationCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        cell.parent = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let data = arrForData[indexPath.row]
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0 - 5
        return CGSize(width: size , height:size)
    }
    
    
}

