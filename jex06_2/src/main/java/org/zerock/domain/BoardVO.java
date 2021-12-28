package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {

  private Long bno;
  private String title;
  private String content;
  private String writer;
  private Date regdate;
  private Date updateDate;
  
  //댓글의 숫자를 의미하는 인스턴스 변수 추가
  private int replyCnt;
  
  //등록 시 한번에 BoardAttachVO 처리
  private List<BoardAttachVO> attachList;
}
