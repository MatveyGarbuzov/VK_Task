//
//  Services.swift
//  vk_app
//
//  Created by Matvey Garbuzov on 14.07.2022.
//

import Foundation

struct ListOfApps: Codable {
    let body: Body
    let status: Int
}

struct Body: Codable {
    let services: [Services]
}

struct Services: Codable {
    let name: String
    let description: String
    let link: String
    let icon_url: String
}
