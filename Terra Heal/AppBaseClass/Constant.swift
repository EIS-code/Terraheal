//
//  Created by Jaydeep on 21/09/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//
import Foundation
import UIKit


class Constant: NSObject {
    static let typeIOS: String = "ios"
    static let AppName: String = "Terra Heals"

    static let True: String = "1"
    static let False: String = "0"

}

class MessageCode: NSObject {
    static let success: String = "200"
    static let validationError: String = "401"
    static let exception: String = "401"

}
struct Gender {
    static let Male  = "m"
    static let Female  = "f"
    static let Other  = "t"
}

enum Pressure: String {
    case Soft  = "soft"
    case Medium  = "medium"
    case Strong  = "strong"
    case ExStrong  = "extra strong"
    case Other  = "other"
    func name()-> String {
        switch self {
            // Use Internationalization, as appropriate.
        case .Soft: return "MASSAGE_PRESSURE_TYPE_1".localized()
        case .Medium: return "MASSAGE_PRESSURE_TYPE_2".localized()
        case .Strong: return "MASSAGE_PRESSURE_TYPE_3".localized()
        case .ExStrong: return "MASSAGE_PRESSURE_TYPE_4".localized()
        default: return "Unknown"
        }
    }
}

enum PreferGender: String {
    case MaleOnly  = "male"
    case FemaleOnly  = "female"
    case PreferMale  = "prefer male"
    case PrefereFemale  = "prefere female"
    case NoPreference  = "noPreference"

    func name()-> String {
        switch self {
        // Use Internationalization, as appropriate.
        case .MaleOnly: return "GENDER_MALE_ONLY".localized()
        case .FemaleOnly: return "GENDER_FEMALE_ONLY".localized()
        case .PreferMale: return "GENDER_PREFER_MALE".localized()
        case .PrefereFemale: return "GENDER_PREFER_FEMALE".localized()
        default: return "GENDER_NO_PREFERENCE".localized()
        }
    }

}

struct LoginBy {
    static let Social  = "1"
    static let Manual  = "0"
}


struct DateFormat {
    static let DD_MM_YYYY = "dd/MM/YYYY"
    static let DOB = "YYYY-MM-dd"
    static let check = "✓"
}

struct UploadDocumentDetail {
    var id: String  = ""
    var name: String  = ""
    var image: UIImage? = nil
    var data: Data? = nil
    var isCompleted: Bool  = false
}
