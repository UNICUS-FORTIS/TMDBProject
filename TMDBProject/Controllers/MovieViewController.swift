//
//  ViewController.swift
//  TMDBProject
//
//  Created by LOUIE MAC on 2023/08/12.
//

import UIKit



class MovieViewController: UIViewController {
    
    
    let networkmanager = NetworkManager.shared
    @IBOutlet weak var lodingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var movieTableView: UITableView!
    
    var popularList:[Movie] = []
    var nowPlaying:[Movie] = []
    var topRated:[Movie] = []
    var upcoming:[Movie] = []
    
    var page = 1
    var isEnd = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadAllDatas()
        lodingIndicator.isHidden = true
        registerTVCell()
        movieTableView.dataSource = self
        movieTableView.delegate = self
        movieTableView.rowHeight = UIScreen.main.bounds.height / 3.5
        movieTableView.sectionFooterHeight = 0
        movieTableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: movieTableView.bounds.width)
    }
    
    private func registerTVCell() {
        let nib = UINib(nibName: MovieTableViewCell.identifier, bundle: nil)
        movieTableView.register(nib, forCellReuseIdentifier: MovieTableViewCell.identifier)
    }
    
    func loadAllDatas() {
        lodingIndicator.isHidden = false
        self.lodingIndicator.startAnimating()
        let group = DispatchGroup()
        
        group.enter()
        DispatchQueue.global().async {
            self.fetchPopularData()
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async {
            self.fetchNowPlayingData()
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async {
            self.fetchTopRatedData()
            group.leave()
        }
        
        group.enter()
        DispatchQueue.global().async {
            self.fetchUpcommingData()
            group.leave()
        }
        
        group.notify(queue: .main) {
            self.movieTableView.reloadData()
            self.lodingIndicator.isHidden = true
            self.lodingIndicator.stopAnimating()
        }
    }
    
    private func fetchPopularData() {
        networkmanager.fetchData(url: URL.popularURL) { [weak self] movie in
            self?.popularList = movie.results
            self?.movieTableView.reloadData()
        }
    }
    
    private func fetchTopRatedData() {
        networkmanager.fetchData(url: URL.topRatedURL) { [weak self] movie in
            self?.topRated = movie.results
            self?.movieTableView.reloadData()
        }
    }
    
    private func fetchNowPlayingData() {
        networkmanager.fetchData(url: URL.nowPlayingURL) { [weak self] movie in
            self?.nowPlaying = movie.results
            self?.movieTableView.reloadData()
        }
    }
    
    private func fetchUpcommingData() {
        networkmanager.fetchData(url: URL.upcommingURL) { [weak self] movie in
            self?.upcoming = movie.results
            self?.movieTableView.reloadData()
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
        let cell = movieTableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier) as! MovieTableViewCell
        
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
            headerLabel.text = "Now Playing"
        case 2:
            headerLabel.text = "Top Rated"
        case 3:
            headerLabel.text = "Upcoming Movies"
        default:
            return nil
        }
        headerLabel.textColor = UIColor.black
        headerLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        headerView.addSubview(headerLabel)
        
        return headerView
    }
    
}

extension MovieViewController: MoveViewControllerProtocol {
    
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
