//
//  BillBoardManager.swift
//  SoptWeek4
//
//  Created by KYUBO A. SHIM on 2023/05/09.
//

import Foundation

import Alamofire

final class BillBoardManager {
    static let shared = BillBoardManager()
    let maximumRequestTime = 4.0
    
    private init() {}
    
    lazy var AFWithConfuguration: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = maximumRequestTime
        configuration.timeoutIntervalForResource = maximumRequestTime
        return Session.init(configuration: configuration)
    }()
    
    func requestChart<T: Codable>(withTypeOf type: T.Type, completion: @escaping ((NetworkResult<T>) -> Void)) {
        let url = Configuration.baseURL
        let dataRequest = AFWithConfuguration.request(url)
        
        dataRequest.responseData { response in
            switch response.result {
            case .success:
                guard let statusCode = response.response?.statusCode else { return }
                guard let value = response.value else { return }
                let networkCompletion = self.judgeStatus(by: statusCode, value, withTypeOf: T.self)
                
                completion(networkCompletion)
            case .failure:
                completion(.networkErr)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(by statusCode: Int, _ data: Data, withTypeOf type: T.Type) -> NetworkResult<T> {
        switch statusCode {
        case 200...299: return isDataValid(data: data, withTypeOf: T.self)
        case 400...499: return isDataValid(data: data, withTypeOf: T.self)
        case 500...599: return .serverErr
        default: return .networkErr
        }
    }
    
    private func isDataValid<T: Codable>(data: Data, withTypeOf type: T.Type) -> NetworkResult<T> {
        let decoder = JSONDecoder()
        guard let decodedData = try? decoder.decode(T.self, from: data) else {
            return .pathErr
        }
        
        return .success(decodedData)
    }
}
