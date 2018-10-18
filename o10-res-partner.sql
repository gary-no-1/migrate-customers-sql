-- Table: public.res_partner

-- DROP TABLE public.res_partner;

CREATE TABLE public.res_partner
(
  id integer NOT NULL DEFAULT nextval('res_partner_id_seq'::regclass),
  name character varying,
  company_id integer,
  comment text, -- Notes
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
  notify_email character varying NOT NULL, -- Email Messages and Notifications
  message_last_post timestamp without time zone, -- Last Message Date
  opt_out boolean, -- Opt-Out
  message_bounce integer, -- Bounce
  signup_type character varying, -- Signup Token Type
  signup_expiration timestamp without time zone, -- Signup expiration
  signup_token character varying, -- Signup token
  picking_warn_msg text, -- Message for Stock Picking
  picking_warn character varying NOT NULL, -- Stock Picking
  team_id integer, -- Sales Team
  calendar_last_notif_ack timestamp without time zone, -- Last notification marked as read from base Calendar
  invoice_warn character varying NOT NULL, -- Invoice
  debit_limit numeric, -- Payable Limit
  last_time_entries_checked timestamp without time zone, -- Latest Invoices & Payments Matching Date
  invoice_warn_msg text, -- Message for Invoice
  sale_warn_msg text, -- Message for Sales Order
  sale_warn character varying NOT NULL, -- Sales Order
  purchase_warn character varying NOT NULL, -- Purchase Order
  purchase_warn_msg text, -- Message for Purchase Order
  CONSTRAINT res_partner_pkey PRIMARY KEY (id),
  CONSTRAINT res_partner_commercial_partner_id_fkey FOREIGN KEY (commercial_partner_id)
      REFERENCES public.res_partner (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_company_id_fkey FOREIGN KEY (company_id)
      REFERENCES public.res_company (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_country_id_fkey FOREIGN KEY (country_id)
      REFERENCES public.res_country (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT res_partner_create_uid_fkey FOREIGN KEY (create_uid)
      REFERENCES public.res_users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_parent_id_fkey FOREIGN KEY (parent_id)
      REFERENCES public.res_partner (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_state_id_fkey FOREIGN KEY (state_id)
      REFERENCES public.res_country_state (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT res_partner_team_id_fkey FOREIGN KEY (team_id)
      REFERENCES public.crm_team (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_title_fkey FOREIGN KEY (title)
      REFERENCES public.res_partner_title (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES public.res_users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_write_uid_fkey FOREIGN KEY (write_uid)
      REFERENCES public.res_users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_check_name CHECK (type::text = 'contact'::text AND name IS NOT NULL OR type::text <> 'contact'::text)
)
WITH (
  OIDS=FALSE
);
ALTER TABLE public.res_partner
  OWNER TO odoo;
COMMENT ON COLUMN public.res_partner.comment IS 'Notes';
COMMENT ON COLUMN public.res_partner.website IS 'Website';
COMMENT ON COLUMN public.res_partner.create_date IS 'Created on';
COMMENT ON COLUMN public.res_partner.color IS 'Color Index';
COMMENT ON COLUMN public.res_partner.active IS 'Active';
COMMENT ON COLUMN public.res_partner.street IS 'Street';
COMMENT ON COLUMN public.res_partner.supplier IS 'Is a Vendor';
COMMENT ON COLUMN public.res_partner.city IS 'City';
COMMENT ON COLUMN public.res_partner.display_name IS 'Display Name';
COMMENT ON COLUMN public.res_partner.zip IS 'Zip';
COMMENT ON COLUMN public.res_partner.title IS 'Title';
COMMENT ON COLUMN public.res_partner.country_id IS 'Country';
COMMENT ON COLUMN public.res_partner.commercial_company_name IS 'Company Name Entity';
COMMENT ON COLUMN public.res_partner.parent_id IS 'Related Company';
COMMENT ON COLUMN public.res_partner.company_name IS 'Company Name';
COMMENT ON COLUMN public.res_partner.employee IS 'Employee';
COMMENT ON COLUMN public.res_partner.ref IS 'Internal Reference';
COMMENT ON COLUMN public.res_partner.email IS 'Email';
COMMENT ON COLUMN public.res_partner.is_company IS 'Is a Company';
COMMENT ON COLUMN public.res_partner.function IS 'Job Position';
COMMENT ON COLUMN public.res_partner.lang IS 'Language';
COMMENT ON COLUMN public.res_partner.fax IS 'Fax';
COMMENT ON COLUMN public.res_partner.street2 IS 'Street2';
COMMENT ON COLUMN public.res_partner.barcode IS 'Barcode';
COMMENT ON COLUMN public.res_partner.phone IS 'Phone';
COMMENT ON COLUMN public.res_partner.write_date IS 'Last Updated on';
COMMENT ON COLUMN public.res_partner.date IS 'Date';
COMMENT ON COLUMN public.res_partner.tz IS 'Timezone';
COMMENT ON COLUMN public.res_partner.write_uid IS 'Last Updated by';
COMMENT ON COLUMN public.res_partner.customer IS 'Is a Customer';
COMMENT ON COLUMN public.res_partner.create_uid IS 'Created by';
COMMENT ON COLUMN public.res_partner.credit_limit IS 'Credit Limit';
COMMENT ON COLUMN public.res_partner.user_id IS 'Salesperson';
COMMENT ON COLUMN public.res_partner.mobile IS 'Mobile';
COMMENT ON COLUMN public.res_partner.type IS 'Address Type';
COMMENT ON COLUMN public.res_partner.partner_share IS 'Share Partner';
COMMENT ON COLUMN public.res_partner.vat IS 'TIN';
COMMENT ON COLUMN public.res_partner.state_id IS 'State';
COMMENT ON COLUMN public.res_partner.commercial_partner_id IS 'Commercial Entity';
COMMENT ON COLUMN public.res_partner.notify_email IS 'Email Messages and Notifications';
COMMENT ON COLUMN public.res_partner.message_last_post IS 'Last Message Date';
COMMENT ON COLUMN public.res_partner.opt_out IS 'Opt-Out';
COMMENT ON COLUMN public.res_partner.message_bounce IS 'Bounce';
COMMENT ON COLUMN public.res_partner.signup_type IS 'Signup Token Type';
COMMENT ON COLUMN public.res_partner.signup_expiration IS 'Signup expiration';
COMMENT ON COLUMN public.res_partner.signup_token IS 'Signup token';
COMMENT ON COLUMN public.res_partner.picking_warn_msg IS 'Message for Stock Picking';
COMMENT ON COLUMN public.res_partner.picking_warn IS 'Stock Picking';
COMMENT ON COLUMN public.res_partner.team_id IS 'Sales Team';
COMMENT ON COLUMN public.res_partner.calendar_last_notif_ack IS 'Last notification marked as read from base Calendar';
COMMENT ON COLUMN public.res_partner.invoice_warn IS 'Invoice';
COMMENT ON COLUMN public.res_partner.debit_limit IS 'Payable Limit';
COMMENT ON COLUMN public.res_partner.last_time_entries_checked IS 'Latest Invoices & Payments Matching Date';
COMMENT ON COLUMN public.res_partner.invoice_warn_msg IS 'Message for Invoice';
COMMENT ON COLUMN public.res_partner.sale_warn_msg IS 'Message for Sales Order';
COMMENT ON COLUMN public.res_partner.sale_warn IS 'Sales Order';
COMMENT ON COLUMN public.res_partner.purchase_warn IS 'Purchase Order';
COMMENT ON COLUMN public.res_partner.purchase_warn_msg IS 'Message for Purchase Order';


-- Index: public.res_partner_commercial_partner_id_index

-- DROP INDEX public.res_partner_commercial_partner_id_index;

CREATE INDEX res_partner_commercial_partner_id_index
  ON public.res_partner
  USING btree
  (commercial_partner_id);

-- Index: public.res_partner_company_id_index

-- DROP INDEX public.res_partner_company_id_index;

CREATE INDEX res_partner_company_id_index
  ON public.res_partner
  USING btree
  (company_id);

-- Index: public.res_partner_date_index

-- DROP INDEX public.res_partner_date_index;

CREATE INDEX res_partner_date_index
  ON public.res_partner
  USING btree
  (date);

-- Index: public.res_partner_display_name_index

-- DROP INDEX public.res_partner_display_name_index;

CREATE INDEX res_partner_display_name_index
  ON public.res_partner
  USING btree
  (display_name COLLATE pg_catalog."default");

-- Index: public.res_partner_name_index

-- DROP INDEX public.res_partner_name_index;

CREATE INDEX res_partner_name_index
  ON public.res_partner
  USING btree
  (name COLLATE pg_catalog."default");

-- Index: public.res_partner_parent_id_index

-- DROP INDEX public.res_partner_parent_id_index;

CREATE INDEX res_partner_parent_id_index
  ON public.res_partner
  USING btree
  (parent_id);

-- Index: public.res_partner_ref_index

-- DROP INDEX public.res_partner_ref_index;

CREATE INDEX res_partner_ref_index
  ON public.res_partner
  USING btree
  (ref COLLATE pg_catalog."default");

