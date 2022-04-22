//
//  RepositoryListViewController.swift
//  GitHubRepository
//
//  Created by 김상우 on 2022/04/20.
//

import UIKit
import RxSwift
import RxCocoa

class RepositoryListViewController : UITableViewController {
    private let organization = "Apple"
    // Rx를 사용하지 않는다면 이런식으로 표현했었다.
    // private let repositories = [Repository]
    private let repositories = BehaviorSubject<[Repository]>(value: [])
    private let disposebag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = organization + " Repositories"
        
        // 당겨서 새로고침
        self.refreshControl = UIRefreshControl()
        let refreshControl = self.refreshControl!
        refreshControl.backgroundColor = .white
        refreshControl.tintColor = .darkGray
        refreshControl.attributedTitle = NSAttributedString(string: "당겨서 새로고침")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        self.tableView.register(RepositoryListCell.self, forCellReuseIdentifier: "RepositoryListCell")
        self.tableView.rowHeight = 140
        
    }
    
    
    @objc func refresh() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let self = self else { return }
            self.fetchRepositories(of: self.organization)
        }
    }
    
    
    // 네트워크 통신을 해서 json 을 가지고 오고, 디코딩하고, subject 에 onNext 해주는 함수
    func fetchRepositories(of organizatinon: String) {
        print("func fetchRepositories")
        Observable.from([organizatinon])
            .map{ organization -> URL in
                print("1")
                return URL(string: "https://api.github.com/orgs/\(organization)/repos")!
            }
            .map{ url -> URLRequest in
                print("2")
                var request = URLRequest(url: url)
                request.httpMethod = "GET"
                return request
            }
            .flatMap{ request -> Observable<(response: HTTPURLResponse, data: Data)> in
                print("3")
                print("request", request)
                print("method", request.httpMethod)
                let response_result = URLSession.shared.rx.response(request: request)
                print("result", response_result)
                return response_result
            }
            .filter{ responds, _ in
                print("4")
                print("responds : \(responds)")
                return 200..<300 ~= responds.statusCode
            }
            .map{ _, data -> [[String: Any]] in
                print("5")
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []),
                      let result = json as? [[String: Any]] else {
                    return []
                }
                return result
            }
            .filter{ result in
                return result.count > 0
            }
            .map{ objects in
                return objects.compactMap{ dict -> Repository? in
                    guard let id = dict["id"] as? Int,
                          let name = dict["name"] as? String,
                          let description = dict["description"] as? String,
                          let stargazerCount = dict["stargazers_count"] as? Int,
                          let language = dict["language"] as? String else {
                              print("parsing error")
                              return nil
                          }
                    return Repository(id: id, name: name, description: description, stargazerCount: stargazerCount, language: language)
                }
            }
            .subscribe(
                onNext: { [weak self] newRepositories in
                    self?.repositories.onNext(newRepositories)
                    
                    DispatchQueue.main.async{
                        self?.tableView.reloadData()
                        // refresh 그만하도록
                        self?.refreshControl?.endRefreshing()
                    }
                })
            .disposed(by: disposebag)
    }
    
}


// UITableView DataSource Delegate
extension RepositoryListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do {
            return try repositories.value().count
        } catch {
            print("tableView numberOfRowsInSection Error")
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RepositoryListCell", for: indexPath) as? RepositoryListCell else { return UITableViewCell() }
        
        var currentRepo: Repository? {
            do {
                return try repositories.value()[indexPath.row]
            } catch {
                print("tableView cellForRowAt Error")
                return nil
            }
        }
     
        cell.repository = currentRepo
        
        return cell
    }
}
