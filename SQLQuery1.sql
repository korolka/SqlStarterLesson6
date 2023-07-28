--�������� 1

--������� ���� ����� � ��'�� MyJoinsDB.
use MyJoinsDB

--�������� 2

--� ��� ����� MyJoinsDB, ������� 3 �������.

--� 1-� ������� ������ ����� �� ������ �������� ����������� ������.

--� 2-� ������� ������ ������� ��� ���� �������� �� ������: �������� ��������, ��������, �������.

--� 3-� ������� ������ ���������� ��� ������� ����, ���� ���������� ���� ����������.

select * from Personal
select * from PersonalOwnDetails
select * from PersonalWorkDetails
select * from Adress

--�������� 3

--������ ������ �� ��������� ��������� ������ ��� ����� �������:

--1) ������� �������� �������� ��� ����������� (������ ��������, ���� ����������).

select [name] ,(select city+' '+Street+' '+Building 
		from Adress
		where AdressId = ( select AdressId from PersonalOwnDetails 
							where Personalid = Personal.PersonalId)) as PlaceOfLiving ,PhoneNumber
from Personal

--2) ������� �������� ���������� ��� ���� ���������� ��� ����������� ����������� �� ������ �������� ��� ����������.

select (select [name]
		from Personal
		where PersonalId = PersonalOwnDetails.PersonalID) as [Name],(select PhoneNumber
		from Personal
		where PersonalId = PersonalOwnDetails.PersonalID) as PhoneNumber, BirthDate,MartialStatus 
from PersonalOwnDetails 
where MartialStatus = 'not married'

--3) ������� �������� ���������� ��� ���� ���������� ��� ����������� � ������� ��������� �� ������ �������� ��� �����������.
 
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
