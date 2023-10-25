import ballerina/graphql;
import ballerina/io;
import ballerina/lang.'float as f;
// Define global variables
string loggedInUsername = "";
string loggedInRole = "";
string loggedInId = "";
type LoginResponse record {|
    record {|UserDetails login;|} data;
|};

type UserDetails record {|
    string id;
    string username;
    string role;
|};


public function main() returns error? {
    graphql:Client graphqlClient = check new ("http://localhost:3000/performanceManagement");
    
    io:println("Welcome to the Performance Management System!");
    io:println("Please enter your employee ID and password to log in.");

    string username = io:readln("Employee ID: ");
    string password = io:readln("Password: ");

 string loginQuery = string `
    query Login($username: String!, $password: String!) {
        login(user: { username: $username, password: $password }) {
            id
            username
            role
        }
    }
`;


    LoginResponse response = check graphqlClient->execute(loginQuery, {"username": username, "password": password});
    
   // Set global variables
    loggedInId = response.data.login.id;
    loggedInUsername = response.data.login.username;
    loggedInRole = response.data.login.role;


    while loggedInRole == "HOD" {
        io:println("1. Create department objectives");
        io:println("2. Delete department objectives");
        io:println("3. View Employees Total Scores");
        io:println("4. Assign the Employee to a supervisor");

        string option = io:readln("Choose an option: ");

        if option == "1" {
    io:println("You chose to create a department objective.");
    io:println("Please enter the following details:");

    string id = io:readln("Department ID: ");
    string name = io:readln("Name: ");
    string weightStr = io:readln("Weight: ");
    float|error weightFloat = f:fromString(weightStr);
    decimal weight = weightFloat is float ? <decimal> weightFloat : 0.0;
    string departmentId = io:readln("DepartmentId: ");

    // Define the GraphQL mutation for the createDepartmentObjective operation.
    string createObjectiveMutation = string `
        mutation CreateObjective($id: String!, $name: String!, $weight: Decimal!, $departmentId: String!) {
            createDepartmentObjective(department: { id: $id, name: $name, weight: $weight, departmentId: $departmentId }) {
                id
                name
                weight
                departmentId
            }
        }
    `;

    // Execute the mutation using the GraphQL client.
    json|error response1 = graphqlClient->execute(createObjectiveMutation, {"id": id, "name": name, "weight": weight, "departmentId": departmentId});

    if (response1 is error) {
        io:println("Failed to execute GraphQL mutation: ", response1.message());
        return response1;
    } else {
        io:println("Successfully created department objective!");
        io:println(response1.toJsonString());
    }
}
        else if option == "2" {
    io:println("You chose to delete a department objective.");
    io:println("Please enter the following details:");

    string id = io:readln("Department Objective ID: ");

    // Define the GraphQL mutation for the deleteDepartmentObjective operation.
    string deleteObjectiveMutation = string `
        mutation DeleteObjective($id: String!) {
            deleteDepartmentObjective(id: $id)
        }
    `;

    // Execute the mutation using the GraphQL client.
    json|error response2 = graphqlClient->execute(deleteObjectiveMutation, {"id": id});

    if (response2 is error) {
        io:println("Failed to execute GraphQL mutation: ", response2.message());
        return response2;
    } else {
        io:println("Successfully deleted department objective!");
        io:println(response2.toJsonString());
    }
}

else if option == "3" {
    io:println("You chose to view an employee's total score.");
    io:println("Please enter the following details:");

    string employeeId = io:readln("Employee ID: ");

    // Define the GraphQL query for the totalScore operation.
    string totalScoreQuery = string `
        query TotalScore($employeeId: String!) {
            totalScore(employeeId: $employeeId)
        }
    `;

    // Execute the query using the GraphQL client.
    json|error response3 = graphqlClient->execute(totalScoreQuery, {"employeeId": employeeId});

    if (response3 is error) {
        io:println("Failed to execute GraphQL query: ", response3.message());
        return response3;
    } else {
        map<json> jsonResponse = <map<json>>response3;
        map<json> data = <map<json>>jsonResponse.get("data");
        string totalScore = data.get("totalScore").toString();
        
        io:println("Successfully retrieved employee's total score!");
        io:println(totalScore);
    }
}


       else if option == "4" {
    io:println("You chose to assign an employee to a supervisor.");
    io:println("Please enter the following details:");

    string id = io:readln("Employee ID: ");
    string supervisorId = io:readln("Supervisor ID: ");

    // Define the GraphQL mutation for the assignSupervisor operation.
    string assignSupervisorMutation = string `
        mutation AssignSupervisor($id: String!, $supervisorId: String!) {
            assignSupervisor(id: $id, superid: { supervisorId: $supervisorId })
        }
    `;

    // Execute the mutation using the GraphQL client.
    json|error response4 = graphqlClient->execute(assignSupervisorMutation, {"id": id, "supervisorId": supervisorId});

    if (response4 is error) {
        io:println("Failed to execute GraphQL mutation: ", response4.message());
        return response4;
    } else {
        io:println("Successfully assigned employee to supervisor!");
        io:println(response4.toJsonString());
    }
}


          else if option == "exit" {
            break;
        } else {
            io:println("Invalid option. Please try again.");
        }
    } while loggedInRole == "Supervisor" {
        io:println("1. Approve Employee's KPIs");
        io:println("2. Delete Employee’s KPIs");
        io:println("3. Update Employee's KPIs");
        io:println("4. View Employee Scores");
        io:println("5. Grade the employee’s KPIs");

        string option = io:readln("Choose an option: ");

        if option == "1" {
    io:println("You chose to approve an employee's KPIs.");
    io:println("Please enter the following details:");

    string id = io:readln("KPI ID: ");

    // Define the GraphQL mutation for the approveKPI operation.
    string approveKPIMutation = string `
        mutation ApproveKPI($id: String!) {
            approveKPI(id: $id)
        }
    `;

    // Execute the mutation using the GraphQL client.
    json|error response1 = graphqlClient->execute(approveKPIMutation, {"id": id});

    if (response1 is error) {
        io:println("Failed to execute GraphQL mutation: ", response1.message());
        return response1;
    } else {
        map<json> jsonResponse = <map<json>>response1;
        map<json> data = <map<json>>jsonResponse.get("data");
        string approvalStatus = data.get("approveKPI").toString();
        
        io:println(approvalStatus);
    }
}

         else if option == "2" {
    io:println("You chose to delete an employee's KPIs.");
    io:println("Please enter the following details:");

    string id = io:readln("KPI ID: ");

    // Define the GraphQL mutation for the deleteKPI operation.
    string deleteKPIMutation = string `
        mutation DeleteKPI($id: String!) {
            deleteKPI(id: $id)
        }
    `;

    // Execute the mutation using the GraphQL client.
    json|error response2 = graphqlClient->execute(deleteKPIMutation, {"id": id});

    if (response2 is error) {
        io:println("Failed to execute GraphQL mutation: ", response2.message());
        return response2;
    } else {
        map<json> jsonResponse = <map<json>>response2;
        map<json> data = <map<json>>jsonResponse.get("data");
        string deletionStatus = data.get("deleteKPI").toString();
        
        io:println(deletionStatus);
    }
}

        else if option == "3" {
    io:println("You chose to update an employee's KPIs.");
    io:println("Please enter the following details:");

    string id = io:readln("KPI ID: ");
    string name = io:readln("Name: ");
    string metricUnit = io:readln("Metric Unit: ");
    string weightStr = io:readln("Weight: ");
    float|error weightFloat = f:fromString(weightStr);
    decimal weight = weightFloat is float ? <decimal> weightFloat : 0.0;
    string scoreStr = io:readln("Score: ");
    float|error scoreFloat = f:fromString(scoreStr);
    decimal score = scoreFloat is float ? <decimal> scoreFloat : 0.0;
    string approvedStr = io:readln("Approved (true/false): ");
    boolean|error approvedBool = boolean:fromString(approvedStr);
    boolean approved = approvedBool is boolean ? approvedBool : false;

    // Define the GraphQL mutation for the updateKPI operation.
    string updateKPIMutation = string `
        mutation UpdateKPI($id: String!, $name: String!, $metricUnit: String!, $weight: Decimal!, $score: Decimal!, $approved: Boolean!) {
            updateKPI(id: $id, kpi: { name: $name, metricUnit: $metricUnit, weight: $weight, score:$score, approved: $approved })
        }
    `;

    // Execute the mutation using the GraphQL client.
    json|error response3 = graphqlClient->execute(updateKPIMutation, {"id": id, "name": name, "metricUnit": metricUnit, "weight": weight, "score": score, "approved": approved});

    if (response3 is error) {
        io:println("Failed to execute GraphQL mutation: ", response3.message());
        return response3;
    } else {
        map<json> jsonResponse = <map<json>>response3;
        map<json> data = <map<json>>jsonResponse.get("data");
        string updateStatus = data.get("updateKPI").toString();
        
        io:println(updateStatus);
    }
}

 
        else if option == "4" {
    io:println("You chose to view employee scores.");
    io:println("Please enter the following details:");

    string employeeId = io:readln("Employee ID: ");

    // Define the GraphQL query for the kpis operation.
    string kpisQuery = string `
        query Kpis($employeeId: String!) {
            kpis(employeeId: $employeeId) {
                id
                score
                employeeId
            }
        }
    `;

    // Execute the query using the GraphQL client.
    json|error response4 = graphqlClient->execute(kpisQuery, {"employeeId": employeeId});

    if (response4 is error) {
        io:println("Failed to execute GraphQL query: ", response4.message());
        return response4;
    } else {
        io:println("Successfully retrieved KPIs!");
        io:println(response4.toJsonString());
    }
}
else if option == "5" {
    io:println("You chose to grade an employee's KPIs.");
    io:println("Please enter the following details:");

    string id = io:readln("KPI ID: ");
    string scoreStr = io:readln("Score: ");
    float|error scoreFloat = f:fromString(scoreStr);
    decimal score = scoreFloat is float ? <decimal> scoreFloat : 0.0;

    // Define the GraphQL mutation for the scoreKPI operation.
    string scoreKPIMutation = string `
        mutation ScoreKPI($id: String!, $score: Decimal!) {
            scoreKPI(id: $id, kpi: { score: $score })
        }
    `;

    // Execute the mutation using the GraphQL client.
    json|error response5 = graphqlClient->execute(scoreKPIMutation, {"id": id, "score": score});

    if (response5 is error) {
        io:println("Failed to execute GraphQL mutation: ", response5.message());
        return response5;
    } else {
        map<json> jsonResponse = <map<json>>response5;
        map<json> data = <map<json>>jsonResponse.get("data");
        string gradingStatus = data.get("scoreKPI").toString();
        
        io:println(gradingStatus);
    }
}


    } while loggedInRole == "Employee" {
        io:println("1. Create their KPIs");
        io:println("2. Grade their Supervisor");
        io:println("3. View Their Scores");

        string option = io:readln("Choose an option: ");

        if option == "1" {
    io:println("You chose to create a KPI.");
    io:println("Please enter the following details:");

    string name = io:readln("Name: ");
    string metricUnit = io:readln("Metric Unit: ");
    string weightStr = io:readln("Weight: ");
    float|error weightFloat = f:fromString(weightStr);
    decimal weight = weightFloat is float ? <decimal> weightFloat : 0.0;
    string scoreStr = io:readln("Score: ");
    float|error scoreFloat = f:fromString(scoreStr);
    decimal score = scoreFloat is float ? <decimal> scoreFloat : 0.0;
    string departmentId = io:readln("Department ID: ");
    string employeeId = loggedInId;
    boolean approved = false; // Use the logged in user's ID

    // Define the GraphQL mutation for the createKPI operation.
    string createKPIMutation = string `
        mutation CreateKPI($name: String!, $metricUnit: String!, $weight: Decimal!, $score: Decimal!, $departmentId: String!, $employeeId: String!, $approved: Boolean!) {
            createKPI(kpi: { name: $name, metricUnit: $metricUnit, weight: $weight, score: $score, departmentId: $departmentId, employeeId: $employeeId ,approved: $approved }) {
                id
                name
                metricUnit
                weight
                score
                departmentId
                employeeId
            }
        }
    `;

    // Execute the mutation using the GraphQL client.
    json|error response1 = graphqlClient->execute(createKPIMutation, {"name": name, "metricUnit": metricUnit, "weight": weight, "score": score, "departmentId": departmentId, "employeeId": employeeId, "approved": approved});

    if (response1 is error) {
        io:println("Failed to execute GraphQL mutation: ", response1.message());
        return response1;
    } else {
        io:println("Successfully created KPI!");
        io:println(response1.toJsonString());
    }
}

        else if option == "2" {
    io:println("You chose to grade a supervisor.");
    io:println("Please enter the following details:");

    string name = io:readln(" Name: ");
    string scoreStr = io:readln("Score: ");
    float|error scoreFloat = f:fromString(scoreStr);
    decimal score = scoreFloat is float ? <decimal> scoreFloat : 0.0;
    string employeeId = io:readln("Supervisor Id: ");

    // Define the GraphQL mutation for the GradeSupervisor operation.
    string gradeSupervisorMutation = string `
        mutation GradeSupervisor($name: String!, $score: Decimal!, $employeeId: String!) {
            GradeSupervisor(kpi: { id:"", name: $name, score: $score, employeeId: $employeeId }) {
                name
                score
                employeeId
            }
        }
    `;

    // Execute the mutation using the GraphQL client.
    json|error response2 = graphqlClient->execute(gradeSupervisorMutation, {"name": name, "score": score, "employeeId": employeeId});

    if (response2 is error) {
        io:println("Failed to execute GraphQL mutation: ", response2.message());
        return response2;
    } else {
        io:println("Successfully graded supervisor!");
        io:println(response2.toJsonString());
    }
}

 
        else if option == "3" {
    io:println("You chose to view your scores.");

    string employeeId = loggedInId; // Use the logged in user's ID

    // Define the GraphQL query for the kpis operation.
    string kpisQuery = string `
        query Kpis($employeeId: String!) {
            kpis(employeeId: $employeeId) {
                id
                score
                employeeId
            }
        }
    `;

    // Execute the query using the GraphQL client.
    json|error response3 = graphqlClient->execute(kpisQuery, {"employeeId": employeeId});

    if (response3 is error) {
        io:println("Failed to execute GraphQL query: ", response3.message());
        return response3;
    } else {
        io:println("Successfully retrieved KPIs!");
        io:println(response3.toJsonString());
    }
}

    }


    return ();
}
