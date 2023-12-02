//
//  UserDbManager.swift
//  Team6_MAPD714_Project-Milestone4
//  *****Milestone 4*****
//  *****Team6*****
//  *****Team Members*****
//  Srijeet Sthapit - 301365217
//  Abi Chitrakar - 301369773
//  Promish Khaniya - 301369717
//
//  Created by Srijeet Sthapit on 2023-10-29.
//  Submitted on 2023-12-01

import Foundation
import SQLite3

class UserDbManager{
    init() {
        db = openDatabase() // Initialize database
        createTable() // Create table on initialization
    }
    
    let dataPath: String = "User"
    var db: OpaquePointer? // SQLite database pointer
    
    // Function to open the database
    func openDatabase() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(dataPath)
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            debugPrint("Can't open DB")
            return nil
        } else {
            print("DB Created successfully")
            return db
        }
    }
    
    //function to create user table
    func createTable(){
        let createTableString = "CREATE TABLE IF NOT EXISTS User (id INTEGER PRIMARY KEY AUTOINCREMENT, email TEXT, password String);"
        var createTableStatement: OpaquePointer? = nil
        
        // Table creation logic with SQLite statements
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print ("User table created successfully")
            }else{
                print("User table failed")
            }
        }else{
            print("Failed create statement")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    // Function to insert a new user into the database
    func insert(email: String, password: String) -> Bool {
        let insertStatementString = "INSERT INTO User (email, password) VALUES (?, ?);"
        var insertStatement: OpaquePointer?
        
        // Insert logic with SQLite statements
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (password as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                sqlite3_finalize(insertStatement)
                return true
            } else {
                print("Failed to insert row.")
            }
            
        } else {
            print("INSERT statement could not be prepared.")
        }
        
        sqlite3_finalize(insertStatement)
        return false
    }
    
    // Function to read users from the database
    func read() -> [User] {
        let queryStatementString = "SELECT * FROM User;"
        var queryStatement: OpaquePointer? = nil
        var users : [User] = []
        
        // Read logic with SQLite statements
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                users.append(User(id: Int(id), email: email, password: password))
                print("User Details:")
                print("\(id) | \(email) | \(password)")
            }
        } else {
            print("SELECT statement failed to proceed!!!")
        }
        sqlite3_finalize(queryStatement)
        return users
    }
    
    // Function to delete a user by ID from the database
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM User WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        // Delete logic with SQLite statements
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("A user deleted successfully!")
            } else {
                print("Couldn't delete given user")
            }
        } else {
            print("DELETE statement failed to succeed!")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    // Function to get a user by email and password
    func getUser(email: String, password: String) -> User? {
        let queryStatementString = "SELECT * FROM User WHERE email = ? AND password = ?;"
        var queryStatement: OpaquePointer?
        var user: User?
        
        // Logic to get a specific user with SQLite statements
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(queryStatement, 2, (password as NSString).utf8String, -1, nil)
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                user = User(id: Int(id), email: email, password: password)
            } else {
                print("Query returned no results")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return user
    }
}

