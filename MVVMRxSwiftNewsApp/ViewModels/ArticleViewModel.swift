//
//  ArticleViewModel.swift
//  MVVMRxSwiftNewsApp
//
//  Created by MAC on 07/01/21.
//

import Foundation
import RxCocoa
import RxSwift

struct ArticleListViewModel {
    let articleVM: [ArticleViewModel]
}

extension ArticleListViewModel {
    init(_ articles: [Articles]) {
        self.articleVM = articles.compactMap(ArticleViewModel.init)
    }
}

struct ArticleViewModel {
    let article: Articles
    init(_ article: Articles) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title: Observable<String>{
        return Observable<String>.just(article.title)
    }
    var description: Observable<String>{
        return Observable<String>.just(article.description ?? "")
    }
}
