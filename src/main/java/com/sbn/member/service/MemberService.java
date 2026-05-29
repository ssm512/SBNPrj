package com.sbn.member.service;

import java.util.HashMap;
import java.util.List;

import com.sbn.member.dto.MemberDto;
import com.sbn.team.dto.TeamDto;

public interface MemberService {

	List<MemberDto> getMemberList(HashMap<String, Object> map);

	MemberDto login(HashMap<String, Object> map);
	
	void signin(HashMap<String, Object> map);

	List<TeamDto> getMyTeamList(int member_idx);

	MemberDto getIdDupCheck(String member_id);

	void updateMember(HashMap<String, Object> map);

	MemberDto getMemberById(HashMap<String, Object> map);

	MemberDto getPhoneDupCheck(String phone_num);

	MemberDto getEmailDupCheck(String email);

	MemberDto getMemberProfile(int member_idx);


}
