drop table news;
drop table sale_info;

create table news(
	news_id int not null auto_increment,
	headline varchar(50) not null,
    news_url varchar(256) not null,
    primary key(news_id)
)ENGINE = InnoDB;

create table sale_info(
	sale_id int not null auto_increment,
    sale_title varchar(50) not null,
    sale_start date,
    sale_end date,
    primary key(sale_id)
)ENGINE = InnoDB;