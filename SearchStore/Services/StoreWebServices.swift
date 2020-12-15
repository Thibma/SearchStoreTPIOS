//
//  StoreWebServices.swift
//  SearchStore
//
//  Created by Thibault BALSAMO on 18/11/2020.
//

import Foundation

class StoreWebServices {
    func getAllStore(completion: @escaping ([Store]) -> Void) -> Void {
        guard let storeUrl = URL(string: "https://moc4a-poi.herokuapp.com/stores") else {
            return
        }
        let task = URLSession.shared.dataTask(with: storeUrl, completionHandler: { (data: Data?, res, err) in
            guard let bytes = data, err == nil, let json = try? JSONSerialization.jsonObject(with: bytes, options: .mutableContainers) as? [Any] else {
                DispatchQueue.main.sync {
                    completion([])
                }
                return
            }
            let stores = json.compactMap{ (obj) -> Store? in
                guard let dict = obj as? [String: Any] else {
                    return nil
                }
                return StoreFactory.storeFrom(dictionnary: dict)
            }
            DispatchQueue.main.sync {
                completion(stores)
            }
        })
        task.resume()
    }
}
