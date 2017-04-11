create database leavemanagement

create table newemployeedetails1
(
EmployeeId int identity(1,1) primary key,
ManagerId int,
FirstName varchar(30),
LastName varchar(30),
EmployeeContact varchar(10),
EmployeeDOB DateTime,
Department varchar(30),
EmployeeExperience int,
DateHired DateTime,
PanId varchar(15) unique,
AdharId varchar(20) unique,
EmployeeImgAddress varchar(30),
EmployeeSalary int,
NoOfUnpaidLeaves int,
NoOfPaidLeaves int
)

create table newleavetable2
(
EmployeeId int foreign key references newemployeedetails(EmployeeId),
StartDate DateTime,
NoOfDays int,
Reason varchar(30),
LeaveStatus varchar(20) check(LeaveStatus in('Approved','Cancel','pending')),

)

create trigger leave_update on newleavetable2 
FOR INSERT as 
begin 
declare @empid int 
select @empid=EmployeeId from inserted 
update newemployeedetails1 set NoOfPaidLeaves=NoOfPaidLeaves-1 where EmployeeId=@empid 
end
