//
//  ViewController.swift
//  Image Carsouel
//
//  Created by A7med Fekry on 04/08/2024.
//
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate {

    // MARK: - Properties
    var images: [UIImage] = []
    var items: [[String]] = [
        ["1", "2", "3", "4", "5","1", "2", "3", "4", "5"],
        ["6", "7", "8", "9", "10","6", "7", "8", "9", "10"],
        ["11", "12", "13", "14", "15","11", "12", "13", "14", "15"],
        ["16", "17", "18", "19","16", "17", "18", "19"],
        ["1", "2", "3", "4", "5","1", "2", "3", "4", "5"],
        ["6", "7", "8", "9", "10","6", "7", "8", "9", "10"],
        ["11", "12", "13", "14", "15","11", "12", "13", "14", "15"],
        ["16", "17", "18", "19","16", "17", "18", "19"]
    ]
    var filteredItems: [String] = []
    var scrollView: UIScrollView!
    var collectionView: UICollectionView!
    var tableView: UITableView!
    var searchBar: UISearchBar!
    var searchBarContainer: UIView!
    var currentPageIndex: Int = 0
    var currentTableImage: String = "1"
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadLocalImages()
        updateTableViewContent()
    }
    
    // MARK: - UI Setup
    func setupUI() {
        setupScrollView()
        setupImageCarousel()
        setupSearchBar()
        setupTableView()
    }
    
    func setupScrollView() {
        scrollView = UIScrollView()
        scrollView.delegate = self
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupImageCarousel() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "carouselCell")
        
        scrollView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar()
        searchBar.delegate = self
        
        searchBarContainer = UIView()
        searchBarContainer.addSubview(searchBar)
        view.addSubview(searchBarContainer)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBarContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: searchBarContainer.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: searchBarContainer.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: searchBarContainer.trailingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: searchBarContainer.bottomAnchor),
            
            searchBarContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            searchBarContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBarContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBarContainer.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        
        scrollView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 50),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            tableView.heightAnchor.constraint(equalToConstant: view.frame.height * 2)
        ])
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        cell.customLabel.text = filteredItems[indexPath.row]
        // Set a placeholder image or use a local image
        cell.customImageView.image = UIImage(named: (currentPageIndex + 1).description)
        return cell
    }
    
    // MARK: - Data Loading
    func loadLocalImages() {
        for i in 1...10 {
            if let image = UIImage(named: "\(i)") {
                images.append(image)
            }
        }
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "carouselCell", for: indexPath)
        
        let imageView = UIImageView(image: images[indexPath.row])
        imageView.contentMode = .scaleAspectFill
        cell.contentView.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }
    
    // MARK: - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        updateFilteredItems(searchText: searchText)
    }
    
    func updateFilteredItems(searchText: String) {
        if searchText.isEmpty {
            filteredItems = items[currentPageIndex]
        } else {
            filteredItems = items[currentPageIndex].filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        tableView.reloadData()
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let offsetX = scrollView.contentOffset.x
            let pageIndex = round(offsetX / scrollView.frame.size.width)
            currentPageIndex = Int(pageIndex)
            currentTableImage = currentPageIndex.description
            updateTableViewContent()
        } else {
            let offsetY = scrollView.contentOffset.y
            if offsetY >= 200 {
                searchBarContainer.frame.origin.y = view.safeAreaInsets.top
            } else {
                searchBarContainer.frame.origin.y = 200 - offsetY + view.safeAreaInsets.top
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == collectionView {
            let pageIndex = round(scrollView.contentOffset.x / scrollView.frame.size.width)
            currentPageIndex = Int(pageIndex)
            
            // Update cell focus states
            let visibleCells = collectionView.visibleCells
            for cell in visibleCells {
                let indexPath = collectionView.indexPath(for: cell)
                if indexPath?.row == currentPageIndex {
                    // Focus current cell
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                        cell.alpha = 1.0
                    })
                } else {
                    // Unfocus other cells
                    UIView.animate(withDuration: 0.3, animations: {
                        cell.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
                        cell.alpha = 0.5
                    })
                }
            }
            
            updateTableViewContent()
        }
    }



    
    // MARK: - Utility Functions
    func updateTableViewContent() {
        updateFilteredItems(searchText: searchBar.text ?? "")
    }
}
