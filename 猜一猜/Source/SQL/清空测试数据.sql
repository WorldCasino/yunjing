truncate table t_user_account_detail;
truncate table t_user_account;
truncate table t_tasks;
truncate table t_task_pictures;
truncate table t_task_orders;
truncate table t_task_football;
truncate table t_task_answers;
truncate table t_sms_messages;
truncate table t_recharges;
truncate table t_payments;
truncate table t_orders;
truncate table t_messages;
truncate table sys_log;
truncate table m_users;

 insert into m_users(user_name,password,nickname,gender,phonenumber,user_type,is_locked,create_by,is_delete)
 values('caiecai_main','test','猜一猜官方',1,null,0,0,1,0);