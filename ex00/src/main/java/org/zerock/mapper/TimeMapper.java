package org.zerock.mapper;

import org.apache.ibatis.annotations.Select;

public interface TimeMapper {

	@Select("SELECT sysdate FROM dual")
	public String getTime();
	
	//SQL�� XML�� �̿��ؼ� ó���� ��
	public String getTime2();
}
