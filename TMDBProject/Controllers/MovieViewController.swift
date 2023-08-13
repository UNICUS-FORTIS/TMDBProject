//
//  ViewController.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import UIKit



class MovieViewController: UIViewController {
    
    
    let networkmanager = NetworkManager.shared
    
    
    @IBOutlet weak var MovieTableView: UITableView!
    
    
    var popularList:[Movie] = []
    var nowPlaying:[Movie] = []
    var topRated:[Movie] = []
    var upcomming:[Movie] = []
    
    var categoryArray:[[Movie]] = []
    var page = 1
    var isEnd = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTVCell()
        MovieTableView.dataSource = self
        MovieTableView.rowHeight = 370
        //테이블뷰 밑줄 없애는 방법
        MovieTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: MovieTableView.bounds.width)
        loadAllDatas()
    }
    
    private func registerTVCell() {
        let nib = UINib(nibName: MovieTableViewCell.identifier, bundle: nil)
        MovieTableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    func loadAllDatas() {
        DispatchQueue.global().async {
            self.fetchPopularData()
            print("1")
        }

        DispatchQueue.global().async {
            self.fetchNowPlayingData()
            print("2")
        }

        DispatchQueue.global().async {
            self.fetchTopRatedData()
            print("3")
        }

        DispatchQueue.global().async {
            self.fetchUpcommingData()
            print("4")
        }
//        DispatchQueue.main.async {
////            self.categoryArray = [self.popularList, self.nowPlaying, self.topRated, self.upcomming]
//            self.MovieTableView.reloadData()
////            print("5")
////            print(self.categoryArray)
//        }
    }
    
    
    func fetchPopularData() {
        networkmanager.fetchData(type: .popular) { [weak self] json in
            
            for item in json["results"].arrayValue {
                let title = item["title"].stringValue
                let rate = item["vote_average"].doubleValue
                let poster = item["poster_path"].stringValue
                let backdrop = item["backdrop_path"].stringValue
                let released = item["release_date"].stringValue
                let overview = item["overview"].stringValue
                
                let data = Movie(title: title, rate: rate, poster: poster, backdrop: backdrop, released: released, overview: overview)
                
                self?.popularList.append(data)
            }
            self?.MovieTableView.reloadData()
        }
    }
    
    func fetchTopRatedData() {
        networkmanager.fetchData(type: .topRated) { [weak self] json in
            for item in json["results"].arrayValue {
                let title = item["title"].stringValue
                let rate = item["vote_average"].doubleValue
                let poster = item["poster_path"].stringValue
                let backdrop = item["backdrop_path"].stringValue
                let released = item["release_date"].stringValue
                let overview = item["overview"].stringValue
                
                let data = Movie(title: title, rate: rate, poster: poster, backdrop: backdrop, released: released, overview: overview)
                
                self?.topRated.append(data)
            }
            self?.MovieTableView.reloadData()

        }
    }
    
    func fetchNowPlayingData() {
        networkmanager.fetchData(type: .nowPlaying) { [weak self] json in
            for item in json["results"].arrayValue {
                let title = item["title"].stringValue
                let rate = item["vote_average"].doubleValue
                let poster = item["poster_path"].stringValue
                let backdrop = item["backdrop_path"].stringValue
                let released = item["release_date"].stringValue
                let overview = item["overview"].stringValue
                
                let data = Movie(title: title, rate: rate, poster: poster, backdrop: backdrop, released: released, overview: overview)
                
                self?.nowPlaying.append(data)
            }
            self?.MovieTableView.reloadData()
        }
    }
    
    func fetchUpcommingData() {
        networkmanager.fetchData(type: .upcomming) { [weak self] json in
            for item in json["results"].arrayValue {
                let title = item["title"].stringValue
                let rate = item["vote_average"].doubleValue
                let poster = item["poster_path"].stringValue
                let backdrop = item["backdrop_path"].stringValue
                let released = item["release_date"].stringValue
                let overview = item["overview"].stringValue
                
                let data = Movie(title: title, rate: rate, poster: poster, backdrop: backdrop, released: released, overview: overview)
                
                self?.upcomming.append(data)
            }
            self?.MovieTableView.reloadData()
        }
    }
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
//        cell.movie = categoryArray[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.movie = popularList
        case 1:
            cell.movie = nowPlaying
        case 2:
            cell.movie = topRated
        case 3:
            cell.movie = upcomming
        default:
            break
        }
        return cell
    }
}

extension MovieViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}
