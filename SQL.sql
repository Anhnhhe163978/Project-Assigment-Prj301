CREATE DATABASE LeaveManagementSystem;
USE LeaveManagementSystem;

-- Bảng lưu thông tin nhân viên
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(100) NOT NULL,
    Department VARCHAR(50),
    Position VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    HireDate DATE
);

-- Bảng lưu các loại trạng thái của đơn nghỉ
CREATE TABLE LeaveStatus (
    StatusID INT PRIMARY KEY IDENTITY(1,1),
    StatusName VARCHAR(50) NOT NULL -- Pending, Approved, Rejected, Canceled
);

-- Bảng lưu các lý do nghỉ
CREATE TABLE LeaveReasons (
    ReasonID INT PRIMARY KEY IDENTITY(1,1),
    ReasonDescription VARCHAR(255) NOT NULL -- Ví dụ: Ốm đau, Việc cá nhân, Nghỉ phép năm, Thai sản
);

-- Bảng lưu thông tin đơn xin nghỉ
CREATE TABLE LeaveRequests (
    RequestID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    ReasonID INT,
    StatusID INT,
    RequestDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ApprovedBy INT NULL, -- Người duyệt đơn
    ApprovalDate DATETIME NULL,
    Comments TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ReasonID) REFERENCES LeaveReasons(ReasonID),
    FOREIGN KEY (StatusID) REFERENCES LeaveStatus(StatusID),
    FOREIGN KEY (ApprovedBy) REFERENCES Employees(EmployeeID)
);

-- Bảng lưu thông tin vai trò
CREATE TABLE Roles (
    RoleID INT PRIMARY KEY IDENTITY(1,1),
    RoleName VARCHAR(50) NOT NULL -- Ví dụ: Admin, Manager, Employee
);

-- Bảng lưu thông tin tài khoản
CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT UNIQUE,
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    RoleID INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (RoleID) REFERENCES Roles(RoleID)
);

-- Bảng quyền quản lý đơn nghỉ
CREATE TABLE DepartmentManagers (
    ManagerID INT PRIMARY KEY IDENTITY(1,1),
    EmployeeID INT UNIQUE,
    Department VARCHAR(50) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);