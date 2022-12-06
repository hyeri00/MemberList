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
    
    // MARK: - 관리 모델 선언
    
    // 데이터 매니저( (배열 관리 - 데이터)
    var memberListManager = MemberListManager()
    
    // 네비게이션바에 넣기 위한 버튼
    lazy var plusButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(plusButtonTapped))
       return button
    }()
    
    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupDatas()
        setupNaviBar()
        setupTableView()
        setupTableViewConstraints()
    }
    
    // 델리게이트가 아닌 방식으로 구현할 때는 화면 리프레시
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 주소 등 업데이트 시 테이블뷰에도 업데이트가 된다.
        // 뷰가 다시 나타날 때, 테이블뷰를 리로드
        tableView.reloadData()
    }
    
    func setupNaviBar() {
        title = "회원 목록"
        
        // 네비게이션바 설정 관련
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()   // 불투명으로
        appearance.backgroundColor = .white
        navigationController?.navigationBar.tintColor = .systemBlue
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        // 네비게이션바 오른쪽 상단 버튼 설정 (네비게이션 아이템)
        self.navigationItem.rightBarButtonItem = self.plusButton
    }
    
    // MARK: - 테이블뷰 세팅

    func setupTableView() {
        // 델리게이트 패턴의 대리자 설정
        tableView.dataSource = self
        tableView.delegate = self
        // 셀의 높이 설정
        tableView.rowHeight = 60
        
        // 테이블뷰에 셀 등록 해주기 ⭐️ (타입 인스턴스 - 메타 타입)
        tableView.register(MyTableViewCell.self, forCellReuseIdentifier: "MemberCell")
    }
    
    func setupDatas() {
        
        // 비지니스 모델에 접근하여 멤버를 만들 수 있는 함수를 호출 해야 함. 그래야 빈 배열이 아니라 데이터가 있는 배열이 생길 수 있음.
        // 일반적으로는 서버에 요청
        memberListManager.makeMembersListDatas()
    }
    
    // MARK: - 오토레이아웃 세팅

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
    
    // 멤버를 추가하기 위한 다음 화면으로 이동
    @objc func plusButtonTapped() {
        // 다음 화면으로 이동 (멤버는 전달하지 않음)
        let detailVC = DetailViewController()
        
        // 다음 화면의 대리자 설정 (다음 화면의 대리자는 지금 현재의 뷰컨트롤러)
//        detailVC.delegate = self
        
        // 화면 이동
        navigationController?.pushViewController(detailVC, animated: true)
//        show(detailVC, sender: nil)
    }
}

// MARK: - 테이블뷰 데이터 소스 구현

extension ViewController: UITableViewDataSource {
    
    // 1) 테이블뷰에 몇 개의 데이터를 표시할 것인지 (셀이 몇 개인지)를 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memberListManager.getMembersList().count
    }
    
    // 2) 셀의 구성 (셀에 표시하고자 하는 데이터 표시)을 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // (힙에 올라간) 재사용 가능한 셀을 꺼내서 사용하는 메서드
        // (사전에 셀을 등록하는 과정이 내부 메커니즘에 존재)
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as! MyTableViewCell
        
        // 셀에다가 멤버를 전달 (멤버만 전달하면, 화면에 표시하도록 구현. 셀에서 didSet으로)
        cell.member = memberListManager[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - 테이블뷰 델리게이트 구현 (셀이 선택 되었을 때)

extension ViewController: UITableViewDelegate {
    
    // 셀이 선택이 되었을 때 어떤 동작을 할 것인지 뷰컨트롤러에게 물어봄
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 다음 화면으로 넘어가는 코드
        let detailVC = DetailViewController()
        
        // 다음 화면의 대리자 설정 (다음 화면의 대리자는 지금 현재의 뷰컨트롤러)
//        detailVC.delegate = self
        
        // 다음 화면에 멤버를 전달
        let currentMember = memberListManager.getMembersList()[indexPath.row]
        detailVC.member = currentMember
        
        // 화면 이동
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
