//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit


struct ServiceDetail {
    var name:String = ""
    var address:String = ""
    var numberOfServices: String = ""
}

class ServiceMapVC: MainVC {


    @IBOutlet weak var btnCheckService: ThemeButton!
    @IBOutlet weak var btnBook: ThemeButton!
    @IBOutlet weak var lblAddressTitle: ThemeLabel!
    @IBOutlet weak var lblAddress: ThemeLabel!
    @IBOutlet weak var btnBack: FloatingRoundButton!
    @IBOutlet weak var vwMap: UIView!
    @IBOutlet weak var vwService: UIView!
    @IBOutlet weak var ivService: PaddedImageView!
    @IBOutlet weak var btnKm: ThemeButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Object lifecycle
    var arrForServices: [ServiceDetail] = [
        ServiceDetail(name: "terra heal massage center", address: "Lorem ipsum dolor sit,lisbon, portugal -25412", numberOfServices: "25"),
    ServiceDetail(name: "terra heal massage center 2", address: "Lorem ipsum dolor sit,lisbon, portugal -25112", numberOfServices: "35"),
    ServiceDetail(name: "terra heal massage center 3", address: "Lorem ipsum dolor sit,lisbon, portugal -25212", numberOfServices: "15")]
    
       var currentIndex: IndexPath = IndexPath.init(row: 0, section: 0)
    
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            self.btnBook?.setHighlighted(isHighlighted: false)
            self.btnCheckService?.setHighlighted(isHighlighted: true)
            self.vwMap.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
            self.vwService.roundCorners(corners:[.topLeft,.topRight], radius: 40.0)
            self.btnKm.setHighlighted(isHighlighted: true)
            
            self.ivService.setRound()
            
        }
    }
    
    private func initialViewSetup() {
        self.lblAddressTitle?.text = "Home".localized()
        self.lblAddressTitle?.setFont(name: FontName.Bold, size: FontSize.label_18)
        self.lblAddress?.text = "Lorem Ipsum, Lisbon, portugal 12451.".localized()
        self.lblAddress?.setFont(name: FontName.Regular, size: FontSize.label_14)
        self.btnBook.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.btnBook.setTitle("BTN_BOOK_HERE".localized(), for: .normal)
        self.btnCheckService.setTitle("BTN_CHECK_SERVICE".localized(), for: .normal)
        self.btnCheckService.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        self.setupCollectionView(collectionView: self.collectionView)
        
        
    }


    // MARK: Action Buttons
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped(btn)
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnCheckServiceTapped(_ sender: Any) {
        //Common.appDelegate.loadRegisterVC()
    }
    @IBAction func btnBookhereTapped(_ sender: Any) {
        //Common.appDelegate.loadHomeVC()
    }
    @IBAction func btnCurrentLocationTapped(_ sender: Any) {
    }
    
    // MARK: Other Functions

}


// MARK: - CollectionView Methods
extension ServiceMapVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate {
    // MARK: UICollectionViewDataSource
    
    private func setupCollectionView(collectionView:  UICollectionView) {
        collectionView.backgroundColor = UIColor.clear
        collectionView.isUserInteractionEnabled = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ServiceCell.nib()
            , forCellWithReuseIdentifier: ServiceCell.name)

    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForServices.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCell.name, for: indexPath) as! ServiceCell
        cell.layoutIfNeeded()
        cell.setData(data: self.arrForServices[indexPath.row])
        cell.layoutIfNeeded()
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.bounds.width
        return CGSize(width: size - 10, height: collectionView.bounds.height)
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {

        if scrollView == collectionView {

            /*let middlePoint = Int(scrollView.contentOffset.x + UIScreen.main.bounds.width / 2)
            if let indexPath = self.cvForTutorial.indexPathForItem(at: CGPoint(x: middlePoint, y: Int(self.cvForTutorial.center.y))) {
                self.currentIndex = indexPath
                self.snapToNearestCell(indexPath: indexPath)
            }*/

        }

    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /*if scrollView == cvForTutorial {
            let middlePoint = Int(scrollView.contentOffset.x + UIScreen.main.bounds.width / 2)
            if let indexPath = self.cvForTutorial.indexPathForItem(at: CGPoint(x: middlePoint, y: Int(self.cvForTutorial.center.y))) {
                self.currentIndex = indexPath
                self.snapToNearestCell(indexPath: indexPath)
            }
        }*/
    }
}
