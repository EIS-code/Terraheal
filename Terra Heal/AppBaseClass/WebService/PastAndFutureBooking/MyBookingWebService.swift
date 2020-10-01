import Foundation

enum MyBookingWebService {
    
    struct RequestPastBookingList: Codable {
           var user_id: String = PreferenceHelper.shared.getUserId()
    }
    struct RequestFutureBookingList: Codable {
           var user_id: String = PreferenceHelper.shared.getUserId()
    }
    
    class Response: ResponseModel {
        var bookingList: [MyPastBookingData] = []
        override init(fromDictionary dictionary: [String:Any]) {
            super.init(fromDictionary: dictionary)
            bookingList.removeAll()
            if let dataArray = dictionary["data"] as? [[String:Any]] {
                for data in dataArray {
                    bookingList.append(MyPastBookingData.init(fromDictionary: data))
                }
            }
        }
    }
}
