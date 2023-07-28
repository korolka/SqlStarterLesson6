--Завдання 1

--Створіть базу даних з ім'ям MyJoinsDB.
use MyJoinsDB

--Завдання 2

--У базі даних MyJoinsDB, створіть 3 таблиці.

--У 1-й таблиці вкажіть імена та номери телефонів співробітників компанії.

--У 2-й таблиці вкажіть відомості про їхню зарплату та посади: головний директор, менеджер, робітник.

--У 3-й таблиці вкажіть інформацію про сімейний стан, дату народження місця проживання.

select * from Personal
select * from PersonalOwnDetails
select * from PersonalWorkDetails
select * from Adress

--Завдання 3

--Зробіть вибірку за допомогою вкладених запитів для таких завдань:

--1) Потрібно дізнатися контактні дані співробітників (номери телефонів, місце проживання).

select [name] ,(select city+' '+Street+' '+Building 
		from Adress
		where AdressId = ( select AdressId from PersonalOwnDetails 
							where Personalid = Personal.PersonalId)) as PlaceOfLiving ,PhoneNumber
from Personal

--2) Потрібно дізнатися інформацію про дату народження всіх неодружених співробітників та номери телефонів цих працівників.

select (select [name]
		from Personal
		where PersonalId = PersonalOwnDetails.PersonalID) as [Name],(select PhoneNumber
		from Personal
		where PersonalId = PersonalOwnDetails.PersonalID) as PhoneNumber, BirthDate,MartialStatus 
from PersonalOwnDetails 
where MartialStatus = 'not married'

--3) Потрібно дізнатися інформацію про дату народження всіх співробітників з посадою менеджера та номери телефонів цих співробітників.
 
 select  
		(select Position 
		from PersonalWorkDetails
		where Position = 'manager' and PersonalId =(select PersonalID 
													from Personal
													where PersonalId = PersonalOwnDetails.PersonalID)),BirthDate 
 from PersonalOwnDetails 

 select position,(select [Name] 
					from Personal
					where PersonalId = PersonalWorkDetails.PersonalId) as [Name],
				(select PhoneNumber 
					from Personal
					where PersonalId = PersonalWorkDetails.PersonalId) as phoneNumber,	
				(select BirthDate
					from PersonalOwnDetails
					where PersonalId = PersonalWorkDetails.PersonalId) as BirthDate
 from PersonalWorkDetails
 where Position = 'manager'
