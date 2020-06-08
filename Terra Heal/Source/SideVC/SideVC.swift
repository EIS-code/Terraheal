//
//  SideVC.swift
//  Dumparoo
//  Created by Jaydeep Vyas on 03/05/19.
//  Copyright © 2019 Jaydeepvyas. All rights reserved.
//

import UIKit
// import JDFramework
typealias SO = SOther

class SOther: NSObject {

    static var vwBg: UIView = UIView()
    static let maxAlphaVwBg: CGFloat = 1.0
    static let animateDuration: TimeInterval = 0.3
    static var timeInterval: TimeInterval = 0.0
    static var speed: Int = 0
    static let maxSpeed: Int = 1555
    static var startX: Int = 0
    static var X: Int = 0


    class func addVwBgToVw(_ vw: UIView) {
        SO.vwBg.frame = vw.bounds
        SO.vwBg.backgroundColor = UIColor(white: 0.0, alpha: 1.0)
        SO.vwBg.alpha = 0.0
        vw.addSubview(SO.vwBg)
    }

    class func removeVwBg() {
        SO.vwBg.alpha = 0.0
        SO.vwBg.removeFromSuperview()
    }

}

struct MenuItem {
    var name: String = ""
    var image: String = ""
    var id: Menu = Menu.Campaigns
    var isVerticle: Bool = true
}
enum Menu: String {
    case HowItWork = "0"
    case ReferAndEarn = "1"
    case PricingAndLocation = "2"
    case PromoCode = "3"
    case Packs = "4"
    case Help = "5"
    case Campaigns = "6"
    case GiftVoucher = "7"


}
class SideVC: MainVC {



    @IBOutlet weak var lblMenu: ThemeLabel!
    @IBOutlet weak var btnClose: FloatingRoundButton!
    @IBOutlet weak var cvForMenu: UICollectionView!

    var isOpen: Bool = false
    var idxPathSelected: IndexPath = IndexPath(row: -1, section: -1)

    static let shared: SideVC = {
        let instance: SideVC = SideVC.fromNib()
        return instance
    }()

    var arrForMenu: [MenuItem] = [
        MenuItem.init(name: "MENU_ITEM_1".localized(), image: "", id: Menu.HowItWork, isVerticle: true),
        MenuItem.init(name: "MENU_ITEM_2".localized(), image: "", id: Menu.ReferAndEarn, isVerticle: true),
        MenuItem.init(name: "MENU_ITEM_3".localized(), image: "", id: Menu.PricingAndLocation, isVerticle: true),
        MenuItem.init(name: "MENU_ITEM_4".localized(), image: "", id: Menu.PromoCode, isVerticle: false),
        MenuItem.init(name: "MENU_ITEM_5".localized(), image: "", id: Menu.Help, isVerticle: false),
        MenuItem.init(name: "MENU_ITEM_6".localized(), image: "", id: Menu.Packs, isVerticle: false),
        MenuItem.init(name: "MENU_ITEM_7".localized(), image: "", id: Menu.Campaigns, isVerticle: false),
        MenuItem.init(name: "MENU_ITEM_8".localized(), image: "", id: Menu.GiftVoucher, isVerticle: true)
    ]

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        self.lblMenu.text = "LBL_MENU".localized()
        self.lblMenu.setFont(name: FontName.Bold, size: FontSize.label_26)
        self.setupCollectionView()
    }

    @IBAction func btnCloseTapped(_ sender: Any) {
        SideVC.shared.hide()
    }
    // MARK: Other

    class func addToVC(_ vC: UIViewController) {
        
        let sideVC: SideVC = SideVC.shared
        SO.timeInterval = Date.timeIntervalSinceReferenceDate
        SO.speed = 0
        SO.startX = 0
        SO.X = 0

        SideVC.vwFrame(vC.view.frame)
        SO.addVwBgToVw(vC.view)

        if vC.view.isKind(of: STouchVw.self) {
            let sTouchVw: STouchVw = vC.view as! STouchVw
            sTouchVw.sideVC = sideVC
            sTouchVw.allowSide = true
        }

        vC.addChild(sideVC)
        vC.view.addSubview(sideVC.view)

        //sideVC.selectDefault()
    }

    class func remove() {
        let sideVC: SideVC = SideVC.shared
        sideVC.hide()
        SO.removeVwBg()
        sideVC.view.removeFromSuperview()
        sideVC.removeFromParent()
        
    }

    class func vwFrame(_ frame: CGRect) {
        let sideVC: SideVC = SideVC.shared
        var rect: CGRect = frame
        rect.origin.x -= frame.size.width
        rect.origin.x *=  1.0
        sideVC.view.frame = rect
    }



    func show() {
        self.isOpen = true

        UIView.animate(withDuration: SO.animateDuration,
                       animations: {
                        self.view.frame.origin.x = 0.0
                        SO.vwBg.alpha = SO.maxAlphaVwBg
        }) { (bl: Bool) in
        }
    }

    func show(withPoint point: CGPoint) {
        let screenWidth: CGFloat = Common.screenRect.size.width
        let diff: CGFloat = screenWidth-self.view.frame.size.width
        let difference: Int = SO.startX-SO.X
        var rect: CGRect = self.view.frame

        if point.x <= screenWidth {

                let originX: CGFloat = point.x-screenWidth+diff
                rect.origin.x = originX > 0.0 ? 0.0 : originX

                if self.isOpen {
                    rect.origin.x = (difference > 0) ? CGFloat(-difference) : 0.0
                }

                self.view.frame = rect

                if !(self.isOpen && (difference <= 0)) {
                    let alpha: CGFloat = (point.x*SO.maxAlphaVwBg)/(screenWidth-diff)
                    SO.vwBg.alpha = alpha > SO.maxAlphaVwBg ? SO.maxAlphaVwBg : alpha
                }
        }
    }

    func hide(_ completion: (() -> Void)? = nil) {
        self.isOpen = false

        var x: CGFloat = Common.screenRect.size.width
        x *=  -1.0

        UIView.animate(withDuration: SO.animateDuration,
                       animations: {
                        //self.view.frame.origin.x -= Cmn.screenRect.size.width
                        self.view.frame.origin.x = x
                        SO.vwBg.alpha = 0.0
        }) { (bl: Bool) in
            if bl {
                completion?()
            }
        }
    }


}

// MARK: -

class STouchVw: ThemeView {

    weak var sideVC: SideVC?
    var allowSide: Bool = false

    // MARK: LifeCycle

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let vw: UIView = super.hitTest(point, with: event) ?? UIView()

        let screenWidth: CGFloat = Common.screenRect.size.width
        let condition: Bool = (point.x < 20.0)

        if let sideVC = self.sideVC  {
            if /*(point.x < 20.0)*/ condition && (point.y >= 80.0) {
                self.allowSide = true
                return self
            }
            else {
                if sideVC.isOpen {
                    self.allowSide = true

                    if vw.isKind(of: UITableView.self) {
                        return self
                    }
                    else {
                        if sideVC.view.frame.contains(point) {
                            return vw
                        }
                        else {
                            return self
                        }
                    }
                }
                else {
                    self.allowSide = false
                }
            }
        }

        return vw
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        if let touch = touches.first {
            let point: CGPoint = touch.location(in: self)
            SO.startX = Int(point.x)
            SO.X = Int(point.x)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)

        if let touch = touches.first, let sideVC = self.sideVC {
            let pointPrevious: CGPoint = touch.previousLocation(in: self)
            let point: CGPoint = touch.location(in: self)
            SO.X = Int(point.x)

            if self.allowSide {
                sideVC.show(withPoint: point)
            }

            let timeInterval: TimeInterval = Date.timeIntervalSinceReferenceDate-SO.timeInterval
            let xMove: CGFloat = point.x-pointPrevious.x
            let yMove: CGFloat = point.y-pointPrevious.y
            let distance: CGFloat = sqrt((xMove*xMove)+(yMove*yMove))
            SO.speed = Int(distance/CGFloat(timeInterval))
            SO.timeInterval = Date.timeIntervalSinceReferenceDate
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        if let touch = touches.first, let sideVC = self.sideVC {
            if self.allowSide {
                let point: CGPoint = touch.location(in: self)
                let difference: Int = SO.startX-SO.X
                let width: CGFloat = (sideVC.view?.frame.size.width ?? 0.0)/3.0


                    if sideVC.isOpen {
                        if (SO.speed >= SO.maxSpeed && difference > 0) ||
                            (point.x <= width && difference > 0) {
                            sideVC.hide()
                        }
                        else {
                            self.sideVCTblVwContains(point)
                        }
                    }
                    else {
                        if (SO.speed >= SO.maxSpeed) ||
                            (point.x >= width) {
                            sideVC.show()
                        }
                        else {
                            sideVC.hide()
                        }
                    }

            }
        }
    }

    func sideVCTblVwContains(_ point: CGPoint) {
        if let sideVC = self.sideVC {
            if sideVC.view.frame.contains(point) {
                sideVC.show()
            }
            else {
                sideVC.hide()
            }
        }
    }

}


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
    }

}

extension SideVC: PinterestLayoutDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        let heightSizes = [(collectionView.bounds.height/3),(collectionView.bounds.height/6)]
        return CGFloat(heightSizes[arrForMenu[indexPath.row].isVerticle ? 0 : 1])

    }
}
