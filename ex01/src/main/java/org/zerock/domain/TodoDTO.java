package org.zerock.domain;

import java.sql.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class TodoDTO {
	private String title;
	
	@DateTimeFormat(pattern="yyyy/MM/dd") //@InitBinder은 필요로 하지 않는다
	private Date dueDate;
}
