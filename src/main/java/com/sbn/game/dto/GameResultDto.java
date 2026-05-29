package com.sbn.game.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

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
	
}
