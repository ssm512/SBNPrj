package com.sbn.member.dto;

import com.sbn.result.vo.HitterVo;
import com.sbn.result.vo.PitcherVo;

import lombok.Data;

@Data
public class MemberDto {

	private  int     member_idx;
	private  String  member_id;
	private  String  password;
	private  String  member_name;
	private  String  birth;
	private  String  email;
	private  String  phone_num;
	private  String  address;
	private  String  elite;
	private  String  use_hand;
	private  String  hope_position;
	private  String  member_regdate;
	private  String  is_admin;
	
	// join
	private  String  join_team_name;
	private  int     join_team_count;
	
	// 스탯 join
	private HitterVo  hitstats;
	private PitcherVo pitchstats; 
	
	// 사진
	private String    sfile_name;
	
}
