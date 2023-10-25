import ballerina/io;
import ballerina/graphql;

graphql:Client graphqlClient = check new ("http://localhost:3000/performanceManagement");
public function main() returns error? {
    io:println("Welcome to the Performance Management System!");
    io:println("Please enter your employee ID and password to log in.");

    string employeeId = io:readln("Employee ID: ");
    string password = io:readln("Password: ");

    // TODO: Add logic to authenticate the user and determine their role (HoD, Supervisor, or Employee)

    string role = "HoD";  // Replace this with the actual role

    if role == "HoD" {
        io:println("1. Create department objectives");
        io:println("2. Delete department objectives");
        io:println("3. View Employees Total Scores");
        io:println("4. Assign the Employee to a supervisor");

        string option = io:readln("Choose an option: ");

        if option == "1" {
            // TODO: Add logic to create department objectives
        } else if option == "2" {
            // TODO: Add logic to delete department objectives
        } else if option == "3" {
            // TODO: Add logic to view employees total scores
        } else if option == "4" {
            // TODO: Add logic to assign the employee to a supervisor
        }
    } else if role == "Supervisor" {
        io:println("1. Approve Employee's KPIs");
        io:println("2. Delete Employee’s KPIs");
        io:println("3. Update Employee's KPIs");
        io:println("4. View Employee Scores");
        io:println("5. Grade the employee’s KPIs");

        string option = io:readln("Choose an option: ");

        if option == "1" {
            // TODO: Add logic to approve employee's KPIs
        } else if option == "2" {
            // TODO: Add logic to delete employee’s KPIs
        } else if option == "3" {
            // TODO: Add logic to update employee's KPIs
        } else if option == "4" {
            // TODO: Add logic to view employee scores
        } else if option == "5" {
            // TODO: Add logic to grade the employee’s KPIs
        }
    } else if role == "Employee" {
        io:println("1. Create their KPIs");
        io:println("2. Grade their Supervisor");
        io:println("3. View Their Scores");

        string option = io:readln("Choose an option: ");

        if option == "1" {
            // TODO: Add logic to create their KPIs
        } else if option == "2" {
            // TODO: Add logic to grade their supervisor
        } else if option == "3" {
            // TODO: Add logic to view their scores
        }
    }

    return ();
}
