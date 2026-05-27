package com.sbn.member.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbn.member.dto.MemberDto;

@Mapper
public interface MemberMapper {

	MemberDto getMemberById(HashMap<String, Object> map);

	List<MemberDto> getMemberList(HashMap<String, Object> map);

	void insertMember(HashMap<String, Object> map);

	MemberDto getIdDupCheck(@Param("member_id") String member_id);


}
