import ballerina/io;

LibraryServiceClient ep = check new ("http://localhost:9090");

public function main() returns error? {
    Book addBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    Book addBookResponse = check ep->AddBook(addBookRequest);
    io:println(addBookResponse);

    Book updateBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    Book updateBookResponse = check ep->UpdateBook(updateBookRequest);
    io:println(updateBookResponse);

    Book removeBookRequest = {title: "ballerina", author_1: "ballerina", author_2: "ballerina", location: "ballerina", ISBN: "ballerina", status: true};
    BookList removeBookResponse = check ep->RemoveBook(removeBookRequest);
    io:println(removeBookResponse);

    Empty listAvailableBooksRequest = {};
    BookList listAvailableBooksResponse = check ep->ListAvailableBooks(listAvailableBooksRequest);
    io:println(listAvailableBooksResponse);

    LocateRequest locateBookRequest = {ISBN: "ballerina"};
    LocationResponse locateBookResponse = check ep->LocateBook(locateBookRequest);
    io:println(locateBookResponse);

    BorrowRequest borrowBookRequest = {userID: "ballerina", ISBN: "ballerina"};
    BorrowResponse borrowBookResponse = check ep->BorrowBook(borrowBookRequest);
    io:println(borrowBookResponse);

    User createUsersRequest = {userID: "ballerina", profile: "ballerina"};
    CreateUsersStreamingClient createUsersStreamingClient = check ep->CreateUsers();
    check createUsersStreamingClient->sendUser(createUsersRequest);
    check createUsersStreamingClient->complete();
    UserResponse? createUsersResponse = check createUsersStreamingClient->receiveUserResponse();
    io:println(createUsersResponse);
}

