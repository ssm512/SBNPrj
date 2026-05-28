package com.sbn.team.dto;

import lombok.Data;

@Data
public class MemberTeamDto {
	private int     member_idx;
    private String  member_name;
    private String  position;
    private Integer back_num;
    private String  elite;
}