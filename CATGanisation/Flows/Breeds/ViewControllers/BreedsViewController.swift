//
//  BreedsViewController.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 14.09.2021.
//

import UIKit
import RxCocoa
import RxSwift

protocol BreedsCoordinatorProtocol: Coordinator {
    func showFilters(filterAction: @escaping ([CategoryDisplayModel]) -> Void)
    func showDetails(of breed: BreedDisplayModel)
}

class BreedsViewController: BaseViewController<BreedsViewModel> {
    @IBOutlet weak var tableView: UITableView!
    private var paginationSpinner = UIActivityIndicatorView()

    var coordinator: BreedsCoordinatorProtocol {
        coordinatorProtocol as! BreedsCoordinatorProtocol
    }

    func configure(viewModel: BreedsViewModel, coordinator: BreedsCoordinatorProtocol) {
        self.viewModel = viewModel
        self.coordinatorProtocol = coordinator
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBottomSpinner()
        setupNavigationBar()

        LoaderView.show()

        tableView.register(
            BreedTableViewCell.nib,
            forCellReuseIdentifier: BreedTableViewCell.identifier
        )

        viewModel.getBreeds().subscribe { [weak self] breeds in
            LoaderView.hide()
            self?.observeReachToBottom()
        } onFailure: { [weak self] error in
            LoaderView.hide()
            self?.showSimpleAlert(with: error.localizedDescription)
        }.disposed(by: disposeBag)

        viewModel.dataSource.bind(
            to: tableView.rx.items
        ) { tableView, index, element in
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: BreedTableViewCell.identifier,
                    for: IndexPath(index: index)
            ) as? BreedTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: element)
            return cell
        }.disposed(by: disposeBag)

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            self.tableView.deselectRow(at: indexPath, animated: false)
            self.coordinator.showDetails(of: self.viewModel.dataSource.value[indexPath.row])
        }).disposed(by: disposeBag)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addFilterButton()
    }

    private func addFilterButton() {
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(didPressFilters))
        navigationItem.rightBarButtonItem = filterButton
    }

    private func observeReachToBottom() {
        tableView.rx.reachedBottom().subscribe(onNext: { [weak self] in
            guard let self = self else { return }
            self.addBottomSpinner()
            self.viewModel.getNextPage().subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.removeBottomSpinner()
            }, onError: { [weak self] _ in
                guard let self = self else { return }
                self.removeBottomSpinner()
            })
            .disposed(by: self.disposeBag)
        })
        .disposed(by: disposeBag)
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .systemOrange
        addNavigationBarItem()
    }

    private func addNavigationBarItem() {
        let button = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(didPressFilters))
        navigationController?.navigationItem.rightBarButtonItem = button
    }

    @objc private func didPressFilters() {
        coordinator.showFilters { [weak self] filters in
            guard let self = self else { return }
            LoaderView.show()
            self.viewModel.getBreeds(with: filters).subscribe(onSuccess: { _ in
                LoaderView.hide()
            }, onFailure: { _ in
                LoaderView.hide()
            }).disposed(by: self.disposeBag)
        }
    }

    private func didPressBreed(_ breed: BreedDisplayModel) {
        coordinator.showDetails(of: breed)
    }

    private func configureBottomSpinner() {
        paginationSpinner = UIActivityIndicatorView(style: .medium)
        paginationSpinner.hidesWhenStopped = true
        paginationSpinner.frame = CGRect(x: 0,
                                         y: 0,
                                         width: tableView.bounds.width,
                                         height: 60)
    }

    private func addBottomSpinner() {
        if tableView.tableFooterView == nil {
            tableView.tableFooterView = paginationSpinner
            paginationSpinner.startAnimating()
        }
    }

    private func removeBottomSpinner() {
        if tableView.tableFooterView != nil {
            tableView.tableFooterView = nil
        }
    }

}
