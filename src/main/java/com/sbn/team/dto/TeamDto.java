package com.sbn.team.dto;

import java.util.Date;

import lombok.Data;

@Data
public class TeamDto {
	
	// TEAM 테이블 칼럼 
	private int    team_idx;      // 팀 번호
	private String team_name;     // 팀 이름
	private int    team_manager;  // 감독 번호
	private String team_content;  // 팀소개
	private String team_location; // 연고지
	private Date   team_regdate;  // 창단일
	
	// JOIN 칼럼
	private String manager_name; // 감독 이름(MEMBER 테이블)
	private String league_name; // 리그 이름(LEAGUE 테이블)
	
	// 해당팀이 리그에 가입 된 수
	private int    join_league_count;
	
	// INFO 에 '선수단 수' 가 없어서 추가
	private int    member_count; // 선수단 수
	
	// MEMBER 테이블
	private String member_name;   // 이름
	private int    member_idx;    // IDX
	private String elite;         // 선출 여부
}
