//
//  ViewController.swift
//  iOS-Base
//
//  Created by Lutfi Azhar on 8/24/17.
//  Copyright © 2017 Lutfi Azhar. All rights reserved.
//

import UIKit

class ProductViewController: BaseViewController {

    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var emptyView: UIView!
    
    fileprivate let productPresenter = ProductPresenter(productService: ProductService())
    fileprivate var productsToDisplay = [ProductViewData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        productPresenter.attachView(view: self)
        productPresenter.getProductsAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


extension ProductViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productsToDisplay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell")! as UITableViewCell

        let product = self.productsToDisplay[indexPath.row]
        cell.textLabel?.text = product.productName
        cell.detailTextLabel?.text = "Rp "+"\(product.productPrice)"
        return cell
    }
    
}

extension ProductViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension ProductViewController: ProductView {
    
    func startLoading() {
        self.showLoadingIndicator()
    }
    
    func finishLoading() {
        self.hideLoadingIndicator()
    }
    
    func setObject(datas: [ProductViewData]) {
        self.productsToDisplay = datas
        self.tableView?.isHidden = false
        self.tableView?.reloadData()
        emptyView?.isHidden = true;
    }
    
    func setEmptyObject() {
        self.tableView?.isHidden = true
        emptyView?.isHidden = false;
    }
    
    func setErrorMessageFromAPI(errorMessage: String) {
        self.basicAlertView(title: "", message: errorMessage, successBlock: {})
    }
    
}

