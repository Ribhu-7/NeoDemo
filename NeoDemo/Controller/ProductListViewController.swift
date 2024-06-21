//
//  ProductListViewController.swift
//  MVVM1
//
//  Created by Apple on 19/06/24.
//

import UIKit

class ProductListViewController: UIViewController {

    private var viewModel = ProductViewModel()
    
    @IBOutlet weak var productTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configuration()
    }
}

extension ProductListViewController {
    
    func configuration(){
        productTableView.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
     initViewModel()
     observeEvent()
    }
    
    func initViewModel(){
        viewModel.fetchProducts()
    }
    
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            guard let self else {return}
            
            switch event {
            case .loading:
                print("Loading...")
            case .stopLoading:
                print("Loading stopped...")
            case .dataLoaded:
                print("Data Loaded...")
                print(self.viewModel.products)
                DispatchQueue.main.async {
                    self.productTableView.reloadData()
                }
            case .error(let error):
                print(error ?? "")
            }
        }
    }
}

extension ProductListViewController: UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else{
            return UITableViewCell()
        }
        
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
