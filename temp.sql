INSERT INTO studies
,(
,    id
,    ,name_string
,    ,description
,    ,field
,    ,is_active
,    ,register_start
,    ,register_end
,    )
,
,SELECT nextval('studiesSequence')
,    ,NAME
,    ,''
,    ,3
,    ,0
,    ,register_start
,    ,register_end
,FROM dblink('dbname=mydb', 'select name,begins,ends from study') 
,     AS t1(NAME VARCHAR(50), register_start DATE, register_end DATE);
,	

 
insert into res_partner	 
(
name
,company_id
,active
,city
,commercial_partner_id
,country_id
,create_date
,create_uid
,credit_limit
,customer
,date
,debit_limit
,display_name
,email
,employee
,fax
,gst
,is_company
,lang
,message_last_post
,mobile
,notify_email
,opt_out
,parent_id
,phone
,ref
,state_id
,street
,street2
,supplier
,title
,type
,tz
,user_id
,vat
,website
,write_date
,write_uid
,zip
)

select
name
,company_id
,active
,city
,commercial_partner_id
,country_id
,create_date
,create_uid
,credit_limit
,customer
,date
,debit_limit
,display_name
,email
,employee
,fax
,gst
,is_company
,lang
,message_last_post
,mobile
,notify_email
,opt_out
,parent_id
,phone
,ref
,state_id
,street
,street2
,supplier
,title
,type
,tz
,user_id
,vat
,website
,write_date
,write_uid
,zip


use <db>

IF NOT EXISTS( SELECT 1 FROM information_schema.columns 
           WHERE table_name='res_partner' and column_name='id_8') THEN
   alter table res_partner add column id_8 integer ;
END IF

IF NOT EXISTS( SELECT 1 FROM information_schema.columns 
           WHERE table_name='res_partner' and column_name='id_10') THEN
   alter table res_partner add column id_10 integer ;
END IF

WITH cte AS (SELECT *, ROW_NUMBER() OVER() AS rn FROM res_partner)
UPDATE res_partner SET id_8 = (SELECT rn FROM cte WHERE cte.id = res_partner.id);

update res_partner set id_8 = id ;


copy (SELECT a.name, a.company_id, a.active, a.city, a.commercial_partner_id, a.country_id, a.create_date, a.create_uid, a.credit_limit, a.
   customer, a.DATE, a.debit_limit, a.display_name, a.email, a.employee, a.fax, a.gst, a.is_company, a.lang, a.message_last_post, a.mobile, a.
   notify_email, a.opt_out, a.parent_id, a.phone, a.ref, a.state_id, a.street, a.street2, a.supplier, a.title, a.type, a.tz, a.user_id, a.
   vat, a.website, a.write_date, a.write_uid, a.zip, a.id_8, a.id_10,  b.name as country, c.name as state
   FROM res_partner a 
   left join res_country b
   on a.country_id = b.id
   left join res_country_state c
   on a.state_id = c.id ;
   where a.parent_id is null order by a.name) 
   to '/home/cjpl-admin/res_partner.csv' delimiter ',' csv header ;

   
   
