package com.sbn.member.mapper;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.sbn.member.dto.MemberDto;

@Mapper
public interface MemberMapper {

	MemberDto getLogin(HashMap<String, Object> map);

	List<MemberDto> getMemberList(HashMap<String, Object> map);

}
