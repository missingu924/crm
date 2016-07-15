create view v_crm_contract as
select 
t1.*,
t2.bill_money_total,
t2.gather_money_total
from crm_contract t1
left join 
(
select
contract_id,SUM(isnull(bill_money,0)) bill_money_total,SUM(isnull(gather_money,0)) gather_money_total 
from crm_bill
group by
contract_id
) t2
on t1.id=t2.contract_id
