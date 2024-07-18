//
//  File.swift
//  PokeContacts
//
//  Created by ahnzihyeon on 7/16/24.
//

import Foundation
// MARK: - 포켓몬 데이터를 담은 구조체
struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: Sprites
}

// MARK: - 이미지 URL 관련
class Sprites: Codable {
    let frontDefault: String

    private enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}
