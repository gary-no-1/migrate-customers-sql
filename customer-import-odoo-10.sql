 
 

DO $$
/*
psql -U username -d myDataBase -a -f myFile
 */
BEGIN
   SELECT
      f_add_col ('res_partner',
         'id_8',
         'int');
   SELECT
      f_add_col ('res_partner',
         'id_10',
         'int');
   SELECT
      f_add_col ('res_partner',
         'country',
         'character varying');
   SELECT
      f_add_col ('res_partner',
         'state',
         'character varying');
   SELECT
      f_add_col ('res_partner',
         'gst',
         'character varying');
   --   alter table res_partner add column id_8 integer ;
   --   alter table res_partner add column id_10 integer ;
   --   alter table res_partner add column country character varying ;
   --   alter table res_partner add column state character varying ;
   --   alter table res_partner add column gst character varying(10) ;
   DROP TABLE IF EXISTS res_partner_temp;
      CREATE TABLE res_partner_temp (
         name character varying,
         company_id integer,
         COMMENT text, -- Notes
         website character varying, -- Website
         create_date timestamp without time zone, -- Created on
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
         FUNCTION character varying, -- Job Position
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
         TYPE character varying, -- Address Type
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
         notify_email character varying, -- Email Messages and Notifications
         picking_warn character varying, -- Stock Picking
         invoice_warn character varying, -- Invoice
         sale_warn character varying, -- Sales Order
         purchase_warn character varying -- Purchase Order
) WITH (OIDS = FALSE);
      ALTER TABLE res_partner_temp OWNER TO odoo;
      ALTER TABLE res_partner_temp
         ADD COLUMN id_8 integer;
      ALTER TABLE res_partner_temp
         ADD COLUMN id_10 integer;
      ALTER TABLE res_partner_temp
         ADD COLUMN country character varying;
      ALTER TABLE res_partner_temp
         ADD COLUMN state character varying;
      ALTER TABLE res_partner_temp
         ADD COLUMN gst character varying;
      COPY res_partner_temp (name,
         company_id,
         active,
         city,
         commercial_partner_id,
         country_id,
         create_date,
         create_uid,
         credit_limit,
         customer,
         DATE,
         debit_limit,
         display_name,
         email,
         employee,
         fax,
         gst,
         is_company,
         lang,
         message_last_post,
         mobile,
         notify_email,
         opt_out,
         parent_id,
         phone,
         ref,
         state_id,
         street,
         street2,
         supplier,
         title,
         TYPE,
         tz,
         user_id,
         vat,
         website,
         write_date,
         write_uid,
         zip,
         id_8,
         id_10,
         country,
         state)
   FROM
      '/home/cjpl-admin/warehouse/res_partner.csv' WITH (
         FORMAT CSV,
         DELIMITER ';',
         HEADER TRUE
);
      UPDATE
         res_partner_temp
      SET
         state_id = NULL;
      UPDATE
         res_partner_temp
      SET
         state_id = b.id
      FROM
         res_country_state b
      WHERE
         lower(res_partner_temp.state) = lower(b.name);
      UPDATE
         res_partner_temp
      SET
         country_id = b.id
      FROM
         res_country b
      WHERE
         res_partner_temp.country = b.name;
      INSERT INTO res_partner (name, company_id, active, city, country_id, create_date, credit_limit, customer, DATE, debit_limit, display_name, email, employee, fax, gst, is_company, lang, message_last_post, mobile, opt_out, parent_id, phone, ref, state_id, street, street2, supplier, TYPE, tz, vat, website, write_date, zip, id_8, id_10, notify_email, picking_warn, invoice_warn, sale_warn, purchase_warn)
   SELECT
      name,
      1,
      active,
      city,
      country_id,
      create_date,
      credit_limit,
      customer,
      DATE,
      debit_limit,
      display_name,
      email,
      employee,
      fax,
      gst,
      is_company,
      lang,
      message_last_post,
      mobile,
      opt_out,
      parent_id,
      phone,
      ref,
      state_id,
      street,
      street2,
      supplier,
      TYPE,
      tz,
      vat,
      website,
      write_date,
      zip,
      id_8,
      id_10,
      'always',
      'no-message',
      'no-message',
      'no-message',
      'no-message'
   FROM
      res_partner_temp;

      update res_partner set id_10 = id ;

   DROP TABLE IF EXISTS res_partner_temp;

copy (SELECT a.name, a.id_8 , a.id_10
   FROM res_partner a ) 
   to '/home/cjpl-admin/warehouse/upd_res_partner_id8_id10.csv' 
   with (FORMAT CSV , DELIMITER ';' , HEADER TRUE , FORCE_QUOTE *) ;

      END $$;

CREATE OR REPLACE FUNCTION f_add_col (_tbl regclass, _col text, _type regtype)
   RETURNS bool
   AS $func$
BEGIN
-- https://stackoverflow.com/questions/12597465/how-to-add-column-if-not-exists-on-postgresql
   IF EXISTS (
         SELECT
            1
         FROM
            pg_attribute
         WHERE
            attrelid = _tbl AND attname = _col AND NOT attisdropped) THEN
         RETURN FALSE;
   ELSE
      EXECUTE format('ALTER TABLE %s ADD COLUMN %I %s', _tbl, _col, _type);
      RETURN TRUE;
   END IF;
END
$func$
LANGUAGE plpgsql;
