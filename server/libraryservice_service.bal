import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_DESC}
service "LibraryService" on ep {

    remote function AddBook(Book value) returns string|error {
        // code to fix undefined symbol 'lib' error
        return "Successfully added a new book" + value.title;
        // code below to be corrected:
        // int currVersion = 0;
        // foreach Library lib in libs  {
        //     if lib.name == value.title {
        //         currVersion = lib.versionNum;
        //         if lib.versionNum == value.lib.versionNum {
        //         return error("That book already exists");
        //         }
            // }

    }
    remote function UpdateBook(Book value) returns Book|error {
        return error grpc:UnimplementedError("not yet implemented");
    }
    remote function RemoveBook(Book value) returns BookList|error {
        return error grpc:UnimplementedError("not yet implemented");
    }
    remote function ListAvailableBooks(Empty value) returns BookList|error {
        return error grpc:UnimplementedError("not yet implemented");
    }
    remote function LocateBook(LocateRequest value) returns LocationResponse|error {
        return error grpc:UnimplementedError("not yet implemented");
    }
    remote function BorrowBook(BorrowRequest value) returns BorrowResponse|error {
         return error grpc:UnimplementedError("not yet implemented");
    }
    remote function CreateUsers(stream<User, grpc:Error?> clientStream) returns UserResponse|error {
        return error grpc:UnimplementedError("not yet implemented");
    }
}

