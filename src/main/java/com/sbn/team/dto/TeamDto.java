package com.sbn.team.dto;

import java.util.Date;

import lombok.Data;

@Data
public class TeamDto {
	
	// TEAM 테이블 칼럼 
	private int    teamIdx;      // 팀 번호
	private String teamName;     // 팀 이름
	private int    teamManager;  // 감독 번호
	private String teamContent;  // 팀소개
	private String teamLocation; // 연고지
	private Date   teamRegdate;  // 창단일
	
	// JOIN 칼럼
	private String memberName; // 감독 이름(MEMBER 테이블)
	private String leagueName; // 리그 이름(LEAGUE 테이블) 
}
