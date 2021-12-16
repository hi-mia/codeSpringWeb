package org.zerock.mapper;

import org.zerock.domain.ReplyVO;

public interface ReplyMapper {
	public int insert(ReplyVO vo);
	
	public ReplyVO read(Long rno); //특정 댓글 읽기
}
