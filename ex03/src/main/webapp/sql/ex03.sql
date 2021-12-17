create table tbl_reply (
    rno number(10,0),
    bno number(10, 0) not null,
    reply varchar2(1000) not null,
    replyer varchar2(50) not null,
    replyDate date default sysdate,
    updateDate date default sysdate
);
create sequence seq_reply;

alter table tbl_reply add constraint pk_reply primary key (rno);

alter table tbl_reply add constraint fk_reply_board
foreign key (bno) references tbl_board (bno);

select * from tbl_board;
select * from tbl_reply;

select * from tbl_reply order by rno desc;

--인덱스 생성
create index idx_reply on tbl_reply (bno desc, rno asc);

--특정 게시물의 rno의 순번대로 데이터를 조회
select /*+INDEX(tbl_reply idx_reply) */
    rownum rn, bno, rno, reply, replyer, replyDate, updateDate
    from tbl_reply
    where bno = 3145745 --(게시물 번호)
    and rno > 0

--10개씩 2페이지
select rno, bno, reply, replyer, replyDate, updateDate
from
    (
        select /*+INDEX(tbl_reply idx_reply) */
            rownum rn, bno, rno, reply, replyer, replyDate, updateDate
        from tbl_reply
        where bno = 게시물 번호
            and rno > 0
            and rownum <= 20
    ) where rn > 10
;