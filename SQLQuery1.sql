Create Database Blog
use Blog

create table Categories(
Id  int primary key identity,
[Name] nvarchar(30) not null unique
)

create table Tags(
Id  int primary key identity,
[Name] nvarchar(30) not null unique
)

create table Users(
Id  int primary key identity,
UserName nvarchar(30) not null unique,
FullName nvarchar(30) not null,
Age int check(Age>=0 and Age <=150)
)


create table Blogs(
Id  int primary key identity,
Title nvarchar(50) not null,
[Description] nvarchar(30) not null ,
 UserId INT,
 CategoryId INT,
 foreign key (UserId) REFERENCES Users(Id),
 foreign key (CategoryId) REFERENCES Categories(Id)
)

create table Blogs_Tags(
BlogId INT,
TagId INT,
primary key (BlogId, TagId),
foreign key (BlogId) references Blogs(Id),
foreign key (TagId) references Tags(Id)
)

create table Comments(
Id  int primary key identity,
Content nvarchar(250) not null,
BlogId int,
UserId int,
Foreign key (UserId) references Users(Id),
Foreign key (BlogId) references Blogs(Id)
)


create view BlogView as
select b.Title as BlogTitle, u.UserName, u.FullName
from Blogs b
INNER JOIN Users u on b.UserId = u.Id;

create view BlogsCategories as
select b.Title as BlogTitle, c.Name as CategoryName
from Blogs b
INNER JOIN Categories c on b.CategoryId = c.Id;

select * from BlogsCategories ;

create procedure GetUserComments
@UserId int
As
Begin
select c.Id,c.Content,c.BlogId,c.UserId from Comments c
INNER JOIN Users u ON c.UserId = u.Id
where u.Id = @UserId;
End


Exec GetUserComments @UserId = 1
create procedure GetUserBlog
@UserId int
As
Begin
select b.Id,b.Title,b.Description,b.UserId,b.CategoryId from Blogs b
INNER JOIN Users u ON b.UserId = u.Id
where u.Id = @UserId;
End

Exec GetUserBlog @UserId = 1
