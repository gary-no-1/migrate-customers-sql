-- Table: res_partner

-- DROP TABLE res_partner;

CREATE TABLE res_partner
(
  id serial NOT NULL,
  name character varying NOT NULL,
  company_id integer,
  comment text, -- Notes
  ean13 character varying(13), -- EAN13
  create_date timestamp without time zone, -- Created on
  color integer, -- Color Index
  image_small bytea, -- Small-sized image
  image bytea, -- Image
  date date, -- Date
  street character varying, -- Street
  city character varying, -- City
  display_name character varying, -- Name
  zip character varying(24), -- Zip
  title integer, -- Title
  function character varying, -- Job Position
  country_id integer, -- Country
  parent_id integer, -- Related Company
  supplier boolean, -- Supplier
  ref character varying, -- Contact Reference
  email character varying, -- Email
  is_company boolean, -- Is a Company
  website character varying, -- Website
  customer boolean, -- Customer
  fax character varying, -- Fax
  street2 character varying, -- Street2
  employee boolean, -- Employee
  credit_limit double precision, -- Credit Limit
  write_date timestamp without time zone, -- Last Updated on
  active boolean, -- Active
  tz character varying(64), -- Timezone
  write_uid integer, -- Last Updated by
  lang character varying, -- Language
  create_uid integer, -- Created by
  image_medium bytea, -- Medium-sized image
  phone character varying, -- Phone
  mobile character varying, -- Mobile
  type character varying, -- Address Type
  use_parent_address boolean, -- Use Company Address
  user_id integer, -- Salesperson
  birthdate character varying, -- Birthdate
  vat character varying, -- TIN
  state_id integer, -- State
  commercial_partner_id integer, -- Commercial Entity
  notify_email character varying NOT NULL, -- Receive Inbox Notifications by Email
  message_last_post timestamp without time zone, -- Last Message Date
  opt_out boolean, -- Opt-Out
  section_id integer, -- Sales Team
  signup_type character varying, -- Signup Token Type
  signup_expiration timestamp without time zone, -- Signup Expiration
  signup_token character varying, -- Signup Token
  calendar_last_notif_ack timestamp without time zone, -- Last notification marked as read from base Calendar
  last_reconciliation_date timestamp without time zone, -- Latest Full Reconciliation Date
  debit_limit double precision, -- Payable Limit
  vat_subjected boolean, -- VAT Legal Statement
  x_pan character varying, -- PAN #
  x_tin character varying, -- TIN #
  x_accounts_approval boolean, -- Approved by Accounts
  x_srv_tax character varying, -- Service Tax #
  x_roc character varying, -- ROC #
  x_watchlist character varying, -- Watchlist Status
  picking_warn character varying, -- Stock Picking
  sale_warn character varying, -- Sales Order
  purchase_warn character varying, -- Purchase Order
  picking_warn_msg text, -- Message for Stock Picking
  invoice_warn_msg text, -- Message for Invoice
  sale_warn_msg text, -- Message for Sales Order
  invoice_warn character varying, -- Invoice
  purchase_warn_msg text, -- Message for Purchase Order
  x_core_code character varying, -- Core Software Party Code
  x_kyc_template character varying, -- KYC Template
  x_kyc_form character varying, -- KYC Form
  gst character varying, -- GSTIN
  CONSTRAINT res_partner_pkey PRIMARY KEY (id),
  CONSTRAINT res_partner_commercial_partner_id_fkey FOREIGN KEY (commercial_partner_id)
      REFERENCES res_partner (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_company_id_fkey FOREIGN KEY (company_id)
      REFERENCES res_company (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_country_id_fkey FOREIGN KEY (country_id)
      REFERENCES res_country (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT res_partner_create_uid_fkey FOREIGN KEY (create_uid)
      REFERENCES res_users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_parent_id_fkey FOREIGN KEY (parent_id)
      REFERENCES res_partner (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_section_id_fkey FOREIGN KEY (section_id)
      REFERENCES crm_case_section (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_state_id_fkey FOREIGN KEY (state_id)
      REFERENCES res_country_state (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE RESTRICT,
  CONSTRAINT res_partner_title_fkey FOREIGN KEY (title)
      REFERENCES res_partner_title (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_user_id_fkey FOREIGN KEY (user_id)
      REFERENCES res_users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL,
  CONSTRAINT res_partner_write_uid_fkey FOREIGN KEY (write_uid)
      REFERENCES res_users (id) MATCH SIMPLE
      ON UPDATE NO ACTION ON DELETE SET NULL
)
WITH (
  OIDS=FALSE
);
ALTER TABLE res_partner
  OWNER TO "cjpl-odoo";
COMMENT ON COLUMN res_partner.comment IS 'Notes';
COMMENT ON COLUMN res_partner.ean13 IS 'EAN13';
COMMENT ON COLUMN res_partner.create_date IS 'Created on';
COMMENT ON COLUMN res_partner.color IS 'Color Index';
COMMENT ON COLUMN res_partner.image_small IS 'Small-sized image';
COMMENT ON COLUMN res_partner.image IS 'Image';
COMMENT ON COLUMN res_partner.date IS 'Date';
COMMENT ON COLUMN res_partner.street IS 'Street';
COMMENT ON COLUMN res_partner.city IS 'City';
COMMENT ON COLUMN res_partner.display_name IS 'Name';
COMMENT ON COLUMN res_partner.zip IS 'Zip';
COMMENT ON COLUMN res_partner.title IS 'Title';
COMMENT ON COLUMN res_partner.function IS 'Job Position';
COMMENT ON COLUMN res_partner.country_id IS 'Country';
COMMENT ON COLUMN res_partner.parent_id IS 'Related Company';
COMMENT ON COLUMN res_partner.supplier IS 'Supplier';
COMMENT ON COLUMN res_partner.ref IS 'Contact Reference';
COMMENT ON COLUMN res_partner.email IS 'Email';
COMMENT ON COLUMN res_partner.is_company IS 'Is a Company';
COMMENT ON COLUMN res_partner.website IS 'Website';
COMMENT ON COLUMN res_partner.customer IS 'Customer';
COMMENT ON COLUMN res_partner.fax IS 'Fax';
COMMENT ON COLUMN res_partner.street2 IS 'Street2';
COMMENT ON COLUMN res_partner.employee IS 'Employee';
COMMENT ON COLUMN res_partner.credit_limit IS 'Credit Limit';
COMMENT ON COLUMN res_partner.write_date IS 'Last Updated on';
COMMENT ON COLUMN res_partner.active IS 'Active';
COMMENT ON COLUMN res_partner.tz IS 'Timezone';
COMMENT ON COLUMN res_partner.write_uid IS 'Last Updated by';
COMMENT ON COLUMN res_partner.lang IS 'Language';
COMMENT ON COLUMN res_partner.create_uid IS 'Created by';
COMMENT ON COLUMN res_partner.image_medium IS 'Medium-sized image';
COMMENT ON COLUMN res_partner.phone IS 'Phone';
COMMENT ON COLUMN res_partner.mobile IS 'Mobile';
COMMENT ON COLUMN res_partner.type IS 'Address Type';
COMMENT ON COLUMN res_partner.use_parent_address IS 'Use Company Address';
COMMENT ON COLUMN res_partner.user_id IS 'Salesperson';
COMMENT ON COLUMN res_partner.birthdate IS 'Birthdate';
COMMENT ON COLUMN res_partner.vat IS 'TIN';
COMMENT ON COLUMN res_partner.state_id IS 'State';
COMMENT ON COLUMN res_partner.commercial_partner_id IS 'Commercial Entity';
COMMENT ON COLUMN res_partner.notify_email IS 'Receive Inbox Notifications by Email';
COMMENT ON COLUMN res_partner.message_last_post IS 'Last Message Date';
COMMENT ON COLUMN res_partner.opt_out IS 'Opt-Out';
COMMENT ON COLUMN res_partner.section_id IS 'Sales Team';
COMMENT ON COLUMN res_partner.signup_type IS 'Signup Token Type';
COMMENT ON COLUMN res_partner.signup_expiration IS 'Signup Expiration';
COMMENT ON COLUMN res_partner.signup_token IS 'Signup Token';
COMMENT ON COLUMN res_partner.calendar_last_notif_ack IS 'Last notification marked as read from base Calendar';
COMMENT ON COLUMN res_partner.last_reconciliation_date IS 'Latest Full Reconciliation Date';
COMMENT ON COLUMN res_partner.debit_limit IS 'Payable Limit';
COMMENT ON COLUMN res_partner.vat_subjected IS 'VAT Legal Statement';
COMMENT ON COLUMN res_partner.x_pan IS 'PAN #';
COMMENT ON COLUMN res_partner.x_tin IS 'TIN #';
COMMENT ON COLUMN res_partner.x_accounts_approval IS 'Approved by Accounts';
COMMENT ON COLUMN res_partner.x_srv_tax IS 'Service Tax #';
COMMENT ON COLUMN res_partner.x_roc IS 'ROC #';
COMMENT ON COLUMN res_partner.x_watchlist IS 'Watchlist Status';
COMMENT ON COLUMN res_partner.picking_warn IS 'Stock Picking';
COMMENT ON COLUMN res_partner.sale_warn IS 'Sales Order';
COMMENT ON COLUMN res_partner.purchase_warn IS 'Purchase Order';
COMMENT ON COLUMN res_partner.picking_warn_msg IS 'Message for Stock Picking';
COMMENT ON COLUMN res_partner.invoice_warn_msg IS 'Message for Invoice';
COMMENT ON COLUMN res_partner.sale_warn_msg IS 'Message for Sales Order';
COMMENT ON COLUMN res_partner.invoice_warn IS 'Invoice';
COMMENT ON COLUMN res_partner.purchase_warn_msg IS 'Message for Purchase Order';
COMMENT ON COLUMN res_partner.x_core_code IS 'Core Software Party Code';
COMMENT ON COLUMN res_partner.x_kyc_template IS 'KYC Template';
COMMENT ON COLUMN res_partner.x_kyc_form IS 'KYC Form';
COMMENT ON COLUMN res_partner.gst IS 'GSTIN';


-- Index: res_partner_company_id_index

-- DROP INDEX res_partner_company_id_index;

CREATE INDEX res_partner_company_id_index
  ON res_partner
  USING btree
  (company_id);

-- Index: res_partner_display_name_index

-- DROP INDEX res_partner_display_name_index;

CREATE INDEX res_partner_display_name_index
  ON res_partner
  USING btree
  (display_name COLLATE pg_catalog."default");

-- Index: res_partner_name_index

-- DROP INDEX res_partner_name_index;

CREATE INDEX res_partner_name_index
  ON res_partner
  USING btree
  (name COLLATE pg_catalog."default");

-- Index: res_partner_parent_id_index

-- DROP INDEX res_partner_parent_id_index;

CREATE INDEX res_partner_parent_id_index
  ON res_partner
  USING btree
  (parent_id);

-- Index: res_partner_ref_index

-- DROP INDEX res_partner_ref_index;

CREATE INDEX res_partner_ref_index
  ON res_partner
  USING btree
  (ref COLLATE pg_catalog."default");

