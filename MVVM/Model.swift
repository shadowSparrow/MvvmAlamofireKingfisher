//
//  Model.swift
//  MVVM
//
//  Created by Alexander Romanenko on 05.02.2021.
//  Copyright © 2021 Alexander Romanenko. All rights reserved.
//

import Foundation


struct Json: Decodable {
    var data: [data?]
    var view: [String?]
}

struct data: Decodable{
    var name: String!
    var data: data1!
}

struct data1: Decodable {
    var text: String!
    var selectedId: Int!
    var url: String!
    var variants: [variants]!
}

struct variants: Decodable {
    var id: Int!
    var text: String!
}

