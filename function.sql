create or replace function fc_date_check(
  v_brd_reg_date date
)
return varchar2
is
  v_min number;
  v_result varchar2(20);
begin
  select FLOOR((sysdate - v_brd_reg_date) * 24 * 60 * 60)
  into v_min
  from dual;
  
  select case when v_min < 60 then '방금'
               when v_min >= 60 and v_min < 3600 then floor(v_min/60)||'분 전'
               when v_min >= 3600 and v_min < 86400 then floor(v_min/3600)||'시간 전'
               when v_min >= 86400 and v_min < 2419200 then floor(v_min/86400)||'일 전'
          else
               to_char(v_brd_reg_date,'YYYY/MM/DD')
          end as dt
  into v_result
  from dual;
  
  return v_result;
end;
/