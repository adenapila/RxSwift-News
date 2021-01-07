//
//  Articles.swift
//  MVVMRxSwiftNewsApp
//
//  Created by MAC on 07/01/21.
//

import Foundation

struct ArticlesResponse: Decodable {
    let articles: [Articles]
}

struct Articles: Decodable {
    let title: String
    let description: String
}
