import UIKit
import GoogleMaps
import CoreLocation


class ExploreMapVC: BaseVC {
    
    //MARK:
    //MARK: Outlets
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var btnCurrentLocation: FloatingRoundButton!
    var lc: LocationCenter? = nil
    var arrForServices: [ServiceCenterDetail] = []
    var arrForServicesMarker: [GMSMarker] = []
    var isEnableToCallApi:Bool = true
    //MARK:
    //MARK: View life cycle
    override func viewDidLoad(){
        super.viewDidLoad();
        self.setBackground(color: .themeBackground)
        self.lc = LocationCenter()
        self.setupMapView(mapView: self.mapView)
        self.addLocationObserver()

    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews();
        setupLayout()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool){
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool){
        super.viewDidDisappear(animated)
    }
    
    
    
    func  setupLayout(){
        if self.isViewAvailable() {
            self.mapView.roundCorners(corners: [.topLeft,.topRight], radius: 40.0)
        }
    }
    
    
    @IBAction func onClickBtnCurrentLocation(_ sender: Any) {
        //gettingCurrentLocation()
        self.focusAllMarkers()
    }
    
    func gettingCurrentLocation() {
        lc?.requestLocationOnce()
    }
    
    func animateToLocation(coordinate:CLLocationCoordinate2D) {
        CATransaction.begin()
        CATransaction.setValue(1.0, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock {
        }
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17.0, bearing: 45, viewingAngle: 0.0)
        self.mapView.animate(to: camera)
        CATransaction.commit()
    }
    
    //MARK: Location Observer
    
    override func locationUpdate(_ ntf: Notification = Common.defaultNtf) {
        if let locationDict: [String: Any]  = ntf.userInfo?["ncd"] as? [String:Any] {
            if let location = locationDict["location"]  {
                if let coordinate =  (location as?  CLLocation)?.coordinate {
                    print(coordinate)
                    //  self.animateToLocation(coordinate: coordinate)
                    self.getMassageCenter()
                }
            }
        }
    }
    
    override func locationFail(_ ntf: Notification = Common.defaultNtf) {
    }

    func getMassageCenter() {
        if self.isEnableToCallApi {
            self.isEnableToCallApi = false
            AppWebApi.massageCenterList(params: ServiceCenter.RequestServiceCenterlist()) { (response) in
                self.isEnableToCallApi = true
                self.arrForServices.removeAll()
                self.removeAllCenterMarker()
                if ResponseModel.isSuccess(response: response, withSuccessToast: false, andErrorToast: false) {
                    for i  in 0..<response.serviceCenterList.count {
                        let data = response.serviceCenterList[i]
                        self.arrForServices.append(data)
                    }
                    self.createNewCenterMarkers()
                }
            }
        }

    }

    func removeAllCenterMarker() {
        for marker in self.arrForServicesMarker {
            marker.map = nil
        }
        self.arrForServicesMarker.removeAll()
    }

    func createNewCenterMarkers() {
        self.removeAllCenterMarker()

        for i  in 0..<arrForServices.count {
            let center: ServiceCenterDetail = self.arrForServices[i]
            let marker:GMSMarker = GMSMarker.init(position: center.getCoordinatte())
            marker.title  = center.name
            marker.map = self.mapView
            marker.userData = i

            print("Position \(marker.position)")
            self.arrForServicesMarker.append(GMSMarker.init(position: center.getCoordinatte()))
            self.mapView.setMassageCenterMarker(marker: marker, image: UIImage.init(named: "asset-center-maker")!, location: center.getCoordinatte())
        }
        self.focusAllMarkers()

    }
    func focusAllMarkers() {
        let bounds: GMSCoordinateBounds = GMSCoordinateBounds.init()
        for marker in arrForServicesMarker {
            bounds.includingCoordinate(marker.position)
        }
        self.mapView.animate(toZoom: 15.0)
        self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 0.0))
    }
}

extension ExploreMapVC :GMSMapViewDelegate {
    
    func setupMapView(mapView: GMSMapView) {
        mapView.delegate = self;
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.settings.allowScrollGesturesDuringRotateOrZoom = false;
        mapView.padding = UIEdgeInsets.init(top: super.getTopInset(), left: 20, bottom: super.getBottomInset(), right: 20)
        mapView.applyStyle()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition){
        
    }

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        return true
    }

    func loadMyServiceVC(){
        appSingleton.myBookingData.booking_type = BookingType.AtHotelOrRoom
        Common.appDelegate.loadServiceMapVC(navigaionVC: self.navigationController)
    }
}
