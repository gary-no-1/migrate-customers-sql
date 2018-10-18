/*
psql -U username -d myDataBase -a -f myFile
*/
do $$
BEGIN
  /*
IF NOT EXISTS( SELECT 1 FROM information_schema.columns 
           WHERE table_name='res_partner' and column_name='id_8') THEN
*/

  --   alter table res_partner add column id_8 integer ;
  /*
END IF
*/

  /*
IF NOT EXISTS( SELECT 1 FROM information_schema.columns 
           WHERE table_name='res_partner' and column_name='id_10') THEN
*/
  --   alter table res_partner add column id_10 integer ;
  /*
END IF
*/

  --   alter table res_partner add column country character varying ;
  --   alter table res_partner add column state character varying ;
  --   alter table res_partner add column gst character varying(10) ;

  DROP table if exists res_partner_temp
  ;

  CREATE TABLE res_partner_temp
  (
    name character varying,
    company_id integer,
    comment text,
    -- Notes
    website character varying,
    -- Website
    create_date timestamp
    without time zone, -- Created on
  color integer, -- Color Index
  active boolean, -- Active
  street character varying, -- Street
  supplier boolean, -- Is a Vendor
  city character varying, -- City
  display_name character varying, -- Display Name
  zip character varying, -- Zip
  title integer, -- Title
  country_id integer, -- Country
  commercial_company_name character varying, -- Company Name Entity
  parent_id integer, -- Related Company
  company_name character varying, -- Company Name
  employee boolean, -- Employee
  ref character varying, -- Internal Reference
  email character varying, -- Email
  is_company boolean, -- Is a Company
  function character varying, -- Job Position
  lang character varying, -- Language
  fax character varying, -- Fax
  street2 character varying, -- Street2
  barcode character varying, -- Barcode
  phone character varying, -- Phone
  write_date timestamp without time zone, -- Last Updated on
  date date, -- Date
  tz character varying, -- Timezone
  write_uid integer, -- Last Updated by
  customer boolean, -- Is a Customer
  create_uid integer, -- Created by
  credit_limit double precision, -- Credit Limit
  user_id integer, -- Salesperson
  mobile character varying, -- Mobile
  type character varying, -- Address Type
  partner_share boolean, -- Share Partner
  vat character varying, -- TIN
  state_id integer, -- State
  commercial_partner_id integer, -- Commercial Entity
  message_last_post timestamp without time zone, -- Last Message Date
  opt_out boolean, -- Opt-Out
  message_bounce integer, -- Bounce
  signup_type character varying, -- Signup Token Type
  signup_expiration timestamp without time zone, -- Signup expiration
  signup_token character varying, -- Signup token
  picking_warn_msg text, -- Message for Stock Picking
  team_id integer, -- Sales Team
  calendar_last_notif_ack timestamp without time zone, -- Last notification marked as read from base Calendar
  debit_limit numeric, -- Payable Limit
  last_time_entries_checked timestamp without time zone, -- Latest Invoices & Payments Matching Date
  invoice_warn_msg text, -- Message for Invoice
  sale_warn_msg text, -- Message for Sales Order
  purchase_warn_msg text, -- Message for Purchase Order
  notify_email character varying , -- Email Messages and Notifications
  picking_warn character varying , -- Stock Picking
  invoice_warn character varying , -- Invoice
  sale_warn character varying , -- Sales Order
  purchase_warn character varying -- Purchase Order
)
    WITH
    (
  OIDS=FALSE
);
    ALTER TABLE res_partner_temp
  OWNER TO odoo;

  /*
create table res_partner_temp (like res_partner) ;
*/

  alter table res_partner_temp add column id_8 integer ;
  alter table res_partner_temp add column id_10 integer ;
  alter table res_partner_temp add column country character varying ;
  alter table res_partner_temp add column state character varying ;
  alter table res_partner_temp add column gst character varying ;


COPY res_partner_temp
  (name, company_id, active, city, commercial_partner_id, country_id, 
   create_date, create_uid, credit_limit, customer, DATE, debit_limit, display_name, email, 
   employee, fax, gst, is_company, lang, message_last_post, mobile, 
   notify_email, opt_out, parent_id, phone, ref, state_id, street, street2, supplier, 
   title, type, tz, user_id, vat, website, write_date, write_uid, zip, id_8, id_10,  country, state)
   from '/home/cjpl-admin/warehouse/res_partner.csv'
  with
  (FORMAT CSV , DELIMITER ';' , HEADER TRUE ) ;

  update res_partner_temp
set state_id = NULL
  ;

  update res_partner_temp
set state_id = b.id 
from res_country_state b 
where lower(res_partner_temp.state) = lower(b.name)
  ;

  update res_partner_temp
set country_id = b.id 
from res_country b 
where res_partner_temp.country = b.name
  ;

  insert into res_partner
    (name, company_id, active, city, country_id,
    create_date, credit_limit, customer, DATE, debit_limit, display_name, email,
    employee, fax, gst, is_company, lang, message_last_post, mobile,
    opt_out, parent_id, phone, ref, state_id, street, street2, supplier,
    type, tz, vat, website, write_date, zip, id_8, id_10, notify_email, picking_warn,
    invoice_warn, sale_warn, purchase_warn )
  select name, 1, active, city, country_id,
    create_date, credit_limit, customer, DATE, debit_limit, display_name, email,
    employee, fax, gst, is_company, lang, message_last_post, mobile,
    opt_out, parent_id, phone, ref, state_id, street, street2, supplier,
    type, tz, vat, website, write_date, zip, id_8, id_10, 'always', 'no-message',
    'no-message', 'no-message', 'no-message'
  from res_partner_temp
  ;
  END
$$