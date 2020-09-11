//
//  ViewController.swift
//  MasterSearch
//
//  Created by Boss on 9/10/20.
//  Copyright © 2020 LuyệnĐào. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var listCocktail:[CocktailModel] = []
    var searchArray:[CocktailModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "DetailSearchCell", bundle: nil), forCellReuseIdentifier: "DetailSearchCell")
        //searchTextField.addTarget(self, action: #selector(searchText), for: .editingChanged)
        searchTextField.delegate = self
        searchTextField.resignFirstResponder()
        callAPI()
    }
    func callAPI() {
        DataService.sharing.getData() { data in
            if let drinks = data.drinks {
                self.listCocktail = drinks
                for item in self.listCocktail {
                    self.searchArray.append(item)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func searchText(_ textField: UITextField) {
        filtering()
    }
    
    func filtering() {
        if searchTextField.text == "" {
            searchArray = listCocktail
        } else {
            searchArray = listCocktail.filter { (data: CocktailModel) in
                if let cocktail = data.strDrink?.lowercased(), let text = searchTextField.text {
                    return cocktail.contains(text.lowercased())
                }
                return false
            }
        }
        tableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailSearchCell", for: indexPath) as? DetailSearchCell
        cell?.searchLabel.text = searchArray[indexPath.row].strDrink
        return cell!
    }
    // MARK: Delegate textField
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        searchTextField.text = ""
        searchArray.removeAll()
        for item in listCocktail {
            searchArray.append(item)
        }
        tableView.reloadData()
        return false
    }
    //    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    //        if searchTextField.text == "" {
    //            searchArray = listCocktail
    //        } else {
    //            searchArray = listCocktail.filter { (data: CocktailModel) in
    //                if let cocktail = data.strDrink?.lowercased(), let text = searchTextField.text {
    //                    return cocktail.contains(text.lowercased())
    //                }
    //                return false
    //            }
    //        }
    //        tableView.reloadData()
    //        return true
    //    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        filtering()
        return false
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if searchTextField.text == "" {
            searchArray = listCocktail
        } else {
            searchArray = listCocktail.filter { (data: CocktailModel) in
                if let cocktail = data.strDrink?.lowercased(), let text = searchTextField.text {
                    return cocktail.contains(text.lowercased())
                }
                return false
            }
        }
        tableView.reloadData()
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        return true
    }
    
}



