//
//  SearchVC.swift
//  Cocktails
//
//  Created by Guillaume Ramey on 30/07/2020.
//  Copyright © 2020 Guillaume Ramey. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - PROPERTIES
    
    private let cellId = "Cell"
    private var itemType: Item.Type!
    private var items: [Item]!
    private var selectedItem: Item!
    
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    // MARK: - METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    private func performSearch() {
        guard let query = searchTextField.text else { return }
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            NetworkController().fetchItems(Drink.self, query: query) { result in
                self.handleSearchResult(result: result)
            }
        case 1:
            NetworkController().fetchItems(Ingredient.self, query: query) { result in
                self.handleSearchResult(result: result)
            }
        default:
            alert(title: "Erreur", message: "Erreur interne.")
        }
    }
    
    private func handleSearchResult(result: Result<[Item], NetworkError>) {
        switch result {
        case .success(let items):
            self.items = items
            self.searchCollectionView.reloadData()
        case .failure(let errorMessage):
            self.alert(title: "Erreur", message: errorMessage.rawValue)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        searchCollectionView.reloadData()
    }
    
    
    // MARK: - ACTIONS
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            itemType = Drink.self
        case 1:
            itemType = Ingredient.self
        default:
            return
        }
    }
    
    @IBAction func textFieldPrimaryAction(_ sender: Any) {
        dismissKeyboard()
        performSearch()
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToItemDetail" {
            guard let destinationVC = segue.destination as? ItemDetailVC else { return }
            destinationVC.item = selectedItem
        }
    }
}


// MARK: - COLLECTIONVIEW DATASOURCE

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items != nil ? items.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCollectionViewCell
        cell.item = items[indexPath.row]
        return cell
    }
}


// MARK: - COLLECTIONVIEW DELEGATE

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedItem = items[indexPath.row]
        performSegue(withIdentifier: "SearchToItemDetail", sender: self)
    }
}


// MARK: - COLLECTIONVIEW LAYOUT

extension SearchVC: UICollectionViewDelegateFlowLayout {
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let windowInterfaceOrientation = windowInterfaceOrientation else {
            return CGSize(width: 0, height: 0)
        }
        let itemPerRow: CGFloat = windowInterfaceOrientation.isPortrait ? 2 : 4
        let inset: CGFloat = 10
        let width = (searchCollectionView.frame.width - (inset * (itemPerRow + 1))) / itemPerRow
        return CGSize(width: width, height: width + 60)
    }
    
}
