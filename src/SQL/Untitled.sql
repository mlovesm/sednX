select 
			idx,
			member_id,
			member_pass,
			member_name,
			member_email,
			member_tempcode,
			member_code_yn,
			member_join_path,
			member_join_dt,
			member_last_dt,
			member_authority
		from
			tb_account_member;
            
            
            
            select
			idx,
			member_id,
			member_pass,
			member_name,
			member_email,
			member_tempcode,
			member_code_yn,
			member_join_path,
			member_join_dt,
			date_format(member_last_dt,'%Y년 %m월 %d일 %H시 %s초') as member_last_dt,
			member_authority,
			member_profile
		from tb_account_member where 1=1;
        
        
        
select
			(a.idx) as id,
			(a.vod_title) as title,
			(a.category_idx_list) as menu,
			(concat("THUMBNAIL/",(select thumbnail_path from tb_thumbnail_repository where idx=a.main_thumbnail))) as thumbnail_path, 
			(concat("VOD/",a.vod_path)) as video_path,
			(a.reg_dt) as register_dt,
			(a.vod_play_time) as vod_play_time,
   			(a.resolution) as resolution,
   			(a.bitrate) as bitrate,
   			(video_codec) as video_codec,
   			(audio_codec) as audio_codec,
   			(select count(*) as hit from tb_stb_vod_history where vod_idx =a.idx) as hit 
		from 
			tb_vod_repository a
		order by a.idx desc;
        
        
select * from tb_vod_repository;

select category_name from tb_vod_category where idx=1;

select * from tb_vod_category where pid=1;
select idx,category_name from tb_live_category where pid=1 order by idx asc
