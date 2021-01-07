//
//  NewsAppVC.swift
//  MVVMRxSwiftNewsApp
//
//  Created by MAC on 07/01/21.
//

import Foundation
import UIKit
import RxSwift

class NewsAppVC: UITableViewController {
    let disposedBag = DisposeBag()
    private var articleListVM: ArticleListViewModel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        CalledNewAPI()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articleListVM == nil ? 0 : self.articleListVM.articleVM.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt
        indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:
            "cell", for: indexPath) as? ArticleTVC else{
            fatalError("Article Not Found")
        }
        let articleVM = self.articleListVM.articleVM[indexPath.row]
        articleVM.title.asDriver(onErrorJustReturn: "").drive (cell.titleLable.rx.text).disposed(by:disposedBag)
        articleVM.description.asDriver(onErrorJustReturn: "").drive (cell.descriptionLable.rx.text).disposed(by:disposedBag)
        return cell
    }
    
    private func CalledNewAPI(){
        let resource = Resource<ArticlesResponse>(url: URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=f17c5e1a09fe496381fb5c5cf8ccc4ab")!)
        URLRequest.load(resource: resource)
            .subscribe(onNext: {
                articleResponse in
                let articles = articleResponse.articles
                self.articleListVM = ArticleListViewModel(articles)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }).disposed(by: disposedBag)
    }
}
