
import Foundation

class MyBookingData {

   
   var bookingType: String = ""
   var id: String = ""
   var massageDate: String = ""
   var massageTime: String = ""
   var totalPrice: String = ""
   var userPeople: [MyBookingUserPeople] = []
   var sessionType: String = ""
   var shopDescription: String = ""
   var shopName: String = ""



    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        self.userPeople = [MyBookingUserPeople]()
        if let bookingMassagesArray = dictionary["user_people"] as? [[String:Any]]{
            for dic in bookingMassagesArray{
                let value = MyBookingUserPeople(fromDictionary: dic)
                self.userPeople.append(value)
            }
        }
        self.bookingType = (dictionary["booking_type"] as? String) ?? ""
        self.shopDescription = (dictionary["shop_description"] as? String) ?? ""
        self.id = (dictionary["id"] as? String) ?? ""
        self.massageDate = (dictionary["massage_date"] as? String) ?? ""
        self.shopName = (dictionary["shop_name"] as? String) ?? ""
        self.totalPrice = (dictionary["total_price"] as? String) ?? ""
        self.sessionType = (dictionary["session_type"] as? String) ?? ""
        self.massageTime = (dictionary["massage_time"] as? String) ?? ""


    }


}
