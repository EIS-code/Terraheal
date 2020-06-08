//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit
// import JDFramework

class MainVC: UIViewController {
   
    @IBOutlet weak var vwBar: UIView?
    @IBOutlet weak var lblTitle: ThemeLabel?
    @IBOutlet weak var btnLeft: ThemeButton?
    @IBOutlet weak var btnRight: ThemeButton?
    
    // MARK: - LifeCycle
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.vwBar?.backgroundColor = UIColor.clear
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    // MARK: - StatusBar
    deinit {
        print("\(self) \(#function)")
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    // MARK: - IBAction
    @IBAction func btnLeftTapped(_ btn: UIButton = UIButton()) {
    }
    
    @IBAction func btnRightTapped(_ btn: UIButton = UIButton()) {
    }

    func setTitle(title: String) {
        lblTitle?.text = title
    }



 }

//MARK: Location Observer
extension MainVC {
    func addLocationObserver() {
        Common.nCd.removeObserver(self,
                               name: Common.locationUpdateNtfNm,
                               object: LC.default)
        Common.nCd.removeObserver(self,
                               name: Common.locationFailNtfNm,
                               object: LC.default)

        unowned let _self = self
        Common.nCd.addObserver(_self,
                            selector: #selector(_self.locationUpdate(_:)),
                            name: Common.locationUpdateNtfNm,
                            object: LC.default)
        Common.nCd.addObserver(_self,
                            selector: #selector(_self.locationFail(_:)),
                            name: Common.locationFailNtfNm,
                            object: LC.default)
    }
    @objc func locationUpdate(_ ntf: Notification = Common.defaultNtf) {
        
    }

    @objc func locationFail(_ ntf: Notification = Common.defaultNtf) {

    }
}




class CollectionCell: UICollectionViewCell {

}

class TableCell: UITableViewCell {

}




