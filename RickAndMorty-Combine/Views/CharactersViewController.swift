//
//  CharactersViewController.swift
//  RickAndMorty-Combine
//
//  Created by omaestra on 16/6/21.
//

import UIKit
import Combine

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    private let viewModel: CharacterViewModel = CharacterViewModel()
    var bindings = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        setupSearchController()
        setupSearchBarListeners()
        bindViewModel()
        viewModel.fetchCharacters()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CharacterTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CharacterTableViewCell.reuseIdentifier)
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    fileprivate func setupSearchBarListeners() {
        let publisher = NotificationCenter.default
            .publisher(for: UISearchTextField.textDidChangeNotification,
                       object: searchController.searchBar.searchTextField)
        publisher
            .compactMap {
                ($0.object as? UISearchTextField)?.text
            }
            .sink { [unowned self] (str) in
                self.viewModel.searchText.send(str)
            }.store(in: &bindings)
        viewModel.characters.sink { [unowned self] (_) in
            self.tableView.reloadData()
        }.store(in: &bindings)
    }

    
    private func bindViewModel() {
        viewModel.characters.sink { [unowned self] (_) in
            self.tableView.reloadData()
        }
        .store(in: &bindings)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CharactersViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.reuseIdentifier, for: indexPath) as! CharacterTableViewCell
        
        let character = viewModel.characters.value[indexPath.row]
        cell.configure(with: character)
        
        return cell
    }
}

extension CharactersViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}
