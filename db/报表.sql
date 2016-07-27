drop view v_contract_bill_stat;

create view v_contract_bill_stat as
select
c.id,
c.contract_name,
o.management_type_code,
t.management_name,
CONVERT(varchar(100), c.contract_sign_time, 112) contract_sign_time,
b.bill_number,
b.bill_date,
c.record_account,
u.name user_name,
c.contract_subject,
s.subject_name,
c.customer_id,
m.customer_full_name,
c.contract_price,
b.bill_money,
b.gather_date,
b.gather_money,
b.bill_money-isnull(b.gather_money,0) bill_receivable,
c.contract_price-isnull(b.gather_money,0) contract__receivable,
c.c,
c.f
from crm_contract c
left join crm_commercial_opportunity o
on c.commercial_oppotunity_id=o.id
left join crm_customer m
on c.customer_id=m.id
left join 
(
	select 
	contract_id, 
	SUM(isnull(bill_money,0)) bill_money,
	SUM(isnull(gather_money,0)) gather_money,
	 STUFF(
     ( 
      SELECT ','+  CONVERT(varchar(100), a.gather_date, 112) FROM crm_bill a WHERE b.contract_id = a.contract_id FOR XML PATH('')
     ),1 ,1, '') gather_date,
	STUFF(
     ( 
      SELECT ','+ a.bill_number FROM crm_bill a WHERE b.contract_id = a.contract_id FOR XML PATH('')
     ),1 ,1, '') bill_number,
     STUFF(
     ( 
      SELECT ','+  CONVERT(varchar(100), a.bill_date, 112) FROM crm_bill a WHERE b.contract_id = a.contract_id FOR XML PATH('')
     ),1 ,1, '') bill_date 
	from
	crm_bill b group by contract_id
) b
on c.id=b.contract_id
left join dict_management_type t
on o.management_type_code = t.management_code
left join auth_user u
on c.record_account = u.account
left join dict_subject s
on c.contract_subject=s.subject_code;

select * from v_contract_bill_stat;

---------------------------------------------------------------------------

--收款日期、合同员（即合同录入人）、客户名称、合同主体、经营类型、是否要发票、累计开票金额、本次收款金额、C、F、开票信息界面的备注

drop view v_bill_detail;

create view v_bill_detail as
select 
b.id,
b.contract_id,
b.customer_id,
CONVERT(varchar(100), b.gather_date, 112) gather_date,
c.contract_name,
c.record_account,
u.name user_name,
m.customer_full_name,
c.contract_subject,
s.subject_name,
p.management_type_code,
t.management_name,
CONVERT(varchar(100), c.contract_sign_time, 112) contract_sign_time,
c.contract_price,
c.draw_bill,
bt.bill_money_total,
b.gather_money,
c.c,
c.f,
b.bill_receipt,
b.comment
from
(select * from crm_bill where gather_money>0) b
left join crm_contract c
on b.contract_id=c.id
left join auth_user u
on c.record_account = u.account
left join crm_commercial_opportunity p
on c.commercial_oppotunity_id = p.id
left join crm_customer m
on b.customer_id = m.id
left join dict_subject s
on c.contract_subject=s.subject_code
left join dict_management_type t
on p.management_type_code = t.management_code
left join
(
select contract_id,SUM(bill_money) bill_money_total from crm_bill group by contract_id
) bt
on b.contract_id=bt.contract_id;

select * from v_bill_detail;

------------------------------------------------------------

--经营类型、客户、合同主体、合同、合同日期、合同金额、本次开票日期、本次开票金额、本次回款日期、本次回款金额、发票签收已回、备注、合同是否结束。

drop view v_contract_bill_detail;

create view v_contract_bill_detail as
select 
b.id,
p.management_type_code,
t.management_name,
c.customer_id,
c.record_account,
u.name user_name,
m.customer_full_name,
c.contract_subject,
s.subject_name,
b.contract_id,
c.contract_name,
CONVERT(varchar(100), c.contract_sign_time, 112) contract_sign_time,
c.contract_price,
CONVERT(varchar(100), b.bill_date, 112) bill_date,
b.bill_money,
CONVERT(varchar(100), b.gather_date, 112) gather_date,
b.gather_money,
b.bill_receipt,
b.comment,
c.is_finished
from
crm_bill b
left join crm_contract c
on b.contract_id=c.id
left join auth_user u
on c.record_account = u.account
left join crm_commercial_opportunity p
on c.commercial_oppotunity_id = p.id
left join crm_customer m
on b.customer_id = m.id
left join dict_subject s
on c.contract_subject=s.subject_code
left join dict_management_type t
on p.management_type_code = t.management_code;

select * from v_contract_bill_detail;