package com.sbn.board.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sbn.board.dto.BoardDto;

@Mapper
public interface BoardMapper {

	List<BoardDto> getBoardList(HashMap<String, Object> map);

	int count(HashMap<String, Object> map);

	BoardDto getBoard(HashMap<String, Object> map);

	void setCountUpdate(HashMap<String, Object> map);

}
