import ballerina/io;

LibraryServiceClient ep = check new ("http://localhost:8081");

public function main() returns error? {
    Book addBookRequest = {
        title: "ballerina", 
        author_1: "ballerina", 
        author_2: "ballerina", 
        location: "ballerina", 
        ISBN: "ballerina", 
        status: true};
    Book|error addBookResponse = check ep->AddBook(addBookRequest);
    io:println(addBookResponse);

    Book updateBookRequest = {
        title: "ballerina", 
        author_1: "ballerina", 
        author_2: "ballerina", 
        location: "ballerina", 
        ISBN: "ballerina", 
        status: true};
    Book|error updateBookResponse = check ep->UpdateBook(updateBookRequest);
    io:println(updateBookResponse);

    Book removeBookRequest = {
        title: "ballerina", 
        author_1: "ballerina", 
        author_2: "ballerina", 
        location: "ballerina", 
        ISBN: "ballerina", 
        status: true};
    BookList|error removeBookResponse = check ep->RemoveBook(removeBookRequest);
    io:println(removeBookResponse);

    Empty listAvailableBooksRequest = {};
    BookList|error listAvailableBooksResponse = check ep->ListAvailableBooks(listAvailableBooksRequest);

    if (listAvailableBooksResponse is BookList) {
        io:println("Available Books:");
        foreach var book in listAvailableBooksResponse.books {
            io:println("Title: " + book.title + ", Author: " + book.author_1);
        }
    } else {
        io:println(listAvailableBooksResponse);
    }

    // io:println(listAvailableBooksResponse);

    LocateRequest locateBookRequest = {ISBN: "12345677"};
    LocationResponse|error locateBookResponse = check ep->LocateBook(locateBookRequest);
    if (locateBookResponse is LocationResponse) {
        io:println("Book Location: " + locateBookResponse.location);
    } else {
        io:println( locateBookResponse);
    }
    // io:println(locateBookResponse);

    BorrowRequest borrowBookRequest = {userID: "66", ISBN: "77654321"};
    BorrowResponse|error borrowBookResponse = check ep->BorrowBook(borrowBookRequest);
     if (borrowBookResponse is BorrowResponse) {
        io:println("Borrowing Status: " + borrowBookResponse.message);
        } 
     else {
        io:println( borrowBookResponse);
    }
    // io:println(borrowBookResponse);

    User createUsersRequest = {
        userID: "345", 
        profile: "student"};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->CreateUsers();
    check createUsersStreamingClient->sendUser(createUsersRequest);
    check createUsersStreamingClient->complete();
    UserResponse? createUsersResponse = check createUsersStreamingClient->receiveUserResponse();

 if (createUsersResponse is UserResponse) {
        io:println("User Creation Status: " + createUsersResponse.message);
    } else {
        io:println( createUsersResponse);
    }
    // io:println(createUsersResponse);
}

