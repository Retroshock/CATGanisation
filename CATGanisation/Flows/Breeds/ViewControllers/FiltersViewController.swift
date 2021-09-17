//
//  FiltersViewController.swift
//  CATGanisation
//
//  Created by Adrian Popovici on 17.09.2021.
//

import UIKit

protocol FiltersCoordinatorProtocol: Coordinator {
}

class FiltersViewController: BaseViewController<FiltersViewModel> {

    @IBOutlet private weak var tableView: UITableView!

    private var filtersAction: (([CategoryDisplayModel]) -> Void)?

    var coordinator: FiltersCoordinatorProtocol {
        coordinatorProtocol as! FiltersCoordinatorProtocol
    }

    func configure(
        with viewModel: FiltersViewModel,
        coordinatorProtocol: FiltersCoordinatorProtocol,
        filtersAction: @escaping ([CategoryDisplayModel]) -> Void
    ) {
        self.viewModel = viewModel
        self.coordinatorProtocol = coordinatorProtocol
        self.filtersAction = filtersAction
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            FilterCategoryTableViewCell.nib,
            forCellReuseIdentifier: FilterCategoryTableViewCell.identifier
        )

        viewModel.dataSource.bind(
            to: tableView.rx.items
        ) { tableView, index, element in
            guard let cell = tableView.dequeueReusableCell(
                    withIdentifier: FilterCategoryTableViewCell.identifier,
                    for: IndexPath(index: index)
            ) as? FilterCategoryTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: element)
            return cell
        }.disposed(by: disposeBag)

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            guard let self = self else { return }
            let newModel = self.viewModel.dataSource.value.map { oldCategory -> CategoryDisplayModel in
                if oldCategory.name == self.viewModel.dataSource.value[indexPath.row].name {
                    var category = oldCategory
                    category.select()
                    return category
                }
                return oldCategory
            }
            self.viewModel.dataSource.accept(newModel)
        }).disposed(by: disposeBag)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            let selectedCategories = viewModel.dataSource.value.filter { filter in
                filter.isSelected
            }
            filtersAction?(selectedCategories)
        }
    }
}
