"import ballerina/graphql;
import ballerinax/mongodb;
import ballerina/uuid;
import ballerina/io;
// import ballerina/log;                        
// Define the MongoDB connection configuration.
mongodb:ConnectionConfig mongoConfig = {
    connection: {
        host: "localhost",
        port: 27017,  // Replace with the correct port
        auth: {
            username: "",
            password: ""
        },
        options: {
            sslEnabled: false,  // Set to true if your MongoDB uses SSL
            serverSelectionTimeout: 5000  // Adjust the timeout value as needed
        }
    },
    databaseName: "PerformanceManagement"  // Replace with your actual database name
};

type DepartmentObjective record {
    readonly string id;
    string name;
    decimal weight;
    string departmentId;
};

type KPI record {
    readonly string id;
    string name;
    string metricUnit; // E.g., percentage, time, counts, currency, etc.
    decimal weight;
    decimal score;
    string departmentId;
    string employeeId;
    boolean approved;
};



type User record {
    readonly string username;
    readonly string id;
    string firstName;
    string lastName;
    string jobTitle;
    string position;
    string role;
    string departmentId;
    string supervisorId;
    string password;
};



type PerformanceScore record {
    readonly string id;
    string employeeId;
    string kpiId;
    decimal value;
};

type Department record {
    string name;
    string hod;
};
type CreateDepartmentInput record {
    string id;
    string name;
    string hod;
};



type CreateUserInput record {
    string username;
    string id;
    string firstName;
    string lastName;
    string jobTitle;
    string position;
    string role;
    string departmentId;
    string supervisorId;
    string password;
};

type CreateDepartmentObjectiveInput record {
   string id;
    string name;
    decimal weight;
    string departmentId;
};

type CreateSupervisorInput record {
    string firstName;
    string lastName;
    string jobTitle;
    string position;
};

type CreateKPIInput record {
    string name;
    string metricUnit;
    decimal weight;
    decimal score;
    string departmentId;
    string employeeId;
    boolean approved;
};

type UpdateDepartmentInput record {
    string name?;
    string hod?;
};
type AssignSupervisorInput record {
    string supervisorId;
};

type UpdateKPIInput record {
    string name;
    string metricUnit;
    decimal weight;
    decimal score;
    string departmentId;
    boolean approved;
};

type scoreKPIInput record {
    decimal score;
};

mongodb:Client mongoClient = check new (mongoConfig);

    string departmentCollectionName = "departments";
    string employeeCollectionName = "employees";
    string supervisorCollectionName = "supervisors";
    string objectiveCollectionName = "objectives";
    string kpiCollectionName = "kpis";  

type UserDetails record {
    string username;
    string role;
    string password;
};

type LoggedUserDetails record {|
    string username;
    string role;
|};

type UserLogin record {|
    string username;
    string password;
|};

@graphql:ServiceConfig {
    graphiql: {
        enabled: true
    }
}
service /performanceManagement on new graphql:Listener(3000) {
    
    // Define GraphQL resource functions for creating, updating, and querying data.

    // Resource function to create a KPI.
    resource function get createDepartment(CreateDepartmentInput department) returns Department|error? {
        
        // Generate a unique department ID using UUID.
    }
   remote function createDepartment(CreateDepartmentInput department) returns Department|error? {
    // Use the provided department ID.
    string id = department.id;
    io:println("Department ID ", id);

    // Create a JSON object with the provided department details.
    map<json> doc = {
        "id": id,
        "name": department.name,
        "hod": department.hod
    };

    // Insert the department data into the MongoDB collection.
     check mongoClient->insert(doc, departmentCollectionName);

    // Return the created department.
    return {
        name: department.name,
        hod: department.hod
    };
}
// string id;
//     string name;
//     decimal weight;
//     string departmentId;
remote function createDepartmentObjective(CreateDepartmentObjectiveInput department) returns DepartmentObjective|error? {
    // Use the provided department ID.
    string id = department.id;
    io:println("Department ID: ", id);

    // Create a JSON object with the provided department details.
    map<json> doc = {
        "id": id,
        "name": department.name,
        "weight": department.weight,
        "departmentId": department.departmentId
    };

    // Insert the department data into the MongoDB collection.
     check mongoClient->insert(doc, objectiveCollectionName);

    // Return the created department.
    return {
        id: id,
        name: department.name,
        weight: department.weight,
        departmentId: department.departmentId
    };
}

    // resource function update Department(string id, Department department) returns Department {
    //     // Implement the logic to update a department and return the updated department.
    // }

    remote function createEmployee(CreateUserInput user) returns User|error? {
    // Generate a unique employee ID using UUID.
   string id = user.id;
    io:println("User ID: ", id);

    // Create a JSON object with the provided employee details.
    map<json> doc = {
        "username": user.username,
        "id": id,
        "firstName": user.firstName,
        "lastName": user.lastName,
        "jobTitle": user.jobTitle,
        "position": user.position,
        "role": user.role,
        "departmentId": user.departmentId,
        "supervisorId": user.supervisorId,
        "password": user.password
    };

    // Insert the employee data into the MongoDB collection.
    check mongoClient->insert(doc, employeeCollectionName);

    // Return the created employee.
    return {
        username: user.username,
        id: id,
        firstName: user.firstName,
        lastName: user.lastName,
        jobTitle: user.jobTitle,
        position: user.position,
        role: user.role,
        departmentId: user.departmentId,
        supervisorId: user.supervisorId,
        password: user.password
    };
}

    // resource function update Employee(string id, Employee employee) returns Employee {
    //     // Implement the logic to update an employee and return the updated employee.
    // }

    

    // resource function update Supervisor(string id, Supervisor supervisor) returns Supervisor {
    //     // Implement the logic to update a supervisor and return the updated supervisor.
    // }

    remote function createKPI(CreateKPIInput kpi) returns KPI|error? {
    // Generate a unique KPI ID using UUID.
    string id = uuid:createType1AsString();
    io:println("KPI ID ", id);

    // Create a JSON object with the provided KPI details.
    map<json> doc = {
        "id": id,
        "name": kpi.name,
        "metricUnit": kpi.metricUnit,
        "weight": kpi.weight,
        "score": kpi.score,
        "departmentId": kpi.departmentId,
        "employeeId": kpi.employeeId,
        "approved": false
    };

    // Insert the KPI data into the MongoDB collection.
    check mongoClient->insert(doc, kpiCollectionName);

    // Return the created KPI.
    return {
        id: id,
        name: kpi.name,
        metricUnit: kpi.metricUnit,
        weight: kpi.weight,
        score: kpi.score,
        departmentId: kpi.departmentId,
        employeeId:kpi.employeeId,
        approved: kpi.approved
    };
}
remote function deleteDepartment(string id) returns string | error? {
    map<json> deleteFilter = { "id": id };
    int deleteRet = checkpanic mongoClient->delete("departments", (), deleteFilter, true);
    if (deleteRet > 0 ) {
       return "Department deleted successfully";
   } else {
       return "Department delete failed";
   }
     // mongoClient->close();
}

remote function deleteDepartmentObjective(string id) returns string | error? {
    map<json> deleteFilter = { "id": id };
    int deleteRet = checkpanic mongoClient->delete("objectives", (), deleteFilter, true);
    if (deleteRet > 0 ) {
       return "Department deleted successfully";
   } else {
       return "Department delete failed";
   }

     // mongoClient->close();
}

remote function deleteKPI(string id) returns string | error? {
    map<json> deleteFilter = { "id": id };
    int deleteRet = checkpanic mongoClient->delete("kpis", (), deleteFilter, true);
    if (deleteRet > 0 ) {
       return "Department deleted successfully";
   } else {
       return "Department delete failed";
   }

     // mongoClient->close();
}

// // update(map<json> updateStatement, string collectionName, string? databaseName, map<json>? filter, boolean isMultiple, boolean upsert)
// remote function updateDepartment(string id, UpdateDepartmentInput department) returns string | error? {
//     map<json> replaceFilter = { "id": id };
//     map<json> replaceDoc = {
//         "name": department.name,
//         "hod": department.hod};
//     io:println("replaceFilter: ", replaceFilter);
//     io:println("replaceDoc: ", replaceDoc);
//     int|error response = mongoClient->update(replaceDoc, "departments",(), replaceFilter, true);
//     if (response is error) {
//         return "Failed to update department: " + response.message();
//     } else if (response > 0) {
//         return "Department updated successfully";
//     } else {
//         return "No matching department found";
//     }
// }

remote function updateDepartments(string id, UpdateDepartmentInput department) returns string | error? {
    // Use the provided department ID.
    // string departmentId = id;

    // Create a filter to identify the department to update based on the ID.
    map<json> filter = {
        "id": id
    };

    // Create an update statement with the $set operator to update specific fields.
    map<json> updateStatement = {
        "$set": {
            "name": department.name,
            "hod": department.hod
        }
    };

    // Perform the update operation on the "departments" collection.
    int|error response = mongoClient->update(updateStatement, "departments", null, filter, false, false);

    if (response is error) {
        io:println("Error updating department: " + response.message());
        return "Failed to update department";
    } else if (response > 0) {
        io:println("Department updated successfully");
        return "Department updated successfully";
    } else {
        io:println("No matching department found");
        return "No matching department found";
    }
}

remote function approveKPI(string id) returns string | error? {
    // Use the provided department ID.
    // string departmentId = id;

    // Create a filter to identify the department to update based on the ID.
    map<json> filter = {
        "id": id
    };

    // Create an update statement with the $set operator to update specific fields.
    map<json> updateStatement = {
        "$set": {
            "approved": true
        }
    };

    // Perform the update operation on the "departments" collection.
    int|error response = mongoClient->update(updateStatement, "kpis", null, filter, false, false);

    if (response is error) {
        io:println("Error updating department: " + response.message());
        return "Failed to update department";
    } else if (response > 0) {
        io:println("Department updated successfully");
        return "Department updated successfully";
    } else {
        io:println("No matching department found");
        return "No matching department found";
    }
}

remote function updateKPI(string id, UpdateKPIInput kpi) returns string | error? {
    // Use the provided department ID.
    // string departmentId = id;

    // Create a filter to identify the department to update based on the ID.
    map<json> filter = {
        "employeeId": id
    };

    // Create an update statement with the $set operator to update specific fields.
    map<json> updateStatement = {
        "$set": {
            "name":kpi.name,
            "metricUnit": kpi.metricUnit,
            "weight": kpi.weight,
            "departmentId": kpi.departmentId,
            "approved": kpi.approved
        }
    };

    // Perform the update operation on the "departments" collection.
    int|error response = mongoClient->update(updateStatement, "kpis", null, filter, false, false);

    if (response is error) {
        io:println("Error updating department: " + response.message());
        return "Failed to update department";
    } else if (response > 0) {
        io:println("Department updated successfully");
        return "Department updated successfully";
    } else {
        io:println("No matching department found");
        return "No matching department found";
    }
}

remote function scoreKPI(string id, scoreKPIInput kpi) returns string | error? {
    // Use the provided department ID.
    // string departmentId = id;

    // Create a filter to identify the department to update based on the ID.
    map<json> filter = {
        "id": id
    };

    // Create an update statement with the $set operator to update specific fields.
    map<json> updateStatement = {
        "$set": {
           "score": kpi.score
        }
    };

    // Perform the update operation on the "departments" collection.
    int|error response = mongoClient->update(updateStatement, "kpis", null, filter, false, false);

    if (response is error) {
        io:println("Error updating department: " + response.message());
        return "Failed to update department";
    } else if (response > 0) {
        io:println("Department updated successfully");
        return "Department updated successfully";
    } else {
        io:println("No matching department found");
        return "No matching department found";
    }
}

remote function assignSupervisor(string id, AssignSupervisorInput superid) returns string | error? {
    // Use the provided department ID.
    // string departmentId = id;

    // Create a filter to identify the department to update based on the ID.
    map<json> filter = {
        "id": id
    };

    // Create an update statement with the $set operator to update specific fields.
    map<json> updateStatement = {
        "$set": {
            "supervisorId": superid.supervisorId
        }
    };

    // Perform the update operation on the "departments" collection.
    int|error response = mongoClient->update(updateStatement, "employees", null, filter, false, false);

    if (response is error) {
        io:println("Error updating department: " + response.message());
        return "Failed to update department";
    } else if (response > 0) {
        io:println("Department updated successfully");
        return "Department updated successfully";
    } else {
        io:println("No matching department found");
        return "No matching department found";
    }
}

 resource function get kpis(string employeeId) returns KPI[] | error {
        map<json> filter = { "employeeId": employeeId };

        stream<KPI, error?> kpiStream = check mongoClient->find(kpiCollectionName, "PerformanceManagement", filter, {});

        KPI[] kpis = check from var kpi in kpiStream select kpi;

        if (kpis.length() > 0) {
            return kpis;
        } else {
            // Return an error if no matching KPIs are found.
            return error("No matching KPIs found for the specified employeeId.");
        }
    }

resource function get totalScore(string employeeId) returns string | error {
    map<json> filter = { "employeeId": employeeId };

    stream<KPI, error?> kpiStream = check mongoClient->find(kpiCollectionName, "PerformanceManagement", filter, {});

    KPI[] kpis = check from var kpi in kpiStream select kpi;

    if (kpis.length() > 0) {
        decimal totalScore = 0;
        foreach KPI kpi in kpis {
            totalScore += kpi.score;
        }
        decimal maxScore = kpis.length() * 5;
        return "You have scored " + totalScore.toString() + " out of a possible " + maxScore.toString() + ".";
    } else {
        // Return an error if no matching KPIs are found.
        return error("No matching KPIs found for the specified employeeId.");
    }
}


// In this function, I first create a filter with the employeeId. 
// Then I call mongoClient->find to get a stream of KPIs that match this filter. 
// I use a query expression to convert this stream into an array of KPIs. If there are any KPIs, I return them. 
// If there are no KPIs, I return an empty array.

resource function get supervisedKpis(string supervisorId) returns KPI[] | error {
    // First, find all employees supervised by the given supervisor.
    map<json> employeeFilter = { "supervisorId": supervisorId };
    stream<User, error?> employeeStream = check mongoClient->find(employeeCollectionName, "PerformanceManagement", employeeFilter, {});
    User[] employees = check from var employee in employeeStream select employee;

    io:println("Found " + employees.length().toString() + " employees for supervisor " + supervisorId);

    if (employees.length() > 0) {
        // Then, for each supervised employee, find and accumulate their KPIs.
        KPI[] kpis = [];
        foreach User employee in employees {
            map<json> kpiFilter = { "employeeId": employee.id };
            stream<KPI, error?> kpiStream = check mongoClient->find(kpiCollectionName, "PerformanceManagement", kpiFilter, {});
            KPI[] employeeKpis = check from var kpi in kpiStream select kpi;
            kpis.push(...employeeKpis);

            io:println("Found " + employeeKpis.length().toString() + " KPIs for employee " + employee.id);
        }

        io:println("Total KPIs found: " + kpis.length().toString());

        if (kpis.length() > 0) {
            return kpis;
        } else {
            // Return an error if no matching KPIs are found.
            return error("No matching KPIs found for the supervised employees.");
        }
    } else {
        // Return an error if no matching employees are found.
        return error("No matching employees found for the specified supervisorId.");
    }
}


// query
    resource function get login(UserLogin user) returns LoggedUserDetails|error {
        stream<UserDetails, error?> usersDeatils = check mongoClient->find(employeeCollectionName, "PerformanceManagement", {username: user.username, password: user.password}, {});

        UserDetails[] users = check from var userInfo in usersDeatils
            select userInfo;
        io:println("Users ", users);
        // If the user is found return a user or return a string user not found
        if users.length() > 0 {
            return {username: users[0].username, role: users[0].role};
        }
        return {
            username: "user not found",
            role: "user not found"
        };
    }

}


"
