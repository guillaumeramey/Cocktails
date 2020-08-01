//
//  HomeVC.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 01/08/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit

class HomeVC: UITableViewController {
    
    // MARK: - PROPERTIES
    
    private var cellId = "ItemCell"
    private var selectedIndex: Int!
    private var cellWidth: CGFloat = 1
    private var cellHeight: CGFloat = 1
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    private var bookmarks = [Drink]() {
        didSet {
            bookmarksCounter.text = "(\(bookmarks.count))"
        }
    }
    private var myDrinks = [Drink]() {
        didSet {
            myDrinksCounter.text = "(\(myDrinks.count))"
        }
    }
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var bookmarksCollectionView: UICollectionView!
    @IBOutlet weak var myDrinksCollectionView: UICollectionView!
    @IBOutlet weak var bookmarksCounter: UILabel!
    @IBOutlet weak var myDrinksCounter: UILabel!

    
    // MARK: - METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateCellSize()
//        tableView.backgroundColor = UIColor(named: "Color background")

        bookmarksCollectionView.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        myDrinksCollectionView.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
        
        fetchData()
    }
    
    func calculateCellSize() {
        guard let windowInterfaceOrientation = windowInterfaceOrientation else { return }
        let itemPerRow: CGFloat = windowInterfaceOrientation.isPortrait ? 2.5 : 4
        let inset: CGFloat = 10
        cellWidth = (bookmarksCollectionView.frame.width - (inset * (itemPerRow + 1))) / itemPerRow
        cellHeight = cellWidth + 60
    }
    
    func fetchData() {
        NetworkController().fetchDrinks(.random) { result in
            switch result {
            case .success(let drinks):
                for _ in 1...5 {
                    self.bookmarks.append(contentsOf: drinks)
                    self.myDrinks.append(contentsOf: drinks)
                }
                self.bookmarksCollectionView.reloadData()
                self.myDrinksCollectionView.reloadData()
            case .failure(let errorMessage):
                self.alert(title: "Erreur", message: errorMessage.rawValue)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 || indexPath.row == 3 {
            return cellHeight
        }
        return UITableView.automaticDimension
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if bookmarksCollectionView != nil {
            bookmarksCollectionView.reloadData()
        }
        if myDrinksCollectionView != nil {
            myDrinksCollectionView.reloadData()
        }
    }
}


// MARK: - COLLECTIONVIEW DATASOURCE

extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.bookmarksCollectionView:
            return bookmarks.count
        case self.myDrinksCollectionView:
            return myDrinks.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.bookmarksCollectionView:
            guard let cell = bookmarksCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ItemCell else {
                return UICollectionViewCell()
            }
            cell.drink = bookmarks[indexPath.row]
            return cell
        case self.myDrinksCollectionView:
            guard let cell = bookmarksCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ItemCell else {
                return UICollectionViewCell()
            }
            cell.drink = myDrinks[indexPath.row]
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}


// MARK: - COLLECTIONVIEW DELEGATE

extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "HomeToDrink", sender: self)
    }
}


// MARK: - NAVIGATION

extension HomeVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HomeToDrink" {
            guard let drinkVC = segue.destination as? DrinkVC else { return }
            drinkVC.drink = bookmarks[selectedIndex]
        }
    }
}


// MARK: - COLLECTIONVIEW LAYOUT

extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellWidth, height: cellHeight)
    }
}
