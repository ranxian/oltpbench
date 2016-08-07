-- TODO: c_since ON UPDATE CURRENT_TIMESTAMP,

DROP TABLE IF EXISTS order_line;
CREATE TABLE order_line (
  ol_w_id int NOT NULL PRIMARY KEY,
  ol_d_id int NOT NULL PRIMARY KEY,
  ol_o_id int NOT NULL PRIMARY KEY,
  ol_number int NOT NULL PRIMARY KEY,
  ol_i_id int NOT NULL,
  ol_delivery_d timestamp,
--  ol_delivery_d timestamp NULL DEFAULT NULL,
  ol_amount decimal NOT NULL,
  ol_supply_w_id int NOT NULL,
  ol_quantity decimal NOT NULL,
  ol_dist_info char(24) NOT NULL
);

DROP TABLE IF EXISTS new_order;
CREATE TABLE new_order (
  no_w_id int NOT NULL PRIMARY KEY,
  no_d_id int NOT NULL PRIMARY KEY,
  no_o_id int NOT NULL PRIMARY KEY
);

DROP TABLE IF EXISTS stock;
CREATE TABLE stock (
  s_w_id int NOT NULL PRIMARY KEY,
  s_i_id int NOT NULL PRIMARY KEY,
  s_quantity decimal NOT NULL,
  s_ytd decimal NOT NULL,
  s_order_cnt int NOT NULL,
  s_remote_cnt int NOT NULL,
  s_data varchar(50) NOT NULL,
  s_dist_01 char(24) NOT NULL,
  s_dist_02 char(24) NOT NULL,
  s_dist_03 char(24) NOT NULL,
  s_dist_04 char(24) NOT NULL,
  s_dist_05 char(24) NOT NULL,
  s_dist_06 char(24) NOT NULL,
  s_dist_07 char(24) NOT NULL,
  s_dist_08 char(24) NOT NULL,
  s_dist_09 char(24) NOT NULL,
  s_dist_10 char(24) NOT NULL
);

-- TODO: o_entry_d  ON UPDATE CURRENT_TIMESTAMP
DROP TABLE IF EXISTS oorder;
CREATE TABLE oorder (
  o_w_id int NOT NULL PRIMARY KEY UNIQUE,
  o_d_id int NOT NULL PRIMARY KEY UNIQUE,
  o_id int NOT NULL PRIMARY KEY UNIQUE,
  o_c_id int NOT NULL UNIQUE,
  o_carrier_id int,
  o_ol_cnt decimal NOT NULL,
  o_all_local decimal NOT NULL,
  o_entry_d timestamp NOT NULL
);

-- TODO: h_date ON UPDATE CURRENT_TIMESTAMP
DROP TABLE IF EXISTS history;
CREATE TABLE history (
  h_c_id int NOT NULL,
  h_c_d_id int NOT NULL,
  h_c_w_id int NOT NULL,
  h_d_id int NOT NULL,
  h_w_id int NOT NULL,
  h_date timestamp NOT NULL,
  h_amount decimal NOT NULL,
  h_data varchar(24) NOT NULL
);

DROP TABLE IF EXISTS customer;
CREATE TABLE customer (
  c_w_id int NOT NULL PRIMARY KEY,
  c_d_id int NOT NULL PRIMARY KEY,
  c_id int NOT NULL PRIMARY KEY,
  c_discount decimal NOT NULL,
  c_credit char(2) NOT NULL,
  c_last varchar(16) NOT NULL,
  c_first varchar(16) NOT NULL,
  c_credit_lim decimal NOT NULL,
  c_balance decimal NOT NULL,
  c_ytd_payment float NOT NULL,
  c_payment_cnt int NOT NULL,
  c_delivery_cnt int NOT NULL,
  c_street_1 varchar(20) NOT NULL,
  c_street_2 varchar(20) NOT NULL,
  c_city varchar(20) NOT NULL,
  c_state char(2) NOT NULL,
  c_zip char(9) NOT NULL,
  c_phone char(16) NOT NULL,
  c_since timestamp NOT NULL,
  c_middle char(2) NOT NULL,
  c_data varchar(500) NOT NULL
);

DROP TABLE IF EXISTS district;
CREATE TABLE district (
  d_w_id int NOT NULL PRIMARY KEY,
  d_id int NOT NULL PRIMARY KEY,
  d_ytd decimal NOT NULL,
  d_tax decimal NOT NULL,
  d_next_o_id int NOT NULL,
  d_name varchar(10) NOT NULL,
  d_street_1 varchar(20) NOT NULL,
  d_street_2 varchar(20) NOT NULL,
  d_city varchar(20) NOT NULL,
  d_state char(2) NOT NULL,
  d_zip char(9) NOT NULL
);


DROP TABLE IF EXISTS item;
CREATE TABLE item (
  i_id int NOT NULL PRIMARY KEY,
  i_name varchar(24) NOT NULL,
  i_price decimal NOT NULL,
  i_data varchar(50) NOT NULL,
  i_im_id int NOT NULL
);

DROP TABLE IF EXISTS warehouse;
CREATE TABLE warehouse (
  w_id int NOT NULL PRIMARY KEY,
  w_ytd decimal NOT NULL,
  w_tax decimal NOT NULL,
  w_name varchar(10) NOT NULL,
  w_street_1 varchar(20) NOT NULL,
  w_street_2 varchar(20) NOT NULL,
  w_city varchar(20) NOT NULL,
  w_state char(2) NOT NULL,
  w_zip char(9) NOT NULL
);


--add constraints and indexes
-- CREATE INDEX IDX_CUSTOMER_NAME ON customer (c_w_id,c_d_id,c_last,c_first);
CREATE INDEX IDX_ORDER ON OORDER (O_W_ID,O_D_ID,O_C_ID,O_ID);
-- tpcc-mysql create two indexes for the foreign key constraints, Is it really necessary?
-- CREATE INDEX FKEY_STOCK_2 ON STOCK (S_I_ID);
-- CREATE INDEX FKEY_ORDER_LINE_2 ON ORDER_LINE (OL_SUPPLY_W_ID,OL_I_ID);

--add 'ON DELETE CASCADE'  to clear table work correctly

-- ALTER TABLE DISTRICT  ADD CONSTRAINT FKEY_DISTRICT_1 FOREIGN KEY(D_W_ID) REFERENCES WAREHOUSE(W_ID) ON DELETE CASCADE;
-- ALTER TABLE CUSTOMER ADD CONSTRAINT FKEY_CUSTOMER_1 FOREIGN KEY(C_W_ID,C_D_ID) REFERENCES DISTRICT(D_W_ID,D_ID)  ON DELETE CASCADE ;
-- ALTER TABLE HISTORY  ADD CONSTRAINT FKEY_HISTORY_1 FOREIGN KEY(H_C_W_ID,H_C_D_ID,H_C_ID) REFERENCES CUSTOMER(C_W_ID,C_D_ID,C_ID) ON DELETE CASCADE;
-- ALTER TABLE HISTORY  ADD CONSTRAINT FKEY_HISTORY_2 FOREIGN KEY(H_W_ID,H_D_ID) REFERENCES DISTRICT(D_W_ID,D_ID) ON DELETE CASCADE;
-- ALTER TABLE NEW_ORDER ADD CONSTRAINT FKEY_NEW_ORDER_1 FOREIGN KEY(NO_W_ID,NO_D_ID,NO_O_ID) REFERENCES OORDER(O_W_ID,O_D_ID,O_ID) ON DELETE CASCADE;
-- ALTER TABLE OORDER ADD CONSTRAINT FKEY_ORDER_1 FOREIGN KEY(O_W_ID,O_D_ID,O_C_ID) REFERENCES CUSTOMER(C_W_ID,C_D_ID,C_ID) ON DELETE CASCADE;
-- ALTER TABLE ORDER_LINE ADD CONSTRAINT FKEY_ORDER_LINE_1 FOREIGN KEY(OL_W_ID,OL_D_ID,OL_O_ID) REFERENCES OORDER(O_W_ID,O_D_ID,O_ID) ON DELETE CASCADE;
-- ALTER TABLE ORDER_LINE ADD CONSTRAINT FKEY_ORDER_LINE_2 FOREIGN KEY(OL_SUPPLY_W_ID,OL_I_ID) REFERENCES STOCK(S_W_ID,S_I_ID) ON DELETE CASCADE;
-- ALTER TABLE STOCK ADD CONSTRAINT FKEY_STOCK_1 FOREIGN KEY(S_W_ID) REFERENCES WAREHOUSE(W_ID) ON DELETE CASCADE;
-- ALTER TABLE STOCK ADD CONSTRAINT FKEY_STOCK_2 FOREIGN KEY(S_I_ID) REFERENCES ITEM(I_ID) ON DELETE CASCADE;

