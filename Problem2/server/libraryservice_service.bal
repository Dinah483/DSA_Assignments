import ballerina/grpc;

listener grpc:Listener ep = new (8081);
// Define the table to store books
table<Book> key(ISBN) booksTable = table[];


@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {

    remote function AddBook(Book value) returns ()|error {


        error? newBook = booksTable.add(value);

        if newBook is error {
            return newBook;
        } else {
            return newBook;
        }
    }
    
    remote function UpdateBook(Book value) returns Book|error {
        // Check if the book exists in the library
        boolean bookExists = checkBookExistence(value.ISBN);
        
        if (bookExists) {
            // Update the book's information in the library's book collection
            updateBookInformation(value);
            return value;
        } else {
            return error("Book not found");
        }
    }
    
    remote function ListAvailableBooks(Empty value) returns BookList|error {
        // Get a list of all available books in the library
        BookList availableBooks = getAvailableBooks();
        
        if (availableBooks.books.length() > 0) {
            return availableBooks;
        } else {
            return error("No available books in the library");
        }
    }
    
    remote function LocateBook(LocateRequest value) returns LocationResponse|error {
        // Locate a book in the library by ISBN
        LocationResponse? response = locateBookByISBN(value.ISBN);
        
        if (response != null) {
            return response;
        } else {
            return error("Book not found or not available");
        }
    }
    
    remote function BorrowBook(BorrowRequest value) returns BorrowResponse|error {
        // Borrow a book by a student using their user ID and the book's ISBN
        BorrowResponse response = borrowBookByUserID(value.userID, value.ISBN);
        
        if (response.success) {
            return response;
        } else {
            return error("Borrowing failed: " + response.message);
        }
    }
    
     remote function RemoveBook(Book value) returns Book|error {
        // Remove the book from the library's book collection by ISBN
        Book? updatedBookList = removeBookByISBN(value.ISBN);
        
        if (updatedBookList != null) {
            return updatedBookList;
        } else {
            return error("Book not found");
        }
    }
    remote function CreateUsers(stream<User, grpc:Error?> clientStream) returns UserResponse|error {
        // Create users (students) by streaming their information
        UserResponse response = createUserStream(clientStream);
        
        if (response.success) {
            return response;
        } else {
            return error("User creation failed: " + response.message);
        }
    }
}


function checkBookExistence(string ISBN) returns boolean {
    // Check if the book exists in the table
    return booksTable[ISBN] != ();
}

function addBookToCollection(Book book) {
    // Add the new book to the table
    var bookToUpdate = booksTable.get(book.ISBN);
    if (bookToUpdate is Book) {
        bookToUpdate = book;
        booksTable.add(book);
    } else {
        // Book not found, handle error
    }
}

function updateBookInformation(Book book) {
    // Update the book's information in the table
        var bookToUpdate = booksTable.get(book.ISBN);
        if (bookToUpdate is Book) {
            bookToUpdate = book;
            booksTable.put(book);
        } else {
            // Book not found, handle error
        }
        }
    
function removeBookByISBN(string ISBN) returns ()|Book {
    // Try to remove the book from the table
    var updatedBookList = booksTable.remove(ISBN);
    var original = booksTable;
    if (updatedBookList.length() !== original.length()) {
        return updatedBookList;
    } else {
        return ();
    }
}


function getAvailableBooks() returns BookList {
    // Get a list of all available books from the table
    BookList availableBooks = {};

    foreach var book in booksTable {
        if (book.status) {
            availableBooks.books.push(book);
        }
    }

    return availableBooks;
}
function borrowBookByUserID(string userID, string ISBN) returns BorrowResponse {
    // Check if the book exists in the library
    var book = booksTable.get(ISBN);
    
    if (book is Book) {
        // Check if the book is available
           BorrowResponse response;
        if (book.status) {
            // Mark the book as borrowed and associate it with the user
            book.status = false;
            book.borrowedBy = userID;
            
             response = {success: true, message: "Book borrowed successfully"};
            return response;
        } else {
            // Book is not available for borrowing
             response = {success: false, message: "Book is not available for borrowing"};
            return response;
        }
    }
}

function locateBookByISBN(string ISBN) returns LocationResponse? {
    // Locate a book's location by ISBN (you can implement this logic)
    // For this example, we assume the book's location is stored in the book record.
    var book = booksTable.get(ISBN);
    if (book is Book) {
        LocationResponse response = {location: book.location};
        return response;
    } else {
        // Book not found, handle accordingly.
        
    }
}
    

function createUserStream(stream<User, grpc:Error?> clientStream) returns UserResponse {
    // Process and create users (students) by streaming their information
    // For this example, we assume successful user creation.
    UserResponse response = {success: true, message: "Users created successfully"};
    
    while (true) {
        var userResult = clientStream.next();
        if (userResult.count() != User.count()) {
            // Process the user information here (e.g., add to a user table)
        } else if (userResult is grpc:Error) {
            // Handle streaming error
            response.success = false;
            if (userResult is grpc:Error) {
                response.message = "User creation failed: " + userResult.message();
            }
            break;
        } else {
            // End of stream
            break;
        }
    }
    
    return response;
}
