//
//  ViewController.swift
//  MemberList
//
//  Created by 혜리 on 2022/11/29.
//

import UIKit

final class ViewController: UIViewController {
    
    // 테이블뷰 생성
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - 오토레이아웃 셋팅
    
    // 테이블뷰의 오토레이아웃 설정
    func setupTableViewConstraints() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
    }
}

