insert into tbl_board (bno, title, content, writer)
(select seq_board.nextval, title, content, writer from tbl_board);

select * from tbl_board order by bno desc; -- 15초
select * from tbl_board order by bno desc; --0.12초

--order by 보다는 인덱스
select 
    /* +INDEX_DESC(tbl_board pk_board)*/
    *
    from tbl_board
    where bno>0;
    
--FULL 힌트
select /*+ FULL(tbl_board) */ * from tbl_board order by bno desc;

--INDEX_ASC, INDEX_DESC 힌트
select /*+ INDEX_ASC(tbl_board pk_board) */ * from tbl_board where bno > 0;
 
--인덱스를 이용한 접근 시 ROWNUM    
select /*+ INDEX_ASC(tbl_board pk_board) */
    rownum rn, bno, title, content
from tbl_board;

select
/*+ INDEX_DESC(tbl_board pk_board) */
rownum rn, bno, title, content
from tbl_board
where bno > 0;

--1페이지 데이터
select /*+ INDEX_DESC(tbl_board pk_board) */
    rownum rn, bno, title, content
from
    tbl_board
where rownum <= 10;

--2페이지 데이터
select /*+ INDEX_DESC(tbl_board pk_board) */
    rownum rn, bno, title, content
from
    tbl_board
where rownum > 10 and rownum <= 20; --아무 결과가 나오지 않는다

select /*+ INDEX_DESC(tbl_board pk_board) */
    rownum rn, bno, title, content
from
    tbl_board
where rownum <= 20; --반드시 1이 포함되도록 해야 한다

--인라인뷰를 적용한 2페이지의 데이터 처리
select
    bno, title, content
from
    (
    select /*+ INDEX_DESC(tbl_board pk_board) */
        rownum rn, bno, title, content
    from
        tbl_board
    where rownum <= 20
    )
where rn > 10;