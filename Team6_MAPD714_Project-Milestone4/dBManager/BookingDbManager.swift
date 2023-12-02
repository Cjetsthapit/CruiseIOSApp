//
//  BookingDbManager.swift
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

class BookingDbManager {
    init() {
        db = openDatabase() // Initialize database
        createTable() // Create table on initialization
    }
    
    let dataPath: String = "Booking"
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
    
    //function to create booking table
    func createTable() {
        //sql statement for create statement
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Booking (
            id TEXT PRIMARY KEY,
            userId INTEGER,
            cruiseName TEXT,
            cruiseDescription TEXT,
            cruiseVisitingPlaces TEXT,
            cruiseDuration TEXT,
            cruiseAdultPrice TEXT,
            cruiseChildPrice TEXT,
            cruiseAdultCount TEXT,
            cruiseChildCount TEXT,
            cruiseReservationDate TEXT,
            cruiseExtraCare INTEGER,
            cruiseTotalPrice TEXT,
            email TEXT,
            contactNumber TEXT,
            cardType TEXT,
            cardNumber TEXT,
            cardCVC TEXT,
            cardExpiryDate TEXT,
            name TEXT,
            address TEXT,
            postalCode TEXT,
            state TEXT,
            country TEXT,
            FOREIGN KEY(userId) REFERENCES User(id)
        );
        """
        var createTableStatement: OpaquePointer? = nil
        
        // Executing the create table statement
        // Additional logic to handle execution result
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK {
            if sqlite3_step(createTableStatement) == SQLITE_DONE {
                print("Booking table created successfully")
            } else {
                print("Booking table creation failed")
            }
        } else {
            print("CREATE TABLE statement failed")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    //function to add booking
    func insert(booking: Booking) -> String {
        //sql statement to insert booking
        let insertStatementString = "INSERT INTO Booking (id, userId, cruiseName, cruiseDescription, cruiseVisitingPlaces, cruiseDuration, cruiseAdultPrice, cruiseChildPrice, cruiseAdultCount, cruiseChildCount, cruiseReservationDate, cruiseExtraCare, cruiseTotalPrice, email, contactNumber, cardType, cardNumber, cardCVC, cardExpiryDate, name, address, postalCode, state, country) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        
        // Executing the insert booking statement
        // Additional logic to handle execution result
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (booking.id as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 2, Int32(booking.userId))
            sqlite3_bind_text(insertStatement, 3, (booking.cruiseName as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (booking.cruiseDescription as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (booking.cruiseVisitingPlaces as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (booking.cruiseDuration as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (booking.cruiseAdultPrice as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 8, (booking.cruiseChildPrice as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 9, (booking.cruiseAdultCount as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 10, (booking.cruiseChildCount as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 11, (booking.cruiseReservationDate as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 12, booking.cruiseExtraCare ? 1 : 0)
            sqlite3_bind_text(insertStatement, 13, (booking.cruiseTotalPrice as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 14, (booking.email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 15, (booking.contactNumber as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 16, (booking.cardType as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 17, (booking.cardNumber as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 18, (booking.cardCVC as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 19, (booking.cardExpiryDate as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 20, (booking.name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 21, (booking.address as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 22, (booking.postalCode as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 23, (booking.state as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 24, (booking.country as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                
                sqlite3_finalize(insertStatement)
                return booking.id
            } else {
                print("Failed to insert row.")
            }
            if sqlite3_step(insertStatement) != SQLITE_DONE {
                let errmsg = String(cString: sqlite3_errmsg(db))
                print("Failure inserting row: \(errmsg)")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        
        sqlite3_finalize(insertStatement)
        return "-1"  // Indicating failure
    }
    
    
    
    func deleteByID(id: Int) -> Bool {
        let deleteStatementString = "DELETE FROM Booking WHERE id = ?;"
        var deleteStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, deleteStatementString, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
                sqlite3_finalize(deleteStatement)
                return true
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared.")
        }
        
        sqlite3_finalize(deleteStatement)
        return false
    }
    
    //function to get all booking for a specific user
    func readBookingsByUserId(userId: Int) -> [BookingBrief] {
        //sql statment to get booking for userId
        let queryStatementString = "SELECT * FROM Booking WHERE userId = ?;"
        var queryStatement: OpaquePointer? = nil
        var bookings: [BookingBrief] = []
        
        //executing sql statement
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(userId))
            
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let userId = sqlite3_column_int(queryStatement, 1)
                let cruiseName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let cruiseReservationDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                
                //creating a BookingBrief object and appending it to bookings array
                bookings.append(BookingBrief(id: id, userId:Int(userId), cruiseName: cruiseName,  cruiseReservationDate: cruiseReservationDate))
            }
        } else {
            print("SELECT statement failed to proceed")
        }
        sqlite3_finalize(queryStatement)
        return bookings
    }
    
    //function to get a specific booking
    func getBookingById(id: String) -> Booking? {
        //sql statement to get booking for id
        let queryStatementString = "SELECT * FROM Booking WHERE id = ?;"
        var queryStatement: OpaquePointer? = nil
        var booking: Booking?
        
        //executing sql statement
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, (id as NSString).utf8String, -1, nil)
            
            if sqlite3_step(queryStatement) == SQLITE_ROW {
                // Extract each field from the query result
                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let userId = Int(sqlite3_column_int(queryStatement, 1))
                let cruiseName = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let cruiseDescription = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let cruiseVisitingPlaces = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let cruiseDuration = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let cruiseAdultPrice = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let cruiseChildPrice = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let cruiseAdultCount = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let cruiseChildCount = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                let cruiseReservationDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
                let cruiseExtraCare = sqlite3_column_int(queryStatement, 11) != 0
                let cruiseTotalPrice = String(describing: String(cString: sqlite3_column_text(queryStatement, 12)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 13)))
                let contactNumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 14)))
                let cardType = String(describing: String(cString: sqlite3_column_text(queryStatement, 15)))
                let cardNumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 16)))
                let cardCVC = String(describing: String(cString: sqlite3_column_text(queryStatement, 17)))
                let cardExpiryDate = String(describing: String(cString: sqlite3_column_text(queryStatement, 18)))
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 19)))
                let address = String(describing: String(cString: sqlite3_column_text(queryStatement, 20)))
                let postalCode = String(describing: String(cString: sqlite3_column_text(queryStatement, 21)))
                let state = String(describing: String(cString: sqlite3_column_text(queryStatement, 22)))
                let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 23)))
                
                // Initialize the Booking object with extracted values
                booking = Booking(id: id, userId: userId, cruiseName: cruiseName, cruiseDescription: cruiseDescription, cruiseVisitingPlaces: cruiseVisitingPlaces, cruiseDuration: cruiseDuration, cruiseAdultPrice: cruiseAdultPrice, cruiseChildPrice: cruiseChildPrice, cruiseAdultCount: cruiseAdultCount, cruiseChildCount: cruiseChildCount, cruiseReservationDate: cruiseReservationDate, cruiseExtraCare: cruiseExtraCare, cruiseTotalPrice: cruiseTotalPrice, email: email, contactNumber: contactNumber, cardType: cardType, cardNumber: cardNumber, cardCVC: cardCVC, cardExpiryDate: cardExpiryDate, name: name, address: address, postalCode: postalCode, state: state, country: country)
            } else {
                print("Query returned no results")
            }
        } else {
            let errmsg = String(cString: sqlite3_errmsg(db))
            print("SELECT statement could not be prepared: \(errmsg)")
        }
        sqlite3_finalize(queryStatement)
        return booking
    }
    
    
}

