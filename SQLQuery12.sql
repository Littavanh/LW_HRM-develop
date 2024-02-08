/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *
  FROM [hrm_lw].[dbo].[tb_leaveRequest] where empID = 2654
   select * from [tb_leaveRequestDetail] where leaveRequestID = 41211
   delete from [tb_leaveRequestDetail] where leaveRequestID = 42252
   delete from [tb_leaveRequest] where leaveRequestID = 42252
  select empID,leaveTypeID,
 sum(amountDay) as leaveDay 
  from tb_leaveRequest where empID = 2654 and leaveTypeID <=2 and status_ID=3 group by leaveTypeID,empID

   select * from tb_leaveType where status_ID=3

  SELECT * FROM v_sumLeaveDayInYear where empID =2654 and leaveTypeID <=2 
    SELECT * FROM [v_emp_leave]


	  select empID,leaveTypeID,sum(amountDay) as dayUsed from v_emp_leave 
	  where empID = 2654 and leaveTypeID <=2 and status_ID = 3  group by leaveTypeID,empID
 SELECT *FROM tb_leaveRequest where empID = 2654 and transactionType = 1 and leaveTypeID <=2 

  SELECT a.empID,a.leaveTypeID ,c.leaveTypeName1,c.leaveTypeName2,sum(a.amountDay) as dayUsed,b.amountDay
FROM dbo.v_emp_leave as a left JOIN
   dbo.tb_leaveRequest as b ON a.empID = b.empID AND a.leaveTypeID = b.leaveTypeID
   join tb_leaveType as c  ON a.leaveTypeID = c.leaveTypeID
   where  a.empID =2654 and a.leaveTypeID <=2 and b.transactionType = 1 group by a.leaveTypeID,a.empID,b.amountDay,c.leaveTypeName1,c.leaveTypeName2
  
     SELECT * FROM v_leaveBalace  where empID =2654
   SELECT * FROM v_sumEmpLeaveName  where empID =2654
      SELECT * FROM v_sumEmpLeave where empID =2654
   SELECT    dbo.v_leaveBalace.empID, dbo.v_leaveBalace.empGroupID, COALESCE (dbo.v_leaveBalace.amountDay, 0) AS amountDay, COALESCE (iif(dbo.v_sumEmpLeave.sumDayUse < 0, 
                      dbo.v_sumEmpLeave.sumDayUse * (- 1), dbo.v_sumEmpLeave.sumDayUse), 0) AS sumDayUse, dbo.v_leaveBalace.leaveTypeCode, dbo.v_leaveBalace.leaveTypeName1, dbo.v_leaveBalace.leaveTypeName2, 
                      dbo.v_leaveBalace.leaveTypeID
FROM         dbo.v_sumEmpLeave RIGHT JOIN
dbo.v_leaveBalace ON dbo.v_sumEmpLeave.empID = dbo.v_leaveBalace.empID AND dbo.v_sumEmpLeave.leaveTypeID = dbo.v_leaveBalace.leaveTypeID


select a.leaveTypeID,a.leaveTypeName1,a.leaveTypeName2,b.amountDay
 from tb_leaveType as a left join tb_leaveRequest as b on a.leaveTypeID = b.leaveTypeID where a.leaveTypeID <=2 and b.empID = 2654 and b.transactionType =3


 SELECT    dbo.v_leaveBalace.empID, dbo.v_leaveBalace.empGroupID, COALESCE (dbo.v_leaveBalace.amountDay, 0) AS amountDay, COALESCE (iif(dbo.v_sumEmpLeave.sumDayUse < 0, 
                      dbo.v_sumEmpLeave.sumDayUse * (- 1), dbo.v_sumEmpLeave.sumDayUse), 0) AS sumDayUse, dbo.v_leaveBalace.leaveTypeCode, dbo.v_leaveBalace.leaveTypeName1, dbo.v_leaveBalace.leaveTypeName2, 
                      dbo.v_leaveBalace.leaveTypeID
FROM         dbo.v_sumEmpLeave RIGHT JOIN
                      dbo.v_leaveBalace ON dbo.v_sumEmpLeave.empID = dbo.v_leaveBalace.empID AND dbo.v_sumEmpLeave.leaveTypeID = dbo.v_leaveBalace.leaveTypeID

select * from tb_leaveRequest
  select a.empID,a.leaveTypeID,
 a.amountDay as leaveDay,b.TotalDay
  from tb_leaveRequest as a inner join v_sumLeaveDayInYear as b on a.empID = b.empID and a.leaveTypeID=b.leaveTypeID
   where  a.status_ID=3  and a.transactionType=1

   

    SELECT * FROM v_sumLeaveDayInYear where empID =2654 and leaveTypeID <=2 

	select * from tb_employees where empNo='LW/HQ-0081'
	select * from v_leaveBalanceAll where empID = 2654

