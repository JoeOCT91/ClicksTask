//
//  ViewModelWithPagination.swift
//  ClicksTask
//
//  Created by Yousef Mohamed on 07/09/2021.
//

import Foundation

protocol ViewModelWithPaginationProtocol: ViewModelWithReachabilityProtocol{
    func getDataListCount() -> Int
}

protocol PaginationChild: AnyObject {
    func getData()
}

class ViewModelWithPagination<T: PaginationVCProtocol>:  ViewModelWithReachability<T> {

    internal weak var child: PaginationChild?
    
    //internal weak var view: T?
    internal var dataList = [Codable]()
    
    //Pagination properties
    internal var page = 1
    internal var hasMorePages = true
    
    @objc func getDataListCount() -> Int {
        return dataList.count
    }
    
    //To terminate how many pages will retrieve from the API
    internal func isHasMorePages(resultCount: Int) {
        var numberOfPages: Int
        numberOfPages = (resultCount / 20)
        (resultCount % 20) != 0 ? (numberOfPages += 1) : (numberOfPages = numberOfPages)
        print(resultCount / 10)
        numberOfPages > page ? (hasMorePages = true) : (hasMorePages = false)
    }
    
    @objc internal func scrollObserve(cellCount: Int){
        if didScrollToEnd(cellCount: cellCount) && hasMorePages {
            self.child?.getData()
        }
    }
    
    private func didScrollToEnd(cellCount: Int) -> Bool {
	        return cellCount + 1  == dataList.count ? true : false
    }
}
