create database jota;
use jota;

create table produtos (
cod int,
descrição varchar(50),
quantidade int not null
);

insert into produtos values (01, 'arroz',20);
insert into produtos values (02, 'leite',23);
insert into produtos values (03, 'açucar',15);

create table prodvenda(
venda int,
produto int,
quant int
);
select * from produtos;
select * from prodvenda;

delimiter //
create trigger baixa_prod after insert on prodvenda for each row
begin
update produtos set quantidade = quantidade - new.quant
where cod = new.produto;
end // -- gatilho para dar baixa nos produtos apos a venda
delimiter ;

insert into prodvenda values (01, 02,15); -- venda realizada

delimiter // 
create trigger estorno after delete on prodvenda for each row
begin
update produtos set quantidade = quantidade + old.quant
where cod = old.produto;
end //
delimiter ; -- gatilho de cancelamento de vendas atraves de um delete na tabela vendas

delete from prodvenda where venda = 1;



