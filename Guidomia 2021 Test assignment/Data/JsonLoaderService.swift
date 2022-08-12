//
//  JsonLoaderService.swift
//  Guidomia 2021 Test assignment SwiftUI
//
//  Created by Brahim El Mssilha on 12/8/2022.
//

import Foundation

extension String: Error { }

class JSONLoaderService {
    
    static func loadJSONData<T: Decodable>() throws -> [T] {
        
        guard let fileUrl = Bundle.main.url(forResource: "car_list", withExtension: "json") else {
            throw "File not found"
        }
        let data = try Data.init(contentsOf: fileUrl)
        
        return try JSONDecoder().decode([T].self, from: data)
    }
}
