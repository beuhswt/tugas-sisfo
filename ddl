create database db_invoicing;
use db_invoicing;
create table invoice_data(
	invoice_id varchar (6) not null, 
	message varchar(20),
	description varchar(20),
	invoice_date date,
	primary key(invoice_id)
);
create table invoice_item_data(
	invoice_item_seq_id varchar (6) not null,
	product varchar(21),
	product_feature varchar(12),
	sold_with varchar(12) not null,
	quantity int,
	unit_price int not null,
	taxable_flag varchar(6) not null,
	primary key(invoice_item_seq_id),
	constraint fk1_invoicing foreign key(invoice_id) references invoice_item_data(invoice_id) on delete cascade
);

create table invoice_adjusment_data(
	invoice_item_type varchar(12) not null,
	amount int not null,
	taxable_flag varchar(6) not null,
	primary key (id_parkir),
	constraint fk1_invoicing foreign key(invoice_id) references invoice_item_data(invoice_id) on delete cascade,
	constraint fk1_invoicing foreign key(invoice_item_seq_id) references invoice_item_data(invoice_item_seq_id) on delete cascade
);

create table invoice_parties(
	invoice_date date, 
	billed_to_party varchar(20) not null,
	addressed_to_contact_mechanism varchar(20) not null,
	sender_of_party varchar(20) not null,
	sent_from_contact_mechanism varchar(20) not null,
	constraint fk1_invoicing foreign key(invoice_id) references invoice_item_data(invoice_id) on delete cascade,
);
create table billing_account_data(
	billing_account_id varchar(6) not null, 
	from_date date not null,
	thru_date date, 
	party varchar(20) not null,
	billing_account_role varchar(20) not null,
	mechanism varchar(20) not null,
	contact_description varchar(20) not null,
	billing_account_id (primary key),
);

create table billing_account_with_more_than_one_party(
	billing_account_role_from_date date not null, 
	billing_account_role_thru_date date,
	party varchar(20) not null,
	billing_account_role_type varchar(20) not null,
	constraint fk1_billing_account_id foreign key(billing_account_id) references billing_account_data(billing_account_id) on delete cascade,
);

create table invoice_status_data(
	status_type varchar(12) not null, 
	status_date date,
	constraint fk1_invoice_id foreign key(invoice_id) references invoice_data(invoice_id) on delete cascade,
);

create table invoice_term_data(
	term_type_description varchar(20) not null,
	term_value int,
	constraint fk1_billing_account_id foreign key(billing_account_id) references billing_account_data(billing_account_id) on delete cascade,
	constraint fk2_invoice_item_seq_id foreign key(invoice_item_seq_id) references invoice_item_data(invoice_item_seq_id) on delete cascade
);
create table shipment_invoice_data(
	shipment_id varchar(20) not null,
	item int,
	shipment_seq_id varchar(6) not null, 
	quantity int,
	shipment_id (primary key),
	constraint fk1_invoice_id foreign key(invoice_id) references invoice_data(invoice_id) on delete cascade,
	constraint fk2_invoice_item_seq_id foreign key(invoice_item_seq_id) references invoice_item_data(invoice_item_seq_id) on delete cascade
);
create table billing_for_order_item(
	purchase_order_id varchar(20) not null,
	orderr int,
	quantity int,
	unit_price int,
	invoice_item int,
	invoice_quantity int, 
	order_item_item_billing_quantity int, 
	purchase_order_id (primary key),
	constraint fk1_invoice_id foreign key(invoice_id) references invoice_data(invoice_id) on delete cascade,
	constraint fk2_invoice_item_seq_id foreign key(invoice_item_seq_id) references invoice_item_data(invoice_item_seq_id) on delete cascade
);


