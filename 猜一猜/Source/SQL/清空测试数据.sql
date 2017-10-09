delete from t_user_account_detail;
delete from t_user_account;
delete from t_tasks;
delete from t_task_pictures;
delete from t_task_orders;
delete from t_task_football;
delete from t_task_answers;
delete from t_sms_messages;
delete from t_recharges;
delete from t_payments;
delete from t_orders;
delete from t_messages;
delete from sys_log;
delete from m_users;
delete from t_operate_log;
delete from t_report;
delete from t_share_log;
delete from t_task_lottery_logs;

 insert into m_users(user_name,password,nickname,gender,phonenumber,user_type,create_by,is_delete)
 values('caiecai_main','test','小仙女',1,null,0,1,0);