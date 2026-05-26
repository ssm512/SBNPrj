package com.sbn.game.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class GameDto {
	// Game 자료
	private	int		game_idx;
	private	int		league_idx;
	private	int		away_idx;
	private int		home_idx;
	private	String	game_date;
	private	String	game_time;
	private	String	game_field;
	private	int		game_status;
	private	int		winner;
	private	String	win_pitcher;
	private	String	lose_pitcher;
	private	String	save_pitcher;
	private	String	hold_pitcher;
}
