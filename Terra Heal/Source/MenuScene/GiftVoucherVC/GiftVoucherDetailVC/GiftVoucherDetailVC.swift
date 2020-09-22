//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit




class GiftVoucherDetailVC: BaseVC {
    
    @IBOutlet weak var lblHeader: ThemeLabel!
    @IBOutlet weak var lblDescription: ThemeLabel!
    @IBOutlet weak var scrVw: UIScrollView!
    @IBOutlet weak var lblSubHeader: ThemeLabel!
    @IBOutlet weak var lblPrice: ThemeLabel!
    @IBOutlet weak var lblMassage: ThemeLabel!
    var giftVoucherDetail: GiftVoucherDetail? = nil
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
        if let data = giftVoucherDetail {
                self.setData(data: data)
        }
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
        self.lblHeader.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblSubHeader.setFont(name: FontName.SemiBold, size: FontSize.detail)
        self.lblDescription.setFont(name: FontName.Regular, size: FontSize.detail)
        self.lblPrice.setFont(name: FontName.Bold, size: FontSize.subHeader)
        self.lblMassage.setFont(name: FontName.Bold, size: FontSize.subHeader)
    }

    func setData(data: GiftVoucherDetail) {
        self.setTitle(title: "GIFT_VOUCHER_NO".localized() + " : " + data.id)
        self.lblHeader.text = data.header
        self.lblSubHeader.text = data.subHeader
        self.lblDescription.text = data.body
        self.lblPrice.text = data.price
        self.lblMassage.text = data.massage
    }

}


