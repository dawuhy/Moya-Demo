//
//  UserService.swift
//  Moya_Demo
//
//  Created by Huy on 7/23/20.
//  Copyright © 2020 nhn. All rights reserved.
//

import Foundation
import Moya

enum UserService {
    case createUser(name:String)
    case readUsers
    case updateUser(id:Int, name:String)
    case deleteUser(id:Int)
}

extension UserService:TargetType {
    var baseURL: URL {
        return URL(string: "https://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .readUsers, .createUser(_):
            return "/users"
        
        case .updateUser(let id, _ ), .deleteUser(let id):
            return "/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createUser(_):
            return .post
        case .readUsers:
            return .get
        case .updateUser(_, _):
            return .put
        case .deleteUser(_):
            return .delete
        }
    }
    
    var sampleData: Data {
        switch self {
        case .createUser(let name):
            return "{'name':'\(name)'}".data(using: .utf8)!
        case .readUsers:
            return Data()
        case .updateUser(let id, let name):
            return "{'\(id)', 'name':'\(name)'}".data(using: .utf8)!
        case .deleteUser(let id):
            return "'id':'\(id)'}".data(using: .utf8)!
        }
    }
    
    var task: Task {
        switch self {
        case .readUsers, .deleteUser(_):
            return .requestPlain
        case .createUser(let name), .updateUser(_, let name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Typer": "application/json"]
    }
    
}
