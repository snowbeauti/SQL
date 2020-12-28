--삭제
drop table book;
drop table author;
drop SEQUENCE seq_book_id;
drop SEQUENCE seq_author_id;


--작가 테이블 생성
CREATE table author (
author_id number(10) not null PRIMARY KEY,
author_name varchar2(100),
author_desc varchar2(100)
);


--작가 시퀀스 생성
create SEQUENCE seq_author_id
INCREMENT by 1
start with 1;

--작가 테이블 입력
insert into author
values(seq_author_id.nextval, '김문열', '경북영양');

insert into author
values(seq_author_id.nextval, '박경리', '경상남도 통영');

insert into author
values(seq_author_id.nextval, '유시민', '17대 국회의원');

insert into author
values(seq_author_id.nextval, '기안84', '기안동에서 산 84년생');

insert into author
values(seq_author_id.nextval, '강풀', '온라인 만화가 1세대');

insert into author
values(seq_author_id.nextval, '김영하', '알쓸신잡');


--책 테이블 생성
create table book (
book_id number(10) not null,
title varchar2(100),
pubs varchar2(100),
pub_date date,
author_id number(10),
PRIMARY KEY (book_id),
CONSTRAINT book_fk FOREIGN KEY (author_id)
REFERENCES author(author_id)
);

--책 시퀀스 생성
create SEQUENCE seq_book_id
INCREMENT by 1
start with 1;

--책 테이블 입력
insert into book
values (seq_book_id.nextval, '우리들의 일그러진 영웅', '다림', '1998-02-22', 1);

insert into book
values (seq_book_id.nextval, '삼국지', '민듬사', '2002-03-01', 1);

insert into book
values (seq_book_id.nextval, '토지', '마로니에북스', '2012-08-15', 2);

insert into book
values (seq_book_id.nextval, '유시민의 글쓰기 특강', '생각의길', '2015-04-01', 3);

insert into book
values (seq_book_id.nextval, '패션왕', '중앙북스(books)', '2012-02-22', 4);

insert into book
values (seq_book_id.nextval, '순정만화', '재미주의', '2011-08-03', 5);

insert into book
values (seq_book_id.nextval, '오직두사람', '문학동네', '2017-05-04', 6);

insert into book
values (seq_book_id.nextval, '26년', '재미주의', '2012-02-04', 5);


--확인
SELECT
    *
FROM book;

SELECT
    *
FROM author;


--테이블 합치기
SELECT b.book_id,
       b.title,
       b.pubs,
       b.pub_date,
       a.author_id,
       a.author_name,
       a.author_desc
FROM book b, author a
where b.author_id = a.author_id; 

--오타수정
update author
set author_name = '이문열'
where author_name = '김문열';

--과제 1 수정
update author
set author_desc = '서울특별시'
where author_name = '강풀';

--과제2 불가능
DELETE from author
where author_name = '기안84';