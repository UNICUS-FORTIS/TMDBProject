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
    var upcoming:[Movie] = []
    
    var page = 1
    var isEnd = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTVCell()
        MovieTableView.dataSource = self
        MovieTableView.delegate = self
        MovieTableView.rowHeight = 300
        MovieTableView.sectionFooterHeight = 0
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
                
                self?.upcoming.append(data)
            }
            self?.MovieTableView.reloadData()
        }
    }
}

extension MovieViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = MovieTableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        
        switch indexPath.section {
        case 0:
            cell.movie = popularList
            cell.delegate = self
        case 1:
            cell.movie = nowPlaying
            cell.delegate = self
        case 2:
            cell.movie = topRated
            cell.delegate = self
        case 3:
            cell.movie = upcoming
            cell.delegate = self
            
        default:
            break
        }
        
        return cell
    }
}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        headerView.backgroundColor = .clear
        
        let headerLabel = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.frame.width - 30, height: 40))
        switch section {
        case 0:
            headerLabel.text = "Popular Movies"
        case 1:
            headerLabel.text =  "Now Playing"
        case 2:
            headerLabel.text =  "Top Rated"
        case 3:
            headerLabel.text =  "Upcoming Movies"
        default:
            return nil
        }
        headerLabel.textColor = UIColor.black // 헤더 텍스트 색상 설정
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20) // 헤더 텍스트 폰트 설정
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
}

extension MovieViewController: MoveViewController {
    
    func toDatailViewController(withData: Movie) {
        
        //이거 메인스레드 비동기로 실행하지 않으니까 UI그리는데서 Fatal 에러남
        //왜 navigationController로 push 가 안되니..
        //Hoxy..호출을 컬렉션뷰Cell에서 호출해서 그러니..
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }

            let sb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = sb.instantiateViewController(withIdentifier: DetailViewController.identifier) as? DetailViewController {
                vc.setupDetails(item: withData)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}
