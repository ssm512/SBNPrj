package com.sbn.member.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sbn.member.dto.MemberDto;
import com.sbn.team.dto.TeamDto;

@Mapper
public interface MemberMapper {

	MemberDto getMemberById(HashMap<String, Object> map);

	List<MemberDto> getMemberList(HashMap<String, Object> map);

	void insertMember(HashMap<String, Object> map);

	List<TeamDto> getMyTeamList(int member_idx);


}
