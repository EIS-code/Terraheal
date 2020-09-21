//
//  Created by Jaydeep Vyas
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire



class MainVC: BaseVC {
    
    @IBOutlet weak var btnProfile: FloatingRoundButton!
    @IBOutlet weak var btnMenu: FloatingRoundButton!
    @IBOutlet weak var vwFloatingBottom: HomeSegmentedControl!
    @IBOutlet weak var ivUser: RoundedImageView!
    
    @IBOutlet weak var homeView: UIView!
    @IBOutlet weak var exploreView: UIView!
    @IBOutlet weak var myFavView: UIView!
    
    
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
        self.homeView.isHidden = false
        self.exploreView.isHidden = true
        self.myFavView.isHidden = true
        self.add(HomeVC.fromNib(), view:self.homeView)
        self.add(ExploreMapVC.fromNib(), view:self.exploreView)
        self.add(MyFavVC.fromNib(), view: self.myFavView)
        
        vwFloatingBottom.height(constant: JDDeviceHelper.offseter(offset: CommonSize.Button.standard))
        vwFloatingBottom.allowChangeThumbWidth = false
        vwFloatingBottom.itemTitles = ["HOME_BTN_HOME".localized(),"HOME_BTN_EXPLORE".localized(),"HOME_BTN_MY_FAV".localized()]
        vwFloatingBottom.itemImages =  [UIImage.init(named: "asset-home")!, UIImage.init(named: "asset-explore")!, UIImage.init(named: "asset-fav")!]
        vwFloatingBottom.itemSelectedImages = [UIImage.init(named: "asset-home-selected")!, UIImage.init(named: "asset-explore-selected")!, UIImage.init(named: "asset-fav-selected")!]
        vwFloatingBottom.changeThumbColor(UIColor.themePrimary)
        vwFloatingBottom.changeBackgroundColor(UIColor.themeLightTextColor)
        vwFloatingBottom.didSelectItemWith = { [weak self] (index,title) in
            guard let self = self else { return } ; print(self)
            switch index {
            case 0:
                self.homeButtonSelected()
            case 1:
                self.exploreButtonSelected()
            default:
                self.favouriteButtonSelected()
            }
        }
        self.addLocationObserver()
        self.btnMenu.addTarget(self.revealViewController(), action: #selector(PBRevealViewController.revealLeftView), for: .touchUpInside)
        
     }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let lc = LocationCenter.init()
        lc.requestLocationOnce()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.isViewAvailable() {
            vwFloatingBottom.setRound(withBorderColor: .clear, andCornerRadious: self.vwFloatingBottom.bounds.height/2.0, borderWidth: 0.1)
            vwFloatingBottom.setHomeBottomMenuShadow()
        }
    }
    
    private func initialViewSetup() {
        self.setBackground(color: UIColor.themeBackground)
        if appSingleton.user.name.isEmpty() {
            self.ivUser.image = UIImage.init(named: ImageAsset.Placeholder.user)
        } else {
            self.ivUser.downloadedFrom(link: appSingleton.user.profilePhoto)
        }
    }
    func homeButtonSelected() {
        self.myFavView.gone()
        self.exploreView.gone()
        self.homeView.visible()
        self.gradientView.isHidden = false
    }
    
    func favouriteButtonSelected() {
        self.myFavView.visible()
        self.exploreView.gone()
        self.homeView.gone()
        self.gradientView.isHidden = false
    }
    
    func exploreButtonSelected() {
        self.myFavView.gone()
        self.exploreView.visible()
        self.homeView.gone()
        self.gradientView.isHidden = true
    }
    
    //MARK: Action Methods
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        if PreferenceHelper.shared.getUserId().isEmpty() {
            Common.appDelegate.loadWelcomeVC()
        } else {
            self.revealViewController()?.revealRightView()
        }
    }
    //MARK: Location Observer
    override func locationUpdate(_ ntf: Notification = Common.defaultNtf) {
        if let locationDict: [String: Any]  = ntf.userInfo?["ncd"] as? [String:Any] {
            if let location = locationDict["location"]  {
                if let coordinate =  (location as?  CLLocation)?.coordinate {
                    print(coordinate.latitude)
                }
            }
        }
    }
    
    override func locationFail(_ ntf: Notification = Common.defaultNtf) {
    }
    
    
}


