package com.sbn.league.dto;

public class LeagueDto {
	// Fields
	private	int    league_idx;
	private String league_name;
	private String league_location;
	private String league_content;
	public LeagueDto() {}
	public LeagueDto(int league_idx, String league_name, String league_location, String league_content) {
		this.league_idx = league_idx;
		this.league_name = league_name;
		this.league_location = league_location;
		this.league_content = league_content;
	}
	public int getLeague_idx() {
		return league_idx;
	}
	public void setLeague_idx(int league_idx) {
		this.league_idx = league_idx;
	}
	public String getLeague_name() {
		return league_name;
	}
	public void setLeague_name(String league_name) {
		this.league_name = league_name;
	}
	public String getLeague_location() {
		return league_location;
	}
	public void setLeague_location(String league_location) {
		this.league_location = league_location;
	}
	public String getLeague_content() {
		return league_content;
	}
	public void setLeague_content(String league_content) {
		this.league_content = league_content;
	}
	@Override
	public String toString() {
		return "LeagueDto [league_idx=" + league_idx + ", league_name=" + league_name + ", league_location="
				+ league_location + ", league_content=" + league_content + "]";
	}
	
}
