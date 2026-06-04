package com.sbn.member.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbn.member.dto.MemberDto;
import com.sbn.team.dto.TeamDto;

@Mapper
public interface MemberMapper {

	MemberDto getMemberById(HashMap<String, Object> map);

	List<MemberDto> getMemberList(HashMap<String, Object> map);

	void insertMember(HashMap<String, Object> map);

	List<TeamDto> getMyTeamList(int member_idx);

	MemberDto getIdDupCheck(@Param("member_id") String member_id);

	void updateMember(HashMap<String, Object> map);

	MemberDto getPhoneDupCheck(String phone_num);

	MemberDto getEmailDupCheck(String email);

	void updateElite(HashMap<String, Object> map);

	MemberDto getMemberProfile(int member_idx);

	int count(HashMap<String, Object> map);

	HashMap<String, Object> getHitStats(HashMap<String, Object> statsMap);

	HashMap<String, Object> getPitchStats(HashMap<String, Object> statsMap);

	HashMap<String, Object> getPitchRecord(HashMap<String, Object> statsMap);

	List<MemberDto> getAllMember();
	
	List<HashMap<String, Object>> getAllHitStats();
	List<HashMap<String, Object>> getAllPitchStats();
	List<HashMap<String, Object>> getAllPitchRecord();

	HashMap<String, Object> getMemberFile(int member_idx);

	void updateMemberFile(HashMap<String, Object> fileMap);

	void insertMemberFile(HashMap<String, Object> fileMap);


	void changePassword(HashMap<String, Object> map);




}
