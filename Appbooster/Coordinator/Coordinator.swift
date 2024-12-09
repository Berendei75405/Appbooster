//
//  Coordinator.swift
//  Appbooster
//
//  Created by Novgorodcev on 21/11/2024.
//

import UIKit

//MARK: - CoordinatorProtocol
protocol CoordinatorProtocol: AnyObject {
    func createStartVC() -> UIViewController
    func initialStartVC()
    func showGistVC(userInfo: [UserInfo])
}

final class Coordinator: CoordinatorProtocol {
    var navController: UINavigationController?
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    //MARK: - createStartVC
    func createStartVC() -> UIViewController {
        let view = StartViewController()
        let viewModel = StartViewModel()
        
        view.viewModel = viewModel
        viewModel.coordinator = self
        
        return view
    }
    
    //MARK: - initialStartVC
    func initialStartVC() {
        if let navController = navController {
            let view = createStartVC()
            
            navController.viewControllers = [view]
        }
    }
    
    //MARK: - showGistVC
    func showGistVC(userInfo: [UserInfo]) {
        if let navController = navController {
            guard let view = createGistVC() as? GistViewController else { return }
            view.viewModel?.userInfo = userInfo
            
            navController.pushViewController(view, animated: true)
        }
    }
    
    //MARK: - createGistVC
    func createGistVC() -> UIViewController {
        let view = GistViewController()
        let viewModel = GistViewModel()
        
        view.viewModel = viewModel
        viewModel.coordinator = self
        
        return view
    }
    
}
