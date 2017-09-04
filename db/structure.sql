CREATE TABLE "enrollment_types" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "organization_id" integer, "name" varchar NOT NULL, "nature" integer NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_enrollment_types_on_organization_id" ON "enrollment_types" ("organization_id");
CREATE TABLE "enrollments" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "event_id" integer, "enrollment_type_id" integer, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_enrollments_on_enrollment_type_id" ON "enrollments" ("enrollment_type_id");
CREATE INDEX "index_enrollments_on_event_id" ON "enrollments" ("event_id");
CREATE INDEX "index_enrollments_on_user_id" ON "enrollments" ("user_id");
CREATE TABLE "events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "organizer_id" integer, "name" varchar NOT NULL, "starts_at" datetime NOT NULL, "ends_at" datetime NOT NULL, "kegs" integer NOT NULL, "enrollment_closed" boolean DEFAULT 'f', "option" boolean DEFAULT 'f', "risky" boolean DEFAULT 'f', "bartender_instruction" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_events_on_organizer_id" ON "events" ("organizer_id");
CREATE TABLE "events_locations" ("event_id" integer, "location_id" integer);
CREATE UNIQUE INDEX "index_events_locations_on_event_id_and_location_id" ON "events_locations" ("event_id", "location_id");
CREATE INDEX "index_events_locations_on_event_id" ON "events_locations" ("event_id");
CREATE INDEX "index_events_locations_on_location_id" ON "events_locations" ("location_id");
CREATE TABLE "events_organizations" ("event_id" integer, "organization_id" integer);
CREATE UNIQUE INDEX "index_events_organizations_on_event_id_and_organization_id" ON "events_organizations" ("event_id", "organization_id");
CREATE INDEX "index_events_organizations_on_event_id" ON "events_organizations" ("event_id");
CREATE INDEX "index_events_organizations_on_organization_id" ON "events_organizations" ("organization_id");
CREATE TABLE "locations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "prevents_conflict" boolean DEFAULT 't', "color" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "memberships" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "user_id" integer, "organization_id" integer, "active" boolean DEFAULT 't', "bartender" boolean DEFAULT 'f', "planner" boolean DEFAULT 'f', "manager" boolean DEFAULT 'f', "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_memberships_on_organization_id" ON "memberships" ("organization_id");
CREATE INDEX "index_memberships_on_user_id" ON "memberships" ("user_id");
CREATE TABLE "organizations" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "slug" varchar, "color" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE UNIQUE INDEX "index_organizations_on_slug" ON "organizations" ("slug");
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar, "first_name" varchar, "last_name" varchar, "email" varchar, "password_digest" varchar, "admin" boolean DEFAULT 'f', "current_organization_id" integer, "last_login" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE INDEX "index_users_on_current_organization_id" ON "users" ("current_organization_id");
CREATE TABLE "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
CREATE TABLE "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
INSERT INTO "schema_migrations" (version) VALUES
('1');


