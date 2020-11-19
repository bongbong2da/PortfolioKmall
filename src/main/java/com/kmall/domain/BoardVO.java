package com.kmall.domain;

import java.sql.Date;
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class BoardVO {
	private int board_idx;
	private String mem_id;
	private String board_title;
	private String board_content;
	private String board_ip;
	private LocalDateTime board_regdate;
}
