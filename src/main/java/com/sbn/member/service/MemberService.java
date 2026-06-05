package com.sbn.member.service;

import java.util.HashMap;
import java.util.List;

import com.sbn.member.dto.MemberDto;
import com.sbn.member.dto.RankerDto;
import com.sbn.result.vo.HitterVo;
import com.sbn.result.vo.PitcherVo;
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

	int count(HashMap<String, Object> map);

	HitterVo getHitStats(HashMap<String, Object> statsMap);

	PitcherVo getPitchStats(HashMap<String, Object> statsMap);

	List<MemberDto> getMembersVo();

	RankerDto getRankerList(List<MemberDto> allMemberStats);

	HashMap<String, Object> getMemberFile(int member_idx);

	void updateMemberFile(HashMap<String, Object> fileMap);

	void insertMemberFile(HashMap<String, Object> fileMap);

	boolean changePassword(HashMap<String, Object> map);



}
