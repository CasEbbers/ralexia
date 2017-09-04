# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
admin = User.create(
  email: 'admin@example.org',
  password: 'nimda',
  password_confirmation: 'nimda',
  first_name: 'Admin',
  admin: true,
)
user = User.create(
  email: 'user@example.org',
  password: 'user',
  password_confirmation: 'user',
  first_name: 'User',
)

organizations = Organization.create [
  { name: 'Abacus' },
  { name: 'Inter-Actief' },
  { name: 'Proto' },
  { name: 'SBZ' },
  { name: 'Scintilla' },
  { name: 'Sirius' },
  { name: 'Stress' },
]
abacus = Organization.friendly.find('abacus')
ia = Organization.friendly.find('inter-actief')

Membership.create(
  user: user,
  organization: ia,
  active: true,
  bartender: true,
  planner: true,
  manager: true,
)

locations = Location.create [
  { name: 'Abscint', prevents_conflict: true },
  { name: 'MBasement', prevents_conflict: true },
]
abscint = Location.find_by_name('Abscint')

EnrollmentType.create [
  { organization: ia, name: 'Ja', nature: 'yes' },
  { organization: ia, name: 'Misschien', nature: 'maybe' },
  { organization: ia, name: 'Nee', nature: 'no' },
]

start = DateTime.now.change(hour: 16, min: 0)
Event.create(
  organizer: ia,
  organizations: [ia],
  locations: [abscint],
  kegs: 1,
  name: 'Borrel vandaag 1',
  starts_at: start,
  ends_at: start + 2.hours,
)

Event.create(
  organizer: ia,
  organizations: [ia],
  locations: [abscint],
  kegs: 1,
  name: 'Borrel vandaag 2',
  starts_at: start + 2.hours,
  ends_at: start + 4.hours,
)

Event.create(
  organizer: abacus,
  organizations: [abacus, ia],
  locations: [abscint],
  kegs: 1,
  name: 'Borrel morgen',
  starts_at: start + 1.day,
  ends_at: start + 1.day + 12.hours,
)
