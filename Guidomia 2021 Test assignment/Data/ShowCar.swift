//
//  ShowCar.swift
//  Guidomia 2021 Test assignment
//
//  Created by Brahim El Mssilha on 12/8/2022.
//

import Foundation

struct ShowCar: Decodable {
    
    let consList: [String]
    let customerPrice: Double
    let make: String
    let marketPrice: Double
    let model: String
    let prosList: [String]
    let rating: Int
    let image: String
}
