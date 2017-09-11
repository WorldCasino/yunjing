DROP trigger if EXISTS ut_client_insert;  
/**

	新用户需要需要同时创建账户信息		 
 
 */
CREATE TRIGGER ut_client_insert after 
INSERT 
ON m_users FOR each row BEGIN 
		declare v_coin_balance int; 
		declare v_coin_income int; 
		declare v_activity_id int;
		declare v_account_id int;
			 
		-- 是否有新用户金币赠送活动 
		select return_value, 
		       return_value,
		       activity_id into v_coin_balance,v_coin_income, v_activity_id
		FROM   t_activitys 
		WHERE  activity_type = 0 
		AND    is_delete = 0 
		AND    validity_start <= current_timestamp 
		AND    validity_end > current_timestamp; 
		
		-- 插入用户账户表 
		insert INTO t_user_account 
            ( 
                        user_id, 
                        task_count, 
                        task_join , 
                        coin_balance, 
                        coin_income, 
                        coin_expend, 
                        coin_locked , 
                        recharge_amount, 
                        member_points , 
                        create_by, 
                        create_date, 
                        update_by, 
                        update_date, 
                        is_delete 
            ) 
            VALUES 
            ( 
                        new.user_id, 
                        0,
						0, 
                        v_coin_balance,  
                        v_coin_income, 
                        0, 
                        0, 
                        0,
						0, 
                        new.create_by, 
                        now(), 
                        new.create_by, 
                        now(), 
                        0 
            ); 

			-- 生成账户明细记录 
			if v_coin_balance > 0 then 
			
			  select account_id into v_account_id
			  FROM   t_user_account 
			  WHERE  user_id = new.user_id; 
			   
			  insert INTO t_user_account_detail 
			              ( 
			                          account_id , 
			                          user_id , 
			                          coins , 
			                          from_type , 
			                          task_id , 
			                          tord_id , 
			                          order_id , 
			                          recharge_id , 
			                          activity_id , 
			                          create_by , 
			                          create_date , 
			                          update_by , 
			                          update_date , 
			                          is_delete 
			              ) 
			              VALUES 
			              ( 
			                          v_account_id, 
			                          new.user_id, 
			                          v_coin_income, 
			                          7, 
			                          NULL, 
			                          NULL, 
			                          NULL, 
			                          NULL, 
			                          v_activity_id, 
			                          new.user_id, 
			                          now(), 
			                          new.user_id, 
			                          now(), 
			                          0 
			              );
			end if; 
END;