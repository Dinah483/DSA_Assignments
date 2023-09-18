import ballerina/grpc;
import ballerina/protobuf;

public const string LIBRARY_DESC = "0A0D6C6962726172792E70726F746F12076C6962726172791A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F229A010A04426F6F6B12140A057469746C6518012001280952057469746C6512190A08617574686F725F311802200128095207617574686F723112190A08617574686F725F321803200128095207617574686F7232121A0A086C6F636174696F6E18042001280952086C6F636174696F6E12120A044953424E18052001280952044953424E12160A06737461747573180620012808520673746174757322380A045573657212160A06757365724944180120012809520675736572494412180A0770726F66696C65180220012809520770726F66696C6522280A0C55736572526573706F6E736512180A076D65737361676518012001280952076D65737361676522070A05456D70747922230A0D4C6F636174655265717565737412120A044953424E18012001280952044953424E222E0A104C6F636174696F6E526573706F6E7365121A0A086C6F636174696F6E18012001280952086C6F636174696F6E223B0A0D426F72726F775265717565737412160A06757365724944180120012809520675736572494412120A044953424E18022001280952044953424E222A0A0E426F72726F77526573706F6E736512180A076D65737361676518012001280952076D657373616765222F0A08426F6F6B4C69737412230A05626F6F6B7318012003280B320D2E6C6962726172792E426F6F6B5205626F6F6B733285030A0E4C6962726172795365727669636512270A07416464426F6F6B120D2E6C6962726172792E426F6F6B1A0D2E6C6962726172792E426F6F6B12350A0B4372656174655573657273120D2E6C6962726172792E557365721A152E6C6962726172792E55736572526573706F6E73652801122A0A0A557064617465426F6F6B120D2E6C6962726172792E426F6F6B1A0D2E6C6962726172792E426F6F6B122E0A0A52656D6F7665426F6F6B120D2E6C6962726172792E426F6F6B1A112E6C6962726172792E426F6F6B4C69737412370A124C697374417661696C61626C65426F6F6B73120E2E6C6962726172792E456D7074791A112E6C6962726172792E426F6F6B4C697374123F0A0A4C6F63617465426F6F6B12162E6C6962726172792E4C6F63617465526571756573741A192E6C6962726172792E4C6F636174696F6E526573706F6E7365123D0A0A426F72726F77426F6F6B12162E6C6962726172792E426F72726F77526571756573741A172E6C6962726172792E426F72726F77526573706F6E7365620670726F746F33";

public isolated client class LibraryServiceClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, LIBRARY_DESC);
    }

    isolated remote function AddBook(Book|ContextBook req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function AddBookContext(Book|ContextBook req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/AddBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function UpdateBook(Book|ContextBook req) returns Book|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/UpdateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <Book>result;
    }

    isolated remote function UpdateBookContext(Book|ContextBook req) returns ContextBook|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/UpdateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <Book>result, headers: respHeaders};
    }

    isolated remote function RemoveBook(Book|ContextBook req) returns BookList|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BookList>result;
    }

    isolated remote function RemoveBookContext(Book|ContextBook req) returns ContextBookList|grpc:Error {
        map<string|string[]> headers = {};
        Book message;
        if req is ContextBook {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/RemoveBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BookList>result, headers: respHeaders};
    }

    isolated remote function ListAvailableBooks(Empty|ContextEmpty req) returns BookList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BookList>result;
    }

    isolated remote function ListAvailableBooksContext(Empty|ContextEmpty req) returns ContextBookList|grpc:Error {
        map<string|string[]> headers = {};
        Empty message;
        if req is ContextEmpty {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/ListAvailableBooks", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BookList>result, headers: respHeaders};
    }

    isolated remote function LocateBook(LocateRequest|ContextLocateRequest req) returns LocationResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateRequest message;
        if req is ContextLocateRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <LocationResponse>result;
    }

    isolated remote function LocateBookContext(LocateRequest|ContextLocateRequest req) returns ContextLocationResponse|grpc:Error {
        map<string|string[]> headers = {};
        LocateRequest message;
        if req is ContextLocateRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/LocateBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <LocationResponse>result, headers: respHeaders};
    }

    isolated remote function BorrowBook(BorrowRequest|ContextBorrowRequest req) returns BorrowResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowRequest message;
        if req is ContextBorrowRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <BorrowResponse>result;
    }

    isolated remote function BorrowBookContext(BorrowRequest|ContextBorrowRequest req) returns ContextBorrowResponse|grpc:Error {
        map<string|string[]> headers = {};
        BorrowRequest message;
        if req is ContextBorrowRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("library.LibraryService/BorrowBook", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <BorrowResponse>result, headers: respHeaders};
    }

    isolated remote function CreateUsers() returns CreateUsersStreamingClient|grpc:Error {
        grpc:StreamingClient sClient = check self.grpcClient->executeClientStreaming("library.LibraryService/CreateUsers");
        return new CreateUsersStreamingClient(sClient);
    }
}

public client class CreateUsersStreamingClient {
    private grpc:StreamingClient sClient;

    isolated function init(grpc:StreamingClient sClient) {
        self.sClient = sClient;
    }

    isolated remote function sendUser(User message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function sendContextUser(ContextUser message) returns grpc:Error? {
        return self.sClient->send(message);
    }

    isolated remote function receiveUserResponse() returns UserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, _] = response;
            return <UserResponse>payload;
        }
    }

    isolated remote function receiveContextUserResponse() returns ContextUserResponse|grpc:Error? {
        var response = check self.sClient->receive();
        if response is () {
            return response;
        } else {
            [anydata, map<string|string[]>] [payload, headers] = response;
            return {content: <UserResponse>payload, headers: headers};
        }
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.sClient->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.sClient->complete();
    }
}

public client class LibraryServiceBookListCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBookList(BookList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBookList(ContextBookList response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryServiceLocationResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendLocationResponse(LocationResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextLocationResponse(ContextLocationResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryServiceBookCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBook(Book response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBook(ContextBook response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryServiceBorrowResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendBorrowResponse(BorrowResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextBorrowResponse(ContextBorrowResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public client class LibraryServiceUserResponseCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendUserResponse(UserResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextUserResponse(ContextUserResponse response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextUserStream record {|
    stream<User, error?> content;
    map<string|string[]> headers;
|};

public type ContextUserResponse record {|
    UserResponse content;
    map<string|string[]> headers;
|};

public type ContextEmpty record {|
    Empty content;
    map<string|string[]> headers;
|};

public type ContextUser record {|
    User content;
    map<string|string[]> headers;
|};

public type ContextBorrowRequest record {|
    BorrowRequest content;
    map<string|string[]> headers;
|};

public type ContextBookList record {|
    BookList content;
    map<string|string[]> headers;
|};

public type ContextBook record {|
    Book content;
    map<string|string[]> headers;
|};

public type ContextBorrowResponse record {|
    BorrowResponse content;
    map<string|string[]> headers;
|};

public type ContextLocationResponse record {|
    LocationResponse content;
    map<string|string[]> headers;
|};

public type ContextLocateRequest record {|
    LocateRequest content;
    map<string|string[]> headers;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type UserResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Empty record {|
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type User record {|
    string userID = "";
    string profile = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowRequest record {|
    string userID = "";
    string ISBN = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BookList record {|
    Book[] books = [];
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type Book record {|
    string title = "";
    string author_1 = "";
    string author_2 = "";
    string location = "";
    string ISBN = "";
    boolean status = false;
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type BorrowResponse record {|
    string message = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocationResponse record {|
    string location = "";
|};

@protobuf:Descriptor {value: LIBRARY_DESC}
public type LocateRequest record {|
    string ISBN = "";
|};

