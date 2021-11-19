create table memo(
    idx int(11) not null auto_increment primary key,
    subject varchar(200) not null,
    memo text not null,
    regdate date not null,
    uidUsers tinytext

);