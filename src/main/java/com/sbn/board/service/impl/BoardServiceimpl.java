package com.sbn.board.service.impl;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.util.HtmlUtils;

import com.sbn.board.dto.BoardDto;
import com.sbn.board.mapper.BoardMapper;
import com.sbn.board.service.BoardService;
import com.sbn.member.dto.MemberDto;

@Service
public class BoardServiceimpl implements BoardService {
	
	@Autowired
	private BoardMapper boardMapper;

	@Override
	public List<BoardDto> getBoardList(HashMap<String, Object> map) {
		
		// "/Board/List?nowpage=1&keyword="
		
		// 컨트롤러에서 map을 생성하지 않고 null 로 보냈을 때를 대비한 방어 코드
		if (map == null) {
			map = new HashMap<>();
		}
		
		// map 에 offset 정보가 없거나 null 이면 기본값 0 세팅
		if (!map.containsKey("offset") || map.get("offset") == null) {
			map.put("offset", 0);
		}
		
		// map 에 numOfRows 정보가 없거나 null 이면 기본값 10 세팅(페이지당 10개씩 노출)
		if (!map.containsKey("numOfRows") || map.get("numOfRows") == null) {
			map.put("numOfRows", 10);
		}
		
		List<BoardDto> boardList = boardMapper.getBoardList( map );
		
		return boardList;
	}

	@Override
	public int count(HashMap<String, Object> map) {
		// 만약 컨트롤러에서 map 을 생성하지 않고 null 을 보냈을때 대비
		if (map == null) {
			map = new HashMap<>();
		}
		return boardMapper.count(map);
	}

	@Override
	public BoardDto getBoard(HashMap<String, Object> map) {
		return boardMapper.getBoard(map);
	}

	@Override
	public void setCountUpdate(HashMap<String, Object> map) {
		boardMapper.setCountUpdate(map);
	}

	@Override
	public void writeBoard(HashMap<String, Object> map) {
		boardMapper.writeBoard(map);
	}

	@Override
	public void updateBoard(HashMap<String, Object> map) {
		boardMapper.updateBoard(map);
	}

	@Override
	public void deleteBoard(HashMap<String, Object> map) {
		boardMapper.deleteBoard(map);
	}

	@Override
	public int getMemberIdx(HashMap<String, Object> map) {
		return boardMapper.getMemberIdx(map);
	}

	
}
