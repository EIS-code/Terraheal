//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit

class ServiceSelectionVC: MainVC {
    
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var collectionVw: UICollectionView!
    @IBOutlet weak var vwServiceSelection: JDSegmentedControl!
    
    var selectedService: ServiceType = ServiceType.Massages
    var arrForData: [String] = ["head, neck and shoulders", "tok sen - thai massage", "hand or foot massage","thai yoga massage","head, neck and shoulders", "tok sen - thai massage", "hand or foot massage","thai yoga massage"]
    
    var arrForMassage: [String] = ["head, neck massage", "tok sen - thai massage", "hand or foot massage","thai yoga massage","head, neck and shoulders", "tok sen - thai massage", "hand or foot massage","thai yoga massage"]
    var arrForTherapies: [String] = ["head, neck therapy", "tok sen - thai therapy", "hand or foot therapy","thai yoga therapy","head, neck and therapy", "tok sen - thai therapy", "hand or foot therapy","thai yoga therapy"]
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
            vwServiceSelection.setRound(withBorderColor: .themePrimary, andCornerRadious: self.vwServiceSelection.bounds.height/2.0, borderWidth: 0.1)
            vwServiceSelection.setShadow()
            self.collectionVw?.reloadData({
                
            })
            
        }
        
        
    }
    private func initialViewSetup() {
        
        self.lblTitle?.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setTitle(title: "SELECT_SERIVICE_TITLE".localized())
        self.setupCollectionView(collectionView: self.collectionVw)
        self.vwServiceSelection.allowChangeThumbWidth = false
        self.vwServiceSelection.itemTitles = ["massages".localized(),"therapies".localized()]
        self.vwServiceSelection.changeBackgroundColor(UIColor.themeLightTextColor)
        self.vwServiceSelection.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else {
                return
            }
            
            if index == 0 {
                self.massagesTapped()
            } else {
                self.therapiesTapped()
            }
        }
    }
    
    
    @IBAction func btnBackTapped(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func massagesTapped(){
        self.arrForData = self.arrForMassage
        self.vwServiceSelection.selectItemAt(index: 0)
        self.selectedService = ServiceType.Massages
        collectionVw.reloadData()
    }
    
    func therapiesTapped(){
        self.arrForData = self.arrForTherapies
        self.vwServiceSelection.selectItemAt(index: 1)
        self.selectedService = ServiceType.Therapies
        collectionVw.reloadData()
    }
    
    func openServiceDurationSelection() {
        
        let durationSelectionDialog: DurationSelectionDialog = DurationSelectionDialog.fromNib()
        durationSelectionDialog.initialize(title: "Select duration",message: "note:- 23% VAT is included", buttonTitle: "BTN_PROCEED".localized(), cancelButtonTitle: "BTN_BACK".localized())
        durationSelectionDialog.show(animated: true)
        durationSelectionDialog.onBtnCancelTapped = {
            [weak durationSelectionDialog, weak self] in
            guard let self = self else { return } ; print(self)
            durationSelectionDialog?.dismiss()
        }
        durationSelectionDialog.onBtnDoneTapped = {
            [weak durationSelectionDialog, weak self]  (hour) in
            guard let self = self else { return } ; print(self)
            durationSelectionDialog?.dismiss()
            
        }
    }
    
    
}


// MARK: - CollectionView Methods
extension ServiceSelectionVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(LocationServiceCltCell.nib()
            , forCellWithReuseIdentifier: LocationServiceCltCell.name)
        
    }
    
    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationServiceCltCell.name, for: indexPath) as! LocationServiceCltCell
        cell.setData(data: self.arrForData[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.openServiceDurationSelection()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width / 2.0
        return CGSize(width: size , height: size)
    }
    
    
}

