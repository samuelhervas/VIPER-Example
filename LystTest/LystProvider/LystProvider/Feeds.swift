
import Moya

public enum Gender : String {
    case male = "M"
    case female = "F"
}

enum Feeds {
    case feed(gender: Gender, category: String)
}

extension Feeds: TargetType
{
    var parameters: [String : Any]? {
        get {
            switch self {
            case .feed(let gender, let category) :
                let params = ["pre_gender" : gender.rawValue,
                              "pre_category" : category] as [String : Any]
                
                return params
            }
            
        }
    }
    
    var path: String {
        get {
            switch self {
            case .feed:
                return "components/feeds"
            }
        }
    }
    
    var sampleData: Data {
        get { return Data()}
    }
    
    var multipartBody: [Moya.MultipartFormData]? {
        get { return nil }
    }
    
    var task : Task {
        get { return .request }
    }
    
    var method : Moya.Method {
        return .get
    }
    
    var baseURL: URL {
        return URL(string: "https://api.lyst.com/rest_api/")!
    }
    
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}


