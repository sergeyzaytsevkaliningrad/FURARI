//
//  InstructionsListViewController.swift
//  FURARI
//
//  Created by Rudolf Oganesyan on 13.02.2021.
//

import UIKit

final class InstructionsListViewController: BaseViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(InstructionTableViewCell.nib, forCellReuseIdentifier: InstructionTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.delaysContentTouches = false
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(white: 1, alpha: 0)
        return tableView
    }()
    
    private var mockDataSource = ["Поворотный механизм", "qwerty"]
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        layoutTableView()
    }
    
    private func setupNavigationBar() {
        title = "Instructions"
    }
    
    private func layoutTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - UITableViewDelegate

extension InstructionsListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        navigationController?.pushViewController(, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension InstructionsListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InstructionTableViewCell.reuseIdentifier, for: indexPath) as? InstructionTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configureWith(title: mockDataSource[indexPath.row])
        
        return cell
    }
}
