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

    private var drinks: [Drink]!
    private let cellId = "Cell"
    private var selectedDrink: Drink!
    
    
    // MARK: - OUTLETS

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    
    // MARK: - METHODS

    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
    }
    
    private func searchDrinks() {
        guard let query = searchTextField.text else { return }
        NetworkController().fetchDrinks(query: query) { result in
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
        searchCollectionView.reloadData()
    }
    
    
    // MARK: - ACTIONS
    
    @IBAction func textFieldPrimaryAction(_ sender: Any) {
        dismissKeyboard()
        searchDrinks()
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchToDrink" {
            guard let destinationVC = segue.destination as? DrinkVC else { return }
            destinationVC.drink = selectedDrink
        }
    }
}


// MARK: - COLLECTIONVIEW DATASOURCE

extension SearchVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks != nil ? drinks.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = searchCollectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchCollectionViewCell
        cell.drink = drinks[indexPath.row]
        return cell
    }
}


// MARK: - COLLECTIONVIEW DELEGATE

extension SearchVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedDrink = drinks[indexPath.row]
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
