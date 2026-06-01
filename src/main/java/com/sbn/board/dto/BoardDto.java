package com.sbn.board.dto;

import lombok.Data;

@Data
public class BoardDto {
	// Fields
	public int    board_idx;
	public String writer;
	public String title;
	public String content;
	public int    hit;
	public String regdate;
	public String board_type;
}
