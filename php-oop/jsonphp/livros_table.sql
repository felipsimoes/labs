create database labjscript;
use labjscript;
create table livros (
  id int(2) not null,
  nome text,
  autor text,
  preco double(10,2),
  primary key (id)
)