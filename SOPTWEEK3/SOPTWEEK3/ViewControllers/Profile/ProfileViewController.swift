//
//  ProfileViewController.swift
//  SOPTWEEK3
//
//  Created by KYUBO A. SHIM on 2023/05/05.
//

import UIKit

import SnapKit
import Then

class ProfileViewController: UIViewController {
    
    private var userName = ""
    private lazy var profileViewModel = ProfileViewModel(userName: userName)
    private lazy var upperCases = profileViewModel.fetchUpperProfileMenus()
    private lazy var lowerCases = profileViewModel.fetchLowerProfileMenus()
    
    private lazy var customNavBar = CustomNavigationBar()
    private let profileHeaderView = ProfileHeaderView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 260))
    private let profileFooterView = ProfileFooterView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 55))
    private let profileTableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        basicSetup()
        setStyle()
        setLayout()
    }
    
    private func basicSetup() {
        view.backgroundColor = .black
        print(userName)
        profileTableView.dataSource = self
        profileTableView.delegate = self
        
        profileHeaderView.cofigureName(userName: userName)
    }
    
    private func setStyle() {
        customNavBar.do {
            $0.showButtons()
            $0.backButton.addTarget(self, action: #selector(popToView), for: .touchUpInside)
        }
        
        profileTableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.tableHeaderView = profileHeaderView
            $0.tableFooterView = profileFooterView
            $0.register(ProfileTableViewCell.self, forCellReuseIdentifier: "profile")
            $0.rowHeight = 65
        }
    }
    
    private func setLayout() {
        view.addSubviews(customNavBar, profileTableView)
        customNavBar.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        profileTableView.snp.makeConstraints {
            $0.top.equalTo(customNavBar.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
    }
}

extension ProfileViewController {
    func passUserName(name: String?) {
        guard let name else { return }
        self.userName = name
    }
    
    @objc
    private func popToView() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return profileViewModel.fetchUpperProfileMenus().count
        case 1:
            return profileViewModel.fetchLowerProfileMenus().count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "profile") as? ProfileTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none

        switch indexPath.section {
        case 0:
            cell.configureCell(profileTitles: upperCases[indexPath.row])
            
            return cell
        case 1:
            cell.configureCell(profileTitles: lowerCases[indexPath.row])
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let lineView = ProfileLineView()
            
            return lineView
        default:
            return UIView()
        }
    }
}
