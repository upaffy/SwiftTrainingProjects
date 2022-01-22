//
//  ViewController.swift
//  CoreDataToDo
//
//  Created by Pavlentiy on 06.10.2021.
//

import UIKit

enum Action {
    case edit
    case add
}

class TasksViewController: UITableViewController {
    
    private let storageManager = StorageManager.shared
    private let cellID = "task"
    private var taskList: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        setupNavigationBar()
        
        taskList = storageManager.fetchTasks()
    }
    
    private func addTask(_ taskName: String) {
        guard let task = storageManager.saveTask(with: taskName) else { return }
        taskList.append(task)
        
        let cellIndex = IndexPath(row: taskList.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
    }
    
    private func editTask(with taskName: String, at indexPath: IndexPath) {
        taskList[indexPath.row].title = taskName
        storageManager.saveContext()
        
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    private func deleteTask(at indexPath: IndexPath) {
        let deletedTask = taskList[indexPath.row]
        storageManager.deleteTask(deletedTask)
        
        taskList.remove(at: indexPath.row)
    }
}

// MARK: - Alerts
extension TasksViewController {
    
    @objc private func showNewTaskAlert() {
        showAlert(for: .add)
    }
    
    private func showEditTaskAlert(for indexPath: IndexPath) {
        showAlert(for: .edit, at: indexPath)
    }
    
    private func showAlert(for action: Action, at indexPath: IndexPath = IndexPath(row: 0, section: 0)) {
        let alert = setupAlert(for: action, at: indexPath)
        present(alert, animated: true)
    }
}

// MARK: - Interface Elements Setup
extension TasksViewController {
    
    private func setupAlert(for action: Action, at indexPath: IndexPath) -> UIAlertController {
        let alert: UIAlertController
        let saveAction: UIAlertAction
        var defaultTFText: String? = nil
        
        switch action {
        case .edit:
            defaultTFText = taskList[indexPath.row].title
            
            alert = UIAlertController(title: "Change task", message: "What do you want to do?", preferredStyle: .alert)
            
            saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                guard let taskName = alert.textFields?.first?.text, !taskName.isEmpty else { return }
                self.editTask(with: taskName, at: indexPath)
            }
        case .add:
            alert = UIAlertController(title: "New Task", message: "What do you want to do?", preferredStyle: .alert)
            
            saveAction = UIAlertAction(title: "Save", style: .default) { _ in
                guard let taskName = alert.textFields?.first?.text, !taskName.isEmpty else { return }
                self.addTask(taskName)
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { textField in
            if let defaultTFText = defaultTFText {
                textField.text = defaultTFText
            }
            
            textField.placeholder = "Task Name"
        }
        
        return alert
    }
    
    private func setupNavigationBar() {
        
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBarAppearance = UINavigationBarAppearance()
        
        navBarAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(showNewTaskAlert)
        )
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}

// MARK: - UITableViewDataSource
extension TasksViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        
        content.text = task.title
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showEditTaskAlert(for: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteTask(at: indexPath)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
