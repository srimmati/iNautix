create database BloodBank

create table Blood
(
BloodId int identity(1,1) primary key,
BloodName varchar(30),
)

alter table Blood add TotalAmount int
select * from blood
insert Blood values('A positive')
insert Blood values('A negative')
insert Blood values('AB positive',0)
insert Blood values('AB negative',0)
insert Blood values('O positive',0)
insert Blood values('O negative',0)
create table Cities
(
CityId int identity(100001,1) primary key,
CityName varchar(30)
)
insert cities values('Erode')
insert cities values('Theni')
insert cities values('Virudhunagar')
insert cities values('Nagarkovil')

select * from cities
select * from blood

create table Donor
(
DonorID int identity(1000,1) primary key,
DonorName varchar(50),
DonorContactNo varchar(30),
DonorAddress varchar(50),
DonorCity int foreign key references cities(cityid),
DonorPincode varchar(20),
DonorAge int,
DonorGender varchar(30),
DonorBloodGroup int foreign key references blood(bloodid)
)



create table BloodBank
(
BloodBankId int identity(10101,1) primary key,
BloodBankName varchar(50),
BloodBankContactNo varchar(30),
BloodBankAddress varchar(50),
BloodBankCity int foreign key references Cities(CityId),
BloodBankPincode varchar(20),
)



create table Hospital
(
HospitalId int identity(111,1) primary key,
HospitalName varchar(50),
HospitalContactNo varchar(30),
HospitalAddress varchar(50),
HospitalCity int foreign key references Cities(CityId),
HospitalPincode varchar(20)
)
select * from donor
select * from Hospital
select * from BloodBank
update hospital set hospitalcontactno='9842073224' where hospitalid=111
update hospital set hospitalcontactno='8124278109' where hospitalid=112
update hospital set hospitalcontactno='7113465781' where hospitalid=113

delete donor

select bloodbankname from bloodbank where BloodBankCity=100003

create table BloodDetails 
(
BloodPacketId int identity(1,1) primary key,
BloodBankId int foreign key references Bloodbank(bloodbankid), 
BloodGroupId int foreign key references blood(bloodid),
BloodAmount varchar(30)
)




create table RequestDetails
(
RequestId int identity(1,1) primary key,
RequestHospitalId int foreign key references Hospital(HospitalId),
requestBloodGroupId int foreign key references blood(bloodid),
RequestBloodAmount varchar(30),
RequestDate datetime,
RequestDetails varchar(30)
)
alter table RequestDetails add RequestStatus varchar(30)
update RequestDetails set RequestStatus='Pending'

select * from BloodDetails
select * from RequestDetails
select * from DonationDetails where donorid=1001
select * from blood
create table DonationDetails
(
DonationId int identity(1,1) primary key,
DonorId int foreign key references Donor(DonorId),
DonationBloodGroupId int foreign key references blood(bloodid),
DonationBloodAmount varchar(30),
DonationDate datetime,  
AvailabityStatus varchar(30)
)

alter table DonationDetails add AvailabityStatus varchar(30)
update DonationDetails set AvailabityStatus='UnAvailable' where donationid=1

create trigger trg_bloodamount_insert
on DonationDetails
after insert
as 
begin
  declare @bloodid int
  declare @bloodamt int
  select @bloodid=DonationBloodGroupId,@bloodamt=DonationBloodAmount from inserted
  
  update blood set totalamount= totalamount+@bloodamt where bloodid=@bloodid
end  


create trigger trg_bloodamount_update
on DonationDetails
after update
as 
begin
  declare @bloodid int
  declare @bloodamt int
  select @bloodid=DonationBloodGroupId,@bloodamt=DonationBloodAmount from inserted
  
  update blood set totalamount= totalamount-@bloodamt where bloodid=@bloodid
end  



select * from  DonationDetails where DonationBloodGroupId in (select BloodId from blood where bloodname='A negative') and AvailabityStatus='Available'
select * from DonationDetails where AvailabityStatus='Available' and DonationBloodGroupId in(select BloodId from blood where bloodname='A negative') 

update blood set totalamount=300 where bloodid=3
select * from blood

update RequestDetails set RequestStatus='Done' where requestid=1 


drop table RequestDetails


create table Allocation
(
AllocationId int identity(1,1),
DonationId int foreign key references DonationDetails(DonationId),
RequestId int foreign key references RequestDetails(RequestId),
BloodGroupId int foreign key references Blood(BloodId),
BloodAmount int
)
select * from Allocation
select * from RequestDetails
select * from DonationDetails 
select * from bloodbank
select * from hospital
select * from donor
select * from cities
select DonorName from Donor where DonorId in (select DonorId from DonationDetails Where donationid in(select DonationId from Allocation Where AllocationId=1))
select HospitalName from hospital where hospitalId in (select RequesthospitalId from RequestDetails Where Requestid in(select Requestid from Allocation Where AllocationId=1))  

select * from aspnet_membership