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
    
    private var cellId = "ItemCell"
    private var drinks: [Drink]!
    private var selectedIndex: Int!
    private var criteria: SearchCriteria = .byName
    
    
    // MARK: - OUTLETS
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    
    // MARK: - METHODS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        
        searchCollectionView.register(UINib.init(nibName: cellId, bundle: nil), forCellWithReuseIdentifier: cellId)
    }
    
    private func performSearch() {
        guard let query = searchTextField.text else { return }
        
        NetworkController().fetchDrinks(criteria, query: query) { result in
            switch result {
            case .success(let drinks):
                self.drinks = drinks
                self.searchCollectionView.reloadData()
            case .failure(let errorMessage):
                self.alert(title: "Erreur", message: errorMessage.rawValue)
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if searchCollectionView != nil {
            searchCollectionView.reloadData()
        }
    }
    
    
    // MARK: - ACTIONS
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            criteria = .byName
        case 1:
            criteria = .byIngredient
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
        if segue.identifier == "SearchToDrink" {
            guard let drinkVC = segue.destination as? DrinkVC else { return }
            drinkVC.drink = drinks[selectedIndex]
        }
    }
}


// MARK: - COLLECTIONVIEW DATASOURCE

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks != nil ? drinks.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? ItemCell else {
            return UICollectionViewCell()
        }
        cell.drink = drinks[indexPath.row]
        return cell
    }
}


// MARK: - COLLECTIONVIEW DELEGATE

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedIndex = indexPath.row
        performSegue(withIdentifier: "SearchToDrink", sender: self)
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
