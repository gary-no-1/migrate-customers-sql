/*
psql -U username -d myDataBase -a -f myInsertFile
*/


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


do $$
BEGIN

   PERFORM
      f_add_col ('res_partner',
         'id_8',
         'int');
   PERFORM
      f_add_col ('res_partner',
         'id_10',
         'int');
   PERFORM
      f_add_col ('res_partner',
         'id_8_parent',
         'int');
   PERFORM
      f_add_col ('res_partner',
         'id_10_parent',
         'int');


/*
WITH cte AS (SELECT *, ROW_NUMBER() OVER() AS rn FROM res_partner)
UPDATE res_partner SET id_8 = (SELECT rn FROM cte WHERE cte.id = res_partner.id);
*/
-- set up id_8 as odoo 8 id for all customers
update res_partner set id_8 = id ;
-- set up id_8_parent for all children with their parent ids
update res_partner set id_8_parent = parent_id where parent_id is not null;

copy (SELECT a.name, a.company_id, a.active, a.city, a.commercial_partner_id, a.country_id, a.create_date, a.create_uid, a.credit_limit, a.
   customer, a.DATE, a.debit_limit, a.display_name, a.email, a.employee, a.fax, a.gst, a.is_company, a.lang, a.message_last_post, a.mobile, a.
   notify_email, a.opt_out, a.parent_id, a.phone, a.ref, a.state_id, a.street, a.street2, a.supplier, a.title, a.type, a.tz, a.user_id, a.
   vat, a.website, a.write_date, a.write_uid, a.zip, a.id_8, a.id_10, a.id_8_parent , a.id_10_parent, b.name as country, c.name as state,
   a.notify_email, d.name as title_name
   FROM res_partner a 
   left join res_country b
   on a.country_id = b.id
   left join res_country_state c
   on a.state_id = c.id 
   left join res_partner_title d
   on a.title = d.id
   where a.active order by a.name) 
   to '/home/rk/warehouse-migration/migrate-customers-sql/customer-data/res_partner.csv' 
   with (FORMAT CSV , DELIMITER ';' , HEADER TRUE , FORCE_QUOTE *) ;
END
$$ ;


