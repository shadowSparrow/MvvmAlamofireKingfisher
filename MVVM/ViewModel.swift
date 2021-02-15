//
//  ViewModel.swift
//  MVVM
//
//  Created by Alexander Romanenko on 05.02.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//

import Foundation
import Alamofire

struct Parser {

    func getParsedData(comp: @escaping (Json)->()){
        _ = Alamofire.request("https://pryaniky.com/static/json/sample.json", method: .get, encoding: JSONEncoding.default)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                guard let data = response.data else {return}
                let json = try! JSONDecoder.init().decode(Json.self, from: data)
                //let jsonData = json.data
                //let name = jsonData[0]?.name
                //let hZdata = jsonData[0]?.data?.text
                comp(json)
        }
    }
}
