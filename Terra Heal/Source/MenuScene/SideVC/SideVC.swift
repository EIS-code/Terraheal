//
//  SideVC.swift
//  Dumparoo
//  Created by Jaydeep Vyas on 03/05/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit

struct MenuItem {
    var id: Menu = Menu.Campaigns
    var image: String = ""
    var isVerticle: Bool = true
}
enum Menu: String {
    case HowItWork = "0"
    case ReferAndEarn = "1"
    case PricingAndLocation = "2"
    case PromoCode = "3"
    case Notifications = "4"
    case Packs = "5"
    case Help = "6"
    case Campaigns = "7"
    case GiftVoucher = "8"
    func name() -> String {
        switch self {
        case .HowItWork:
            return "MENU_HOW_IT_WORKS".localized()
        case .ReferAndEarn:
            return "MENU_REFER_AND_EARN".localized()
        case .PricingAndLocation:
            return "MENU_PRINCING_AND_LOCATION".localized()
        case .PromoCode:
            return "MENU_PROMO_CODE".localized()
        case .Notifications:
            return "MENU_NOTIFICATIONS".localized()
        case .Packs:
            return "MENU_PACKS".localized()
        case .Help:
            return "MENU_HELP".localized()
        case .Campaigns:
            return "MENU_CAMPAINGNS".localized()
        case .GiftVoucher:
            return "MENU_GIFT_VOUCHER".localized()
        }
    }

    func image() -> String {
           switch self {
           case .HowItWork:
            return ImageAsset.SideMenu.howItWork
           case .ReferAndEarn:
               return ImageAsset.SideMenu.referAndEarn
           case .PricingAndLocation:
               return ImageAsset.SideMenu.pricingAndLocation
           case .PromoCode:
               return ImageAsset.SideMenu.promocode
           case .Notifications:
               return ImageAsset.SideMenu.notifications
           case .Packs:
               return ImageAsset.SideMenu.packs
           case .Help:
               return ImageAsset.SideMenu.help
           case .Campaigns:
               return ImageAsset.SideMenu.campaigns
           case .GiftVoucher:
               return ImageAsset.SideMenu.giftvoucher
           }
       }
}

class SideVC: MainVC {

    @IBOutlet weak var lblMenu: ThemeLabel!
    @IBOutlet weak var btnClose: FloatingRoundButton!
    @IBOutlet weak var cvForMenu: UICollectionView!
    var idxPathSelected: IndexPath = IndexPath(row: -1, section: -1)
   
    var arrForMenu: [MenuItem] = [
        MenuItem.init(id: Menu.HowItWork, image: "", isVerticle: true),
        MenuItem.init(id: Menu.ReferAndEarn, image: "", isVerticle: true),
        MenuItem.init(id: Menu.PricingAndLocation, image: "", isVerticle: true),
        MenuItem.init(id: Menu.PromoCode, image: "", isVerticle: true),
        MenuItem.init(id: Menu.Notifications, image: "", isVerticle: false),
        MenuItem.init(id: Menu.Packs, image: "", isVerticle: false),
        MenuItem.init(id: Menu.Campaigns, image: "", isVerticle: false),
        MenuItem.init(id: Menu.GiftVoucher, image: "", isVerticle: true),
        MenuItem.init(id: Menu.Help, image: "", isVerticle: false),
    ]

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.lblMenu.text = "LBL_MENU".localized()
        self.lblMenu.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setupCollectionView()
    }

    @IBAction func btnCloseTapped(_ sender: Any) {
        self.revealViewController()?.revealLeftView()
        //SideVC.shared.hide()
    }
}

// MARK: -

extension UITableView {

    func setBackgroundImage(image:UIImage?) {
        if let img = image {
            let backgroundImage = UIImageView(image: img)
            backgroundImage.contentMode = UIView.ContentMode.scaleToFill
            backgroundImage.clipsToBounds = false
            self.backgroundColor = UIColor.clear
            self.backgroundView = backgroundImage
        }
    }

}


// MARK: - CollectionView Methods
extension SideVC:  UICollectionViewDelegate, UICollectionViewDataSource {

    private func setupCollectionView() {
        cvForMenu?.backgroundColor = UIColor.white
        cvForMenu?.isUserInteractionEnabled = true
        cvForMenu?.isPagingEnabled = true
        cvForMenu?.delegate = self
        cvForMenu?.dataSource = self
        cvForMenu?.showsVerticalScrollIndicator = false
        cvForMenu?.showsHorizontalScrollIndicator = false
        if let layout = cvForMenu?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        cvForMenu?.register(MenuCellVerticle.nib()
            , forCellWithReuseIdentifier: MenuCellVerticle.name)
        cvForMenu?.register(MenuCellHorizontal.nib()
            , forCellWithReuseIdentifier: MenuCellHorizontal.name)
    }

    // MARK: UICollectionViewDataSource
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrForMenu.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = arrForMenu[indexPath.row]
        if data.isVerticle {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCellVerticle.name, for: indexPath) as! MenuCellVerticle

            cell.layoutIfNeeded()
            cell.setData(menuDetail: data)
            cell.layoutIfNeeded()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCellHorizontal.name, for: indexPath) as! MenuCellHorizontal
            cell.layoutIfNeeded()
            cell.setData(menuDetail: data)
            cell.layoutIfNeeded()
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if  let mainVC = self.revealViewController()?.leftViewController as? NC{
            switch self.arrForMenu[indexPath.row].id {
                   case Menu.Notifications:
                       Common.appDelegate.loadNotificationVC(navigaionVC: mainVC)
                   case Menu.HowItWork:
                       Common.appDelegate.loadHowItWorkVC(navigaionVC: mainVC)
                   case Menu.PricingAndLocation:
                       Common.appDelegate.loadPriceLocationVC(navigaionVC: mainVC)
                   case Menu.PromoCode:
                       Common.appDelegate.loadPromocodeVC(navigaionVC: mainVC)
                   case Menu.Packs:
                       Common.appDelegate.loadPackVC(navigaionVC: mainVC)
                   case Menu.ReferAndEarn:
                       Common.appDelegate.loadReferAndEarnVC(navigaionVC: mainVC)
                   case Menu.Campaigns:
                       Common.appDelegate.loadCampaignsVC(navigaionVC: mainVC)
                   case Menu.Help:
                       Common.appDelegate.loadHelpVC(navigaionVC: mainVC)
                   case Menu.GiftVoucher:
                       Common.appDelegate.loadGiftVoucherVC(navigaionVC: mainVC)
                   }
        }
       
    }

}

extension SideVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let heightSizes = [(collectionView.bounds.height/3.5),(collectionView.bounds.height/7)]
        return CGFloat(heightSizes[arrForMenu[indexPath.row].isVerticle ? 0 : 1])

    }
}
