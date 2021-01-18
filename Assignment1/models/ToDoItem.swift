//
//  ToDoItem.swift
//  Assignment1
//
//  Created by Чингиз Азимбаев on 18.01.2021.
//

import Foundation

public struct ToDoItem: Codable {
    var id: Int?
    var title: String?
    var subtitle: String?
    var status: String?
    var deadline: String?
}
