-- 1.database create 
 CREATE DATABASE ibsdata DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
 CREATE TABLE IF NOT EXISTS `tb_stb_firmware` (
    `idx` INT(100) NOT NULL AUTO_INCREMENT,
    `firmware_version` VARCHAR(50) NOT NULL,
    `firmware_path` VARCHAR(50) NOT NULL,
    `firmware_modify_dt` DATETIME NOT NULL DEFAULT NOW(),
    PRIMARY KEY (`idx`)
)  ENGINE=MYISAM DEFAULT CHARSET=UTF8 AUTO_INCREMENT=1;
/*INSERT INTO `ibsdata`.`tb_stb_firmware` (`firmware_version`, `firmware_path`) VALUES ('1.0.18', 'stb_apk_Filedata_15212312350173795.apk');*/

CREATE TABLE IF NOT EXISTS `tb_stb_server` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`server_ip` varchar(50) NOT NULL,
	`server_modify_dt` datetime NOT NULL DEFAULT now(),
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
/*insert into tb_stb_server values(null,'192.168.0.75',now());
select * from tb_stb_server;*/


CREATE TABLE IF NOT EXISTS `tb_stb_logo` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`stb_group` int(100) NOT NULL,
    `logo_img_yn` varchar(1) NOT NULL,
    `logo_img_path` varchar(100) NULL,
    `logo_text` varchar(14) NULL,
	`logo_modify_dt` datetime NOT NULL DEFAULT now(),
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*insert into tb_stb_logo values(null,1,'Y','stb_logo_Filedata_14847299360284298.png','텍스트 로고',now());
select * from tb_stb_logo;*/


CREATE TABLE IF NOT EXISTS `tb_stb_bg` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`stb_group` int(100) NOT NULL,
    `bg_img_yn` varchar(1) NOT NULL,
    `bg_img_path` varchar(100) NULL,
    `bg_vod` varchar(100) NULL,
	`bg_modify_dt` datetime NOT NULL DEFAULT now(),
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*insert into tb_stb_bg values(null,1,'Y','stb_bg_Filedata_15132522237570797.jpg','',now());
select * from tb_stb_bg;*/


CREATE TABLE `tb_stb_vod_history` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`vod_idx` int(11) NOT NULL,
	`stb_idx` int(11) NOT NULL,
	`play_date` datetime NOT NULL DEFAULT now(),
	`play_time` time NOT NULL,
PRIMARY KEY (`idx`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*select * from tb_stb_vod_history;*/


create table `tb_stb` (
  `idx` int(11) not null auto_increment comment '장비id',
  `no` int(11) not null default '0' comment '단순 일련번호. 추가/삭제에 따라 동적으로 변함',
  `name` varchar(50) not null comment '장비명',
  `mac` varchar(20) not null comment 'mac address',
  `ip_addr` varchar(16) not null comment 'ip',
  `group_id` int(100) not null comment '소속그룹id',
  `status` varchar(10) not null default '2' comment '장비연결상태',
  `last_on_time` datetime not null comment '최종on시간',
  `last_ping_time` datetime not null default '1977-01-01 00:00:00' comment '최종 ping 받은 시간',
  `reg_dt` datetime not null,
  `note` varchar(256) default '',
  primary key (`idx`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='셋탑 장비 테이블';
/*select * from tb_stb;*/
insert into tb_stb values(null,0,'테스트 셋탑','00:11:6C:06:14:CF','192.168.0.132',1,'OFF','2017-11-21 16:57:44','2017-11-21 16:57:44','2017-11-21 16:57:44','테스트');
alter table tb_stb add category_idx varchar(100) not null default 0 ;

create table `tb_stb_group` (
  `idx` int(11) not null auto_increment comment '그룹 id',
  `pid` int(11) not null comment '상위그룹 id',
  `position` int(11) not null comment '그룹내에서의 순서',
  `name` varchar(50) not null comment '그룹명',
  primary key (`idx`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='stb 관리그룹.\r\n최상위에는 root그룹이 있으며 삭제할 수 없다.';
insert into tb_stb_group values(null,0,0,'ROOT');
/*select * from tb_stb_group;*/

create table `tb_vod_category` (
  `idx` int(11) not null auto_increment comment 'category id',
  `pid` int(11) not null comment 'category id',
  `position` int(11) not null comment 'category의 순서',
  `category_name` varchar(50) not null comment 'category명',
  primary key (`idx`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='vod category menu'; 
/*select * from tb_vod_category;*/


CREATE TABLE IF NOT EXISTS `tb_stb_banner` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`stb_group` int(100) NOT NULL,
    `banner_one_path` varchar(100) NOT NULL,
    `banner_two_path` varchar(100) NULL,
	`banner_modify_dt` datetime NOT NULL DEFAULT now(),
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
/*select * from tb_stb_banner;*/

CREATE TABLE IF NOT EXISTS `tb_thumbnail_repository` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`vod_idx` int(100) NOT NULL,
    `thumbnail_path` varchar(100) NOT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
/*select * from tb_thumbnail_repository;*/

CREATE TABLE IF NOT EXISTS tb_vod_repository (
	idx int(100) NOT NULL AUTO_INCREMENT,
    category_idx varchar(200) not null default 0,
	vod_path varchar(100) NOT NULL,
	vod_title varchar(100) NULL,
	vod_content varchar(100) NULL,
	vod_keyword varchar(200) NULL,
	vod_play_time varchar(20) NOT NULL DEFAULT '0000',
	main_thumbnail varchar(200) NULL,
	reg_dt datetime NOT NULL DEFAULT now(),
	reg_id varchar(50) NOT NULL,
	reg_ip varchar(50) NOT NULL,
	del_flag varchar(1) NOT  NULL DEFAULT 'N',
    trans_option varchar(100) NOT NULL DEFAULT '1024',
    edit_dt datetime NOT NULL DEFAULT now(),
    favorite_count int(100) not null default 0,
    view_count int(100) not null default 0,
    PRIMARY KEY (idx)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
drop table tb_vod_repository;
alter table tb_vod_repository add edit_dt datetime NOT NULL DEFAULT now() ;
alter table tb_vod_repository add favorite_count int(100) not null default 0;
alter table tb_vod_repository add main_thumbnail varchar(100) not null default 0 ;
alter table tb_vod_repository drop main_thumbnail ;
select * from tb_vod_repository;
ALTER TABLE tb_vod_box MODIFY resolution varchar(100) not null default '1920 x 1080';


CREATE TABLE IF NOT EXISTS tb_photo_repository (
	idx int(100) NOT NULL AUTO_INCREMENT,
    category_idx int(100) not null default 0,
	photo_path varchar(100) NOT NULL,
	photo_title varchar(100) NULL,
	photo_content text NULL,
	photo_keyword varchar(200) NULL,
	reg_dt datetime NOT NULL DEFAULT now(),
	reg_id varchar(50) NOT NULL,
	reg_ip varchar(50) NOT NULL,
	del_flag varchar(1) NOT  NULL DEFAULT 'N',
    edit_dt datetime NOT NULL DEFAULT now(),
    favorite_count int(100) not null default 0,
    view_count int(100) not null default 0,
    resolution	varchar(50) NOT NULL DEFAULT '1920-1080',
	file_size varchar(100) not null default '0',
    PRIMARY KEY (idx)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
drop table tb_photo_repository;


CREATE TABLE IF NOT EXISTS tb_file_repository (
	idx int(100) NOT NULL AUTO_INCREMENT,
    category_idx int(100) not null default 0,
	file_path varchar(100) NOT NULL,
	file_title varchar(100) NULL,
	file_keyword varchar(200) NULL,
	reg_dt datetime NOT NULL DEFAULT now(),
	reg_id varchar(50) NOT NULL,
	reg_ip varchar(50) NOT NULL,
	del_flag varchar(1) NOT  NULL DEFAULT 'N',
    edit_dt datetime NOT NULL DEFAULT now(),
    favorite_count int(100) not null default 0,
    view_count int(100) not null default 0,
    down_count int(100) not null default 0,
    resolution	varchar(50) NOT NULL DEFAULT '1920-1080',
	file_size varchar(100) not null default '0',
    PRIMARY KEY (idx)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
drop table tb_file_repository ;


CREATE TABLE IF NOT EXISTS tb_live_repository (
	idx int(100) NOT NULL AUTO_INCREMENT,
    category_idx int(100) not null default 0,
	live_path varchar(100) NOT NULL,
	live_title varchar(100) NULL,
	reg_dt datetime NOT NULL DEFAULT now(),
	reg_id varchar(50) NOT NULL,
	reg_ip varchar(50) NOT NULL,
	del_flag varchar(1) NOT  NULL DEFAULT 'N',
    edit_dt datetime NOT NULL DEFAULT now(),
    favorite_count int(100) not null default 0,
    view_count int(100) not null default 0,
    PRIMARY KEY (idx)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
select * from tb_live_repository;
drop table tb_live_repository;
INSERT INTO `ibsdata`.`tb_live_repository` (`category_idx`, `live_path`, `live_title`, `reg_id`, `reg_ip`, `del_flag`) VALUES ('11', 'http://192.168.0.75/live/stream.sdp/playlist.m3u8', '테스트 방송2', 'hanibal0717@gmail.com', '192.168.0.75', 'N');

CREATE TABLE IF NOT EXISTS tb_vod_box (
	idx int(100) NOT NULL AUTO_INCREMENT,
    repoIdx varchar(100) not null default '0',
	trans_status varchar(10) NOT NULL DEFAULT 'READY',
    trans_rate float NOT NULL DEFAULT 0.0,
	trans_start_dt datetime NOT NULL DEFAULT now(),
	trans_end_dt  datetime NOT NULL DEFAULT '1999-09-09 09:09:09',
	resolution	varchar(50) NOT NULL DEFAULT '1920*1080',
	audio_codec varchar(10) NOT NULL DEFAULT 'AAC',
	video_codec varchar(10) NOT NULL DEFAULT 'H.264',
	bitrate varchar(30) NOT NULL DEFAULT '3096000',
    file_size varchar(100) not null default '0',
	PRIMARY KEY (idx)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
select * from tb_vod_box;
/*'1','13','179_vod_Filedata_15280719257097401.mp4','첫번째영상 ','첫번째내용','첫영상,샘플영상','0000','1','2017-11-28 14:53:23','hanibal','192.168.0.75','N','1024','SUCCESS','1999-09-01 09:09:09','1999-09-01 09:09:09','none','none','none','none','0'*/

/*INSERT INTO `ibsdata`.`tb_vod_repository` 
(`vod_path`,`category_idx_list`, `vod_title`, `vod_content`, `vod_keyword`, `main_thumbnail`, `reg_id`, `reg_ip`) 
VALUES 
('179_vod_Filedata_15280719257097401.mp4','2', '첫번째영상 ', '첫번째내용', '첫영상,샘플영상', '1', 'hanibal', '192.168.0.75');
select * from tb_vod_repository;*/
/*select thumbnail_path from tb_thumbnail_repository where idx=1;

select
			(a.idx) as id,
			(a.vod_title) as title,
			(a.category_idx_list) as menu,
			(concat('/Users/hanibal/OXY_WORKSPACE/sednX/WebContent/REPOSITORY/','THUMBNAIL/',(select thumbnail_path from tb_thumbnail_repository where idx=a.main_thumbnail))) as thumbnail_path, 
			(concat('/Users/hanibal/OXY_WORKSPACE/sednX/WebContent/REPOSITORY/','THUMBNAIL/',a.vod_path)) as video_path,
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
select *from tb_channel_info;*/

CREATE TABLE IF NOT EXISTS `tb_stb_channel` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`ch_name` varchar(10) NOT NULL,
    `ch_img_path` varchar(100) NOT NULL,
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
/*select ch_name,ch_img_path from tb_stb_channel order by idx desc;*/

create table `tb_stb_schedule_group` (
  `schedule_id` int(11) default null comment '방송 스케줄 id',
  `group_id` int(11) default null comment '대상 그룹 id'
) engine=MyISAM default charset=utf8 comment='방송별 대상 그룹';


create table `tb_stb_schedule` (
  `id` int(11) not null auto_increment comment '스케줄 id',
  `name` varchar(200) default null comment '방송명',
  `start` datetime default null comment '시작시간',
  `end` datetime default null comment '종료시간',
  `target_type` varchar(10) default null comment '방송대상(all or group)',
  `source_type` varchar(10) default null comment '방송소스(vod or live)',
  `live_ch_idx` int(11) default null comment '라이브 방송인 경우 채널id',
  `live_stream_url` varchar(500) default null comment '라이브 스트림 url (live일 경우)',
  `caption` varchar(2000) default null comment '자막',
  `caption_size` int(11) default null,
  `caption_speed` int(11) default null,
  `caption_text_color` varchar(10) default null,
  `caption_bg_color` varchar(10) default null,
  `image_path` varchar(200) default null comment '방송 이미지',
  `color` varchar(10) default null comment '방송 색상',
  `desc_text` varchar(200) default null comment '방송 설명',
  primary key (`id`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='셋탑 방송 스케줄';
/*
INSERT INTO `ibsdata`.`tb_stb_schedule` (`id`, `name`, `start`, `end`, `target_type`, `source_type`, `live_stream_url`) VALUES (null, 'test2', '2017-11-22 01:00:00', '2017-12-10 07:30:00', 'GROUP', 'VOD', '');
*/
/*select * from tb_stb_schedule;
select * from tb_stb_schedule_group;
select * from tb_stb_group;
insert into tb_stb_schedule_group values(3,1);
update tb_stb_schedule_group set group_id=3 where schedule_id=1;
select id, name, concat(substring(time(start), 1, 5), ' ~ ', substring(time(end), 1, 5)) duration, target_type, image_path, desc_text
		from tb_stb_schedule a
		left outer join tb_stb_schedule_group b on a.id=b.SCHEDULE_ID
		where start > now() and dayofyear(start)=dayofyear(now()) and (target_type='ALL' or b.GROUP_ID=3) group by id order by start;

select B.name from tb_stb_schedule_group A, tb_stb_group B where A.group_id = B.idx and schedule_id=1;*/

select id, name, date(start) play_date, TIMEDIFF(end, start) play_time, concat(substring(time(start), 1, 5), ' ~ ', substring(time(end), 1, 5)) duration, hour(start) * 60 + minute(start) start, hour(end) * 60 + minute(end) end, target_type, image_path, desc_text, color 
		from tb_stb_schedule
        where source_type = 'LIVE' and live_ch_idx =3 and !((date(start) < date(now()) and date(end) < date(now())) or (date(start) > date(now()) and date(end) > date(now()))) order by start;
select * from tb_stb_schedule;
select * from tb_stb_channel;
select * from tb_stb_group;
select * from tb_stb_schedule_group;
insert into tb_stb_schedule_group values(4,3);
select timediff('2017-11-22 01:00:00',now());


select id, name, start, end, source_type, caption, caption_size, caption_speed, caption_text_color, caption_bg_color,live_stream_url from tb_stb_schedule A left join tb_stb_schedule_group B on A.ID = B.SCHEDULE_ID
                                    where (target_type = 'ALL' or (target_type = 'GROUP' and B.GROUP_ID = 3)) and end > now() group by id order by start;
select 
	a.vod_id, 
	file_path, 
	b.vod_play_time 
from 
	tb_stb_schedule_vod a, 
	tb_vod_data b,
	tb_attach_file c 
where a.vod_id = b.VOD_IDX 
and b.VOD_IDX = c.DATA_IDX 
and c.GUBUN='M' and c.trans = '00' 
and a.schedule_id=111
order by play_order;
select * from tb_vod_repository;
-- idx,vod_path,vod_play_time;
select
	(idx) as vod_id,
    (vod_path) as file_path,
    vod_play_time
from tb_stb_schedule_vod a
left join tb_vod_repository b on 	b.idx=a.vod_id
where trans_status='SUCCESS'
and a.schedule_id=1
order by a.play_order asc;
create table `tb_stb_schedule_vod` (
  `schedule_id` int(11) default null comment '방송 스케줄 id',
  `vod_id` int(11) default null comment '소스 vod id',
  `play_order` int(11) default null comment 'vod 재생 순서'
) engine=innodb default charset=utf8 comment='방송별 vod 소스 목록';

select * from tb_stb_schedule_vod;
insert into tb_stb_schedule_vod values(1,1,0);
insert into tb_stb_schedule_vod values(1,2,1);
insert into tb_stb_schedule_vod values(2,1,0);
insert into tb_stb_schedule_vod values(2,2,1);
insert into tb_stb_schedule_vod values(3,1,0);
insert into tb_stb_schedule_vod values(3,2,1);


select
			(a.vod_id) as vod_id,
    		(b.vod_path) as file_path,
    		(b.vod_play_time) as vod_play_time
		from 
			tb_stb_schedule_vod a
		left join 
			tb_vod_repository b on 	b.idx=a.vod_id
		where b.trans_status='SUCCESS'
		and a.schedule_id=1
		order by a.play_order asc;


CREATE TABLE IF NOT EXISTS `tb_account_member` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`member_id` varchar(50) NOT NULL,
	`member_pass` varchar(50) NOT NULL,
	`member_name` varchar(50) NOT NULL,
	`member_email` varchar(50) NOT NULL,
	`member_tempcode` varchar(50) NULL,
    `member_code_yn` varchar(1) NOT NULL DEFAULT 'N',
    `member_join_path` varchar(6) NOT NULL DEFAULT 'web',
    `member_join_dt` datetime NOT NULL DEFAULT now(),
	`member_last_dt` datetime NOT NULL DEFAULT now(),
	`member_authority` varchar(50) NOT NULL DEFAULT 0,
    `member_profile` varchar(50) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
drop table tb_account_member;

INSERT INTO `tb_account_member` (`idx`, `member_id`, `member_pass`, `member_name`,`member_email`,`member_tempcode`,`member_code_yn`,`member_authority`,`member_profile`) VALUES
(null, 'sednmanager', 'hanibal0717', '이누크리에이티브','hanibal@inucreative.com','','Y','10000','profile-pic.png');
select * from tb_account_member;
select count(member_email)from tb_account_member where member_email='hanibal@inucreative.com';
select count(idx) from tb_account_member where member_authority=0;

CREATE TABLE IF NOT EXISTS `tb_system_code` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`system_group` varchar(100) NOT NULL,
    `system_value` varchar(100) NOT NULL,
    `system_key` varchar(100) NULL,
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
drop table tb_system_code;
select * from tb_system_code;

/****************************************************************************
리눅스 폴더구조 계층형으로 구성 
*****************************************************************************/
create table cmsMenu
(
	idx int(11) not null auto_increment,
    directoryName varchar(100) character set utf8 not null,
    directoryIdx int(11) default 0,
    directoryStep int(11) default 0,
    diractoryLevel int(11) default 0,
    PRIMARY KEY (`idx`)
)ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8;
SELECT `cmsMenu`.`idx`,
    `cmsMenu`.`directoryName`,
    `cmsMenu`.`directoryLevel`,
    `cmsMenu`.`directoryStep`
FROM `fanz`.`cmsMenu`;
select * from cmsMenu order by directoryIdx desc ;
select * from cmsMenu order by directoryIdx asc,directoryStep desc,directoryLevel asc,idx asc;
select * from cmsMenu order by directoryIdx desc,directoryLevel asc,directoryStep asc,idx desc;
select * from cmsMenu;
select max(idx) from cmsMenu;
desc cmsMenu;
/****************************************************************************
리눅스 폴더구조 계층형으로 구성 
*****************************************************************************/
SELECT LAST_INSERT_ID();
create table `tb_photo_category` (
  `idx` int(11) not null auto_increment comment 'category id',
  `pid` int(11) not null comment 'category id',
  `position` int(11) not null comment 'category의 순서',
  `category_name` varchar(50) not null comment 'category명',
  primary key (`idx`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='photo category menu'; 
select * from tb_photo_category;
INSERT INTO `ibsdata`.`tb_photo_category` (`pid`, `position`, `category_name`) VALUES ('0', '0', 'PHOTO');


create table `tb_file_category` (
  `idx` int(11) not null auto_increment comment 'category id',
  `pid` int(11) not null comment 'category id',
  `position` int(11) not null comment 'category의 순서',
  `category_name` varchar(50) not null comment 'category명',
  primary key (`idx`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='file category menu'; 
select * from tb_file_category;
INSERT INTO `ibsdata`.`tb_file_category` (`pid`, `position`, `category_name`) VALUES ('0', '0', 'FILE');

create table `tb_live_category` (
  `idx` int(11) not null auto_increment comment 'category id',
  `pid` int(11) not null comment 'category id',
  `position` int(11) not null comment 'category의 순서',
  `category_name` varchar(50) not null comment 'category명',
  primary key (`idx`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='live category menu'; 
select * from tb_live_category;
INSERT INTO `ibsdata`.`tb_live_category` (`pid`, `position`, `category_name`) VALUES ('0', '0', 'LIVE');

create table `tb_board_category` (
  `idx` int(11) not null auto_increment comment 'category id',
  `pid` int(11) not null comment 'category id',
  `position` int(11) not null comment 'category의 순서',
  `category_name` varchar(50) not null comment 'category명',
  primary key (`idx`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='board category menu'; 
INSERT INTO `ibsdata`.`tb_board_category` (`pid`, `position`, `category_name`) VALUES ('0', '0', 'BOARD');


create table `tb_board_category` (
  `idx` int(11) not null auto_increment comment 'category id',
  `pid` int(11) not null comment 'category id',
  `position` int(11) not null comment 'category의 순서',
  `category_name` varchar(50) not null comment 'category명',
  primary key (`idx`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='board category menu'; 
INSERT INTO `ibsdata`.`tb_board_category` (`pid`, `position`, `category_name`) VALUES ('0', '0', 'BOARD');

create table `tb_stb_category` (
  `idx` int(11) not null auto_increment comment 'category id',
  `pid` int(11) not null comment 'category id',
  `position` int(11) not null comment 'category의 순서',
  `category_name` varchar(50) not null comment 'category명',
  primary key (`idx`)
) engine=MyISAM auto_increment=1 default charset=utf8 comment='STB category menu'; 
INSERT INTO `ibsdata`.`tb_stb_category` (`pid`, `position`, `category_name`) VALUES ('0', '0', 'STB');

CREATE TABLE IF NOT EXISTS tb_board_repository (
	idx int(100) NOT NULL AUTO_INCREMENT,
    category_idx varchar(100) not null default 0,
	vod_repo varchar(100) NOT NULL,
    photo_repo varchar(100) NOT NULL,
    file_repo varchar(100) NOT NULL,
    live_repo varchar(100) NOT NULL,
	board_title varchar(100) NULL,
	board_content mediumtext NULL,
	board_keyword varchar(500) NULL,
	reg_dt datetime NOT NULL DEFAULT now(),
	reg_id varchar(50) NOT NULL,
	reg_ip varchar(50) NOT NULL,
	del_flag varchar(1) NOT  NULL DEFAULT 'N',
    edit_dt datetime NOT NULL DEFAULT now(),
    favorite_count int(100) not null default 0,
    view_count int(100) not null default 0,
    PRIMARY KEY (idx)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
select * from  tb_board_repository ;
           
CREATE TABLE IF NOT EXISTS `tb_stb_log` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`category_idx` varchar(100) NOT NULL,
	`stb_idx` int(100) NOT NULL,
	`mac` varchar(20) NOT NULL,
	`reg_dt` datetime NOT NULL DEFAULT now(),
	`log` text NULL,
    `del_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;




CREATE TABLE IF NOT EXISTS `tb_carousel_img` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`img_name` varchar(100) NOT NULL,
	`img_title` varchar(100) NOT NULL,
	`img_url` varchar(200) NOT NULL,
	`reg_dt` datetime NOT NULL DEFAULT now(),
    `del_flag` varchar(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
select img_name,img_url from tb_carousel_img order by reg_dt desc;
insert into tb_carousel_img (img_name,img_title,img_url) value ('img_sample_01.png','테스트 케로셀','http://192.168.0.75:8080');
insert into tb_carousel_img (img_name,img_title,img_url) value ('img_sample_02.png','테스트 케로셀','http://192.168.0.75:8080');
insert into tb_carousel_img (img_name,img_title,img_url) value ('img_sample_03.png','테스트 케로셀','http://192.168.0.75:8080');



CREATE TABLE IF NOT EXISTS `tb_main_contents` (
	`idx` int(100) NOT NULL AUTO_INCREMENT,
	`category_idx` varchar(100) NOT NULL,
    `reg_dt` datetime NOT NULL DEFAULT now(),
  PRIMARY KEY (`idx`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
drop table tb_main_contents;
select * from tb_main_contents;
select (select category_name from tb_board_category where idx=a.category_idx) as category_idx from tb_main_contents a order by reg_dt desc ;






CREATE TABLE IF NOT EXISTS tb_sedn_log (
	idx int(100) NOT NULL AUTO_INCREMENT,
	device varchar(50) NOT NULL,
	reg_dt datetime NOT NULL DEFAULT now(),
	reg_id varchar(50) NOT NULL,
	reg_ip varchar(100) NOT NULL,
    PRIMARY KEY (idx)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;
drop table tb_sedn_log ;





CREATE TABLE IF NOT EXISTS tb_stb_command_log (
	idx int(100) NOT NULL AUTO_INCREMENT,
	mac varchar(100) NOT NULL,
    command_idx int(50) NOT NULL,
	reg_dt datetime NOT NULL DEFAULT now(),
	reg_ip varchar(100) NOT NULL,
    PRIMARY KEY (idx)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;




CREATE TABLE IF NOT EXISTS tb_stb_command(
	idx int(100) NOT NULL AUTO_INCREMENT,
	command varchar(300) NOT NULL,
    PRIMARY KEY (idx)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;


CREATE DEFINER=`root`@`%` FUNCTION `SPLIT_STR`(X VARCHAR(255), DELIM VARCHAR(12), POS INT) RETURNS varchar(255) CHARSET utf8
RETURN SUBSTRING_INDEX(SUBSTRING_INDEX(X, DELIM, POS), DELIM, -1);

INSERT INTO tb_system_code (system_group,system_value,system_key) VALUES('ottLog','1','스케줄과 셋팅을 다운로드 받았습니다.');
INSERT INTO tb_system_code (system_group,system_value,system_key) VALUES('ottLog','2','OTT 전원을 켰습니다.');
INSERT INTO tb_system_code (system_group,system_value,system_key) VALUES('ottLog','3','OTT 전원을 꼈습니다.');
INSERT INTO tb_system_code (system_group,system_value,system_key) VALUES('ottLog','4','OTT APP이 업데이되었습니다.');
INSERT INTO tb_system_code (system_group,system_value,system_key) VALUES('ottLog','5','VOD 플레이 했습니다.');
INSERT INTO tb_system_code (system_group,system_value,system_key) VALUES('ottLog','6','LIVE 플레이 했습니다.');

alter table tb_stb add category_idx varchar(100) not null default 0 ;
alter table tb_board_category add column property  varchar(100)  default 0;


