import ballerina/io;
import ballerina/http;

public function main() returns error? {
    // io:println("Hello, World!");
    http:Client clientEp = check new http:Client("http://localhost:9090/ep0");

    io:println("1. Create Lecturer");
    io:println("2. Update Lecturer");
    io:println("3. Delete Lecturer");
    io:println("4. View All Lecturers");
    io:println("5. View Lecturers By Staff Number");
    io:println("6. View Lecturers By Office Number");
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
            check delete(clientEp, staff_number);
        }
        "4" => {
            check getAll(clientEp);
        }
        "5" => {
            string staffNumber = io:readln("Enter Staff Number: ");
            check getByStaffNumber(clientEp, staffNumber);
        }
        "6" => {
            string office_number = io:readln("Enter Office Number");
            check getByOfficeNumber(clientEp, office_number);
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

public function delete(http:Client http, string|string[] name) returns error? {
    if (http is http:Client) {
        string message = check http->/deleteCourseByName.get({name});
        io:println(message);
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
        Lecturer lecturer = check http->/lecturers(staffNumber = staffNumber);
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
        Lecturer lecturer = check http->/offices/[officeNumber];
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
    //getBycourse
}
