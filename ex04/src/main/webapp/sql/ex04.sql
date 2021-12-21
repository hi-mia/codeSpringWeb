alter table tbl_board add (replycnt number default 0); -- 댓글수 칼럼 추가
update tbl_board set replycnt = (select count(rno) from tbl_reply
where tbl_reply.bno = tbl_board.bno); --기존 댓글 replycnt에 업데이트

--테이블 용량 줄이기..
drop table tbl_reply;
drop table tbl_board cascade CONSTRAINTS;

select * from dba_temp_files;
select * from user_users;

alter tablespace USERS add DATAFILE 'stock4.dbf' SIZE 10M;