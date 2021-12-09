package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

	@Select("SELECT sysdate FROM dual")
	public String getTime();
	
	//SQL을 XML을 이용해서 처리할 때
	public String getTime2();
}
