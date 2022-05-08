//
//  ContentView.swift
//  Alamofire-Update-Demo
//
//  Created by TAISHIN MIYAMOTO on 2022/05/09.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var oldVersion: String = ""
    @State var newVersion: String = ""
    var body: some View {
        VStack(spacing: 20) {
            Text(oldVersion.isEmpty ? "現在のLINEのバージョンは******です。" : "現在のLINEのバージョンは\(oldVersion)です。")
            Button("バージョン取得(old)") {
                old { res in
                    oldVersion = res?.results[0].version ?? "******"
                }
            }
            Text(newVersion.isEmpty ? "現在のLINEのバージョンは******です。" : "現在のLINEのバージョンは\(newVersion)です。")
            Button("バージョン取得(new)") {
                new { res in
                    newVersion = res?.results[0].version ?? "******"
                }
            }
        }
    }
    func old(completion: @escaping (VERSION?) -> Void) {
        AF.request("https://itunes.apple.com/lookup?id=443904275", method: .get).responseJSON { response in
            completion(oldDecode(response: response))
        }
    }
    func new(completion: @escaping (VERSION?) -> Void) {
        AF.request("https://itunes.apple.com/lookup?id=443904275", method: .get).responseData { response in
            completion(newDecode(response: response))
        }
    }
    func oldDecode(response: AFDataResponse<Any>) -> VERSION {
        let decoder: JSONDecoder = JSONDecoder()
        do {
            let res: VERSION = try decoder.decode(VERSION.self, from: (response.data)!)
            return res
        } catch {
            return VERSION(results: [])
        }
    }
    func newDecode(response: AFDataResponse<Data>) -> VERSION {
        let decoder: JSONDecoder = JSONDecoder()
        do {
            let res: VERSION = try decoder.decode(VERSION.self, from: (response.data)!)
            return res
        } catch {
            return VERSION(results: [])
        }
    }
}
