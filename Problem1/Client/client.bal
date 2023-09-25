// AUTO-GENERATED FILE. DO NOT MODIFY.
// This file is auto-generated by the Ballerina OpenAPI tool.

import ballerina/http;
import ballerina/io;
public function main() returns error? {
    // io:println("Hello, World!");
    http:Client clientEp = check new http:Client("http://localhost:9090");

    io:println("1. Create Lecturer");
    io:println("2. Update Lecturer");
    io:println("3. Delete Lecturer");
    io:println("4. View All Lecturers");
    io:println("5. View Lecturers By Staff Number");
    io:println("6. View Lecturers By Office Number");
    io:println("7: View Lecturer By Course Code");
    string option = io:readln("Choose an option: ");

    match option {
       "1" => {
            // LecturerArr lecturers = [];
            Lecturer lecturer = {staffNumber: io:readln("Enter Staff Number:")};
            lecturer.officeNumber = io:readln("Enter Office Number: ");
            lecturer.staffName = io:readln("Enter Staff Name: ");
            lecturer.title = io:readln("Enter Title: ");

            // Create a new course instance and set its data as needed
            Course[] courseName = [check addCourse()];
            lecturer.courses= courseName;
            check create( clientEp , lecturer);
        }
       "2" => {
            // LecturerArr lecturers = [];

            Lecturer lecturer={staffNumber: io:readln("Enter staffNumber: ")};

            lecturer.staffNumber = io:readln("Enter Staff Number: ");
            lecturer.officeNumber = io:readln("Enter Office Number: ");
            lecturer.staffName = io:readln("Enter Staff Name: ");
            lecturer.title = io:readln("Enter Title: ");
            check update(clientEp, lecturer);
        }
        "3" => {
            string staff_number = io:readln("Enter Staff Number: ");
            string stringResult = check delete(clientEp, staff_number);
        }
        "4" => {
            check getAll(clientEp);
        }
        "5" => {
            string staffNumber = io:readln("Enter Staff Number: ");
            check getByStaffNumber(clientEp, staffNumber);
        }
        "6" => {
            string office_number = io:readln("Enter Office Number: ");
            check getByOfficeNumber(clientEp, office_number);
        }
         "7" => {
            string course_code = io:readln("Enter Course Code: ");
            check getByCourseCode(clientEp, course_code);
        }
        _ => {
            io:println("Invalid Key");
            check main();
        }
    }
}

function addCourse() returns Course|error {
      Course course = {
                courseCode: io:readln("Enter Course Code: "),
                courseName: io:readln("Enter Course Name: "),
                nqfLevel: check int:fromString(io:readln("Enter NQF Level: "))
            };
            return course;
}


// Function to create a course

public function create(http:Client http, Lecturer lecturer) returns error? {
    if (http is http:Client) {
        string message = check http->/lecturers.post(lecturer);
        io:println(message);
        string exit = io:readln("Press 0 to go back");

        if (exit === "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}

public function update(http:Client http, Lecturer lecturer) returns error? {
    // var create = check http.post("/createCourse", course);
    io:println(lecturer);
}

// HTTP client function to delete a lecturer by staff number
public function delete(http:Client http, string staffNumber) returns string | error {
    if (http is http:Client) {
        http:Response response = check http->delete("/lecturers/" + staffNumber);

        if (response.statusCode == http:STATUS_OK) {
            string message = check response.getTextPayload();
            return message;
        } else if (response.statusCode == http:STATUS_NOT_FOUND) {
            return "Lecturer not found";
        } else {
            // Handle other error cases here
    return response.getTextPayload();
        }
    }
}


public function getAll(http:Client http) returns error? {
    if (http is http:Client) {
        Lecturer[] lecturer = check http->/lecturers;
        foreach Lecturer item in lecturer {
            io:println("--------------------------");
            io:println("Staff Number : ", item.staffNumber);
            io:println("Office Number: ", item.officeNumber);
            io:println("Staff Name: ", item.staffName);
            io:println("Title: ", item.title);
            io:println("Courses: ", item.courses);
        }

        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}

public function getByStaffNumber(http:Client http, string staffNumber) returns error? {
    if (http is http:Client) {
        Lecturer lecturer = check http->/lecturers/[staffNumber];
        io:println("--------------------------");
        io:println("Staff Number : ", lecturer.staffNumber);
        io:println("Office Number: ", lecturer.officeNumber);
        io:println("Staff Name: ", lecturer.staffName);
        io:println("Title: ", lecturer.title);
        io:println("Courses: ", lecturer.courses);
        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}

public function getByOfficeNumber(http:Client http, string officeNumber) returns error? {
    if (http is http:Client) {
        Lecturer[] lecturer = check http->/offices/[officeNumber]/lecturers;
        foreach Lecturer item in lecturer {
        io:println("--------------------------");
        io:println("Staff Number : ", item.staffNumber);
        io:println("Office Number: ", item.officeNumber);
        io:println("Staff Name: ", item.staffName);
        io:println("Title: ", item.title);
        io:println("Courses: ", item.courses);
        }
        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}

public function getByCourseCode(http:Client http, string courseCode) returns error?{
     if (http is http:Client) {
        Lecturer[] lecturer = check http->/lectcourses/[courseCode]/lecturers;
        foreach Lecturer item in lecturer {
        io:println("--------------------------");
        io:println("Staff Number : ", item.staffNumber);
        io:println("Office Number: ", item.officeNumber);
        io:println("Staff Name: ", item.staffName);
        io:println("Title: ", item.title);
        io:println("Courses: ", item.courses);
        }
        io:println("--------------------------");
        string exit = io:readln("Press 0 to go back: ");

        if (exit == "0") {
            error? mainResult = main();
            if mainResult is error {
                io:println("Error, You can't go back.");
            }
        }
    }
}
public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + config - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(string serviceUrl, ConnectionConfig config =  {}) returns error? {
        http:ClientConfiguration httpClientConfig = {httpVersion: config.httpVersion, timeout: config.timeout, forwarded: config.forwarded, poolConfig: config.poolConfig, compression: config.compression, circuitBreaker: config.circuitBreaker, retryConfig: config.retryConfig, validation: config.validation};
        do {
            if config.http1Settings is ClientHttp1Settings {
                ClientHttp1Settings settings = check config.http1Settings.ensureType(ClientHttp1Settings);
                httpClientConfig.http1Settings = {...settings};
            }
            if config.http2Settings is http:ClientHttp2Settings {
                httpClientConfig.http2Settings = check config.http2Settings.ensureType(http:ClientHttp2Settings);
            }
            if config.cache is http:CacheConfig {
                httpClientConfig.cache = check config.cache.ensureType(http:CacheConfig);
            }
            if config.responseLimits is http:ResponseLimitConfigs {
                httpClientConfig.responseLimits = check config.responseLimits.ensureType(http:ResponseLimitConfigs);
            }
            if config.secureSocket is http:ClientSecureSocket {
                httpClientConfig.secureSocket = check config.secureSocket.ensureType(http:ClientSecureSocket);
            }
            if config.proxy is http:ProxyConfig {
                httpClientConfig.proxy = check config.proxy.ensureType(http:ProxyConfig);
            }
        }
        http:Client httpEp = check new (serviceUrl, httpClientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Get a list of all lecturers
    #
    # + return - A list of lecturers 
    resource isolated function get lecturers() returns Lecturer[]|error {
        string resourcePath = string `/lecturers`;
        Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Add a new lecturer
    #
    # + return - Lecturer created successfully 

    resource isolated function post lecturers(Lecturer payload) returns Lecturer|error {
        string resourcePath = string `/lecturers`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Lecturer response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get details of a specific lecturer by staff number
    #
    # + return - Lecturer details 
    resource isolated function get lecturers/[string staffNumber]() returns Lecturer|error {
        string resourcePath = string `/lecturers/${getEncodedUri(staffNumber)}`;
        Lecturer response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an existing lecturer's information
    #
    # + return - Lecturer updated successfully 
    resource isolated function put lecturers/[string staffNumber](Lecturer payload) returns Lecturer|error {
        string resourcePath = string `/lecturers/${getEncodedUri(staffNumber)}`;
        http:Request request = new;
        json jsonBody = payload.toJson();
        request.setPayload(jsonBody, "application/json");
        Lecturer response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete a lecturer by staff number
    #
    # + return - No content 
    resource isolated function delete lecturers/[string staffNumber]() returns http:Response|error {
        string resourcePath = string `/lecturers/${getEncodedUri(staffNumber)}`;
        http:Response response = check self.clientEp-> delete(resourcePath);
        return response;
    }
    # Get all lecturers teaching a certain course
    #
    # + return - A list of lecturers 
    resource isolated function get courses/[string courseCode]/lecturers() returns Lecturer[]|error {
        string resourcePath = string `/courses/${getEncodedUri(courseCode)}/lecturers`;
        Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Get all lecturers sitting in the same office
    #
    # + return - A list of lecturers 
    resource isolated function get offices/[string officeNumber]/lecturers() returns Lecturer[]|error {
        string resourcePath = string `/offices/${getEncodedUri(officeNumber)}/lecturers`;
        Lecturer[] response = check self.clientEp->get(resourcePath);
        return response;
    }
}
