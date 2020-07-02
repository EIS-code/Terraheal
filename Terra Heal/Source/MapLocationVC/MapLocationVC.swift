import UIKit
import GoogleMaps
import GooglePlaces

@objc protocol LocationHandlerDelegate: class {
    
    func finalAddressAndLocation(address:String,latitude:Double,longitude:Double)
    
}
struct AutoCompleteAddress {
    var title: NSAttributedString!
    var subTitle: NSAttributedString!
    var placeID: String = ""
}
class MapLocationVC: MainVC,UINavigationControllerDelegate,UIScrollViewDelegate,GMSMapViewDelegate
{
    
    var delegate:LocationHandlerDelegate?
    //MARK:
    //MARK: Outlets
    
    @IBOutlet weak var tblAutocomplete: UITableView!
    @IBOutlet weak var heightForAutoComplete: NSLayoutConstraint!
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var imgForLocation: UIImageView!
    @IBOutlet weak var btnCurrentLocation: FloatingRoundButton!
    
    @IBOutlet weak var btnDone: ThemeButton!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var txtSearchBar: ThemeTextField!
    var onBtnDoneTapped: ((_ data: Address ) -> Void)? = nil
    var selectedAddress: Address = Address.init(fromDictionary: [:])
    
    var focusLocation:CLLocationCoordinate2D = CLLocationCoordinate2D.init(latitude: 22.30, longitude: 70.80)
    var arrForAdress:[AutoCompleteAddress] = []
    let lc = LocationCenter()
    //MARK:
    //MARK: Variables
    
    //MARK:
    //MARK: View life cycle
    override func viewDidLoad(){
        super.viewDidLoad();
        setLocalization()
        self.setupSearchbar(searchBar: self.txtSearchBar)
        self.setupTableView(tableView: self.tblAutocomplete)
        self.mapView.padding = UIEdgeInsets.init(top: searchVw.frame.maxY, left: 20, bottom: searchVw.frame.maxY, right: 20)
        
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        txtSearchBar.becomeFirstResponder()
        
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
    
    func  setLocalization(){
        //COLORS
        
        
        
        
        self.btnDone.setTitle("BTN_PROCEED".localized(), for: .normal)
        self.btnDone.setFont(name: FontName.SemiBold, size: FontSize.button_14)
        
        
        self.mapView.delegate = self;
        self.mapView.translatesAutoresizingMaskIntoConstraints = false
        self.mapView.settings.allowScrollGesturesDuringRotateOrZoom = false;
        
        do {
            // Set the map style by passing the URL of the local file. Make sure style.json is present in your project
            if let styleURL = Bundle.main.url(forResource: "styleable_map", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                print("Unable to find style.json")
            }
        } catch {
            print("The style definition could not be loaded: \(error)")
        }
        
    }
    
    
    
    @IBAction func onClickDismiss(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
    
    func  setupLayout(){
        if self.isViewAvailable() {
                btnDone.setHighlighted(isHighlighted: true)
                searchVw.setRound(withBorderColor: .clear, andCornerRadious: 10.0, borderWidth: 1.0)
                searchVw.setShadow()
        }
    }
    //MARK:
    //MARK: Button action methods
    @IBAction func onClickBtnDone(_ sender: UIButton){
        if self.onBtnDoneTapped != nil {
            self.onBtnDoneTapped!(selectedAddress);
        }
       
    }
    override func btnLeftTapped(_ btn: UIButton = UIButton()) {
        super.btnLeftTapped(btn)
        if let nc = self.navigationController {
            _ = nc.popViewController(animated: true)
        } else  {
            self.dismiss(animated: true) {
                
            }
        }
        
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition){
        
        let point = mapView.center;
        let myCoordinate = mapView.projection.coordinate(for: point)
        lc.getAddressFromCoordinate(coordinate: myCoordinate) { (address) in
            self.selectedAddress = address
            self.txtSearchBar.text = self.selectedAddress.addressLine1
            self.btnDone.visible()
        }
        
        
    }
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        self.btnDone.gone()
    }
    
    
    @IBAction func onClickBtnCurrentLocation(_ sender: Any) {
        gettingCurrentLocation()
    }
    func gettingCurrentLocation()
    {
      /*
        locationManager.currentUpdatingLocation { (location,
            error) in
            if error != nil
            {
                //Utility.showToast(message: "VALIDATION_MSG_INVALID_LOCATION".localized)
            }
            else
            {
                if let currentLocation  = location
                {
                    if currentLocation.coordinate.latitude != 0.0 && currentLocation.coordinate.longitude != 0.0
                    {
                        CurrentTrip.shared.currentCoordinate = currentLocation.coordinate
                        self.animateToCurrentLocation()
                    }
                    else
                    {
                        //Utility.showToast(message: "VALIDATION_MSG_INVALID_LOCATION".localized)
                    }
                }
                else
                {
                    //Utility.showToast(message: "VALIDATION_MSG_INVALID_LOCATION".localized)
                }
            }
            
        }*/
    }
    func animateToCurrentLocation()
        
    {
        
        CATransaction.begin()
        CATransaction.setValue(1.0, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock {
        }
       /* let camera = GMSCameraPosition.camera(withTarget: self.location, zoom: 17.0, bearing: 45, viewingAngle: 0.0)
        self.mapView.animate(to: camera)*/
        
        CATransaction.commit()
        
    }
    func animateToLocation(coordinate:CLLocationCoordinate2D)
    {
        CATransaction.begin()
        CATransaction.setValue(1.0, forKey: kCATransactionAnimationDuration)
        CATransaction.setCompletionBlock {
        }
        let camera = GMSCameraPosition.camera(withTarget: coordinate, zoom: 17.0, bearing: 45, viewingAngle: 0.0)
        
        self.mapView.animate(to: camera)
        CATransaction.commit()
    }
    
    @IBAction func onClickBtnAddress(_ sender: Any) {
        txtSearchBar.becomeFirstResponder()
    }
}


extension MapLocationVC : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func setupSearchbar(searchBar: UITextField) {
        txtSearchBar.delegate = self
        txtSearchBar.setFont(name: FontName.Regular, size: FontSize.label_14)
        txtSearchBar.addTarget(self, action: #selector(searching(_:)), for: .editingChanged)
        txtSearchBar.changePlaceHolder(color: UIColor.themePrimary)
        txtSearchBar.placeholder = "TXT_SEARCH_ADDRESS".localized()
    }
    
    func searchData(for text: String) {
        if (text.count) > 2
        {
            lc.getAutocomplete(text: text) { (array) in
                
                self.arrForAdress = array
                if self.arrForAdress.count > 0
                {
                    self.heightForAutoComplete.constant = self.tblAutocomplete.contentSize.height
                    self.reloadTableDateToFitHeight(tableView: self.tblAutocomplete)
                    self.tblAutocomplete.isHidden = false
                }
                else
                {
                    self.tblAutocomplete.isHidden = true
                }
            }
            
        }
    }
    
    @IBAction func searching(_ sender: UITextField) {
        searchData(for: sender.text ?? "")
    }
}
//MARK:  TableViewDataSource And Delegate

extension MapLocationVC: UITableViewDataSource,UITableViewDelegate {
    
    
    
    private func reloadTableDateToFitHeight(tableView: UITableView) {
        DispatchQueue.main.async {
            tableView.reloadData(heightToFit: self.heightForAutoComplete) {
                
            }
        }
        
    }
    private func setupTableView(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.register(AutocompleteLocationCell.nib()
            , forCellReuseIdentifier: AutocompleteLocationCell.name)
        tableView.tableFooterView = UIView()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arrForAdress.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        
        let autoCompleteCell = tableView.dequeueReusableCell(withIdentifier: AutocompleteLocationCell.name, for: indexPath) as?  AutocompleteLocationCell
        autoCompleteCell?.setCellData(place: arrForAdress[indexPath.row])
        return autoCompleteCell!
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return UITableView.automaticDimension;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: false)
        tblAutocomplete.isHidden = true
        let placeID = arrForAdress[indexPath.row].placeID
        let address = self.arrForAdress[indexPath.row].subTitle.string
        let placeClient = GMSPlacesClient.shared()
        
        placeClient.lookUpPlaceID(placeID, callback: { (place, error) -> Void in
            if let error = error {
                print("lookup place id query error: \(error.localizedDescription)")
                return
            }
            
            guard let place = place else {
                print("No place details for \(placeID)")
                return
            }
            self.txtSearchBar.text = address
            self.animateToLocation(coordinate: place.coordinate)
        })
    }
}


