
import Foundation

class MyBookingMassage{

    var name : String!
    var price : Int!
    var time : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(fromDictionary dictionary: [String:Any]){
        name = dictionary["name"] as? String
        price = dictionary["price"] as? Int
        time = dictionary["time"] as? String
    }

}
