package com.sbn.game.dto;

import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GameResultDto {
	
	private int		record_num;
	private int		game_idx;
	private int		inning;
	private String	top_bottom;
	private int		hitter_num;
	private	String	hitter_name;
	private	String	hitter_id;
	private	String	pitcher_name;
	private	String	pitcher_id;
	private	String	result;
	private	int		get_score;
	private	int		era;
	private	String	content;
	
	// 화면 이동용
	private	int		league_idx;
	
	// gameresult 여러줄 입력용
	@ToString.Exclude
	private	ArrayList<GameResultDto> resultList;
}
