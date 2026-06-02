package com.sbn.member.dto;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;

@Data
@AllArgsConstructor
public class RankerDto {

	private  List<MemberDto>  avgRanker;
	private  List<MemberDto>  homeRunRanker;
	private  List<MemberDto>  getScoreRanker;
	private  List<MemberDto>  hitRanker;
	
	private  List<MemberDto>  eraRanker;
	private  List<MemberDto>  winRanker;
	private  List<MemberDto>  strikeOutRanker;
	private  List<MemberDto>  inningRanker;
	
}
