//
//  app-version.swift
//  Alamofire-Update-Demo
//
//  Created by TAISHIN MIYAMOTO on 2022/05/09.
//

import Foundation

struct VERSION: Codable {
    let results: [RESULTS]
}

struct RESULTS: Codable {
    let version: String
}
