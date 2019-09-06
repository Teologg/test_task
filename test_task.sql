CREATE TABLE Bills
( id    INT NOT NULL AUTO_INCREMENT,
  num   VARCHAR(150) NOT NULL,
  bdate DATETIME NOT NULL,
  pdate DATETIME,
  cid   INT NOT NULL,
  PRIMARY KEY (id)
); # Создание таблиц


CREATE TABLE Bill_content
(   bCid    INT  NOT NULL AUTO_INCREMENT,
    bID     INT,
    product     VARCHAR(150),
    tarif_name  VARCHAR(150),
    service_name VARCHAR(150),
    tip     INT,
    cost DECIMAL(5,2),
    payed DECIMAL(5,2),
    cnt INT,
    PRIMARY KEY (bCid)
);

CREATE TABLE retail_packs
(   prID    INT  NOT NULL AUTO_INCREMENT,
    bcID    INT,
    since   DATETIME,
    upto    DATETIME,
    PRIMARY KEY (prID)
);


INSERT INTO Bills (id, num, bdate, pdate, cid)
    VALUES (1, '123', '2019-9-5','2019-9-24', 11),
           (2, '124', '2019-9-5', '2019-9-24', 12);


INSERT INTO Bill_content (bCid, bID, product, tarif_name, service_name, tip, cost, payed, cnt)
    VALUES  (111, 1, 'Экстерн', 'Полный', 'Продление', 2, 100.00, 100.00, 1),
            (222, 2, 'Закупки', 'Пробный', 'Подключение', 1, 150.00, 140.00, 1);


INSERT INTO Bill_content (bCid, bID, product, tarif_name, service_name, tip, cost, payed, cnt)
    VALUES  (444, 1, 'Экстерн', 'Супер_Элитный', 'Продление', 2, 100.00, 100.00, 1);


INSERT INTO Bills (id, num, bdate, pdate, cid)
    values (3, '123', '2019-9-5','2019-9-24', 11);


insert into retail_packs (prID, bcID, since, upto)
    values (1111, 111, '2019-9-5', '2019-9-27');


insert into retail_packs (prID, bcID, since, upto)
    values (2222, 222, '2019-9-5', '2019-9-27'); # Создание таблиц

select
    b.*, bc.*
from
    Bills b, Bill_content bc
where
    b.id = bc.bid
    and bc.product = 'Экстерн'
brp as (
select
    b.cid, b.num, rp.upto, b.pdate
from
    b, retail_packs rp
where
    rp.bcid = b.bcid
    and sysdate() between rp.since and rp.upto
union all
select
    b.cid, b.num, b.pdate
from b
where
    not exists (select 1 from retail_packs rp where rp.bcid = b.bcid and sysdate() between rp.since and rp.upto)
    and b.tip in (1,2))

