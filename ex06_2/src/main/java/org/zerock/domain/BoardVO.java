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
  
  //����� ���ڸ� �ǹ��ϴ� �ν��Ͻ� ���� �߰�
  private int replyCnt;
  
  //��� �� �ѹ��� BoardAttachVO ó��
  private List<BoardAttachVO> attachList;
}
