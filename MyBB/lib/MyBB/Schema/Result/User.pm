use utf8;
package MyBB::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyBB::Schema::Result::User - 


=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=item * L<DBIx::Class::TimeStamp>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime", "TimeStamp");

=head1 TABLE: C<User>

=cut

__PACKAGE__->table("User");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: 'varchar'
  is_nullable: 0
  size: 200

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 70

=head2 createddate

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  size: 50

=head2 lastvisited

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 isadmin

  data_type: 'bit'
  default_value: 'b'0''
  is_nullable: 0
  size: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "name",
  { data_type => "varchar", is_nullable => 0, size => 200 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 70 },
  "createddate",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "password",
  { data_type => "varchar", is_nullable => 0, size => 50 },
  "lastvisited",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "isadmin",
  { data_type => "bit", default_value => "b'0'", is_nullable => 0, size => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<Email_UNIQUE>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("Email_UNIQUE", ["email"]);

=head2 C<Name_UNIQUE>

=over 4

=item * L</name>

=back

=cut

__PACKAGE__->add_unique_constraint("Name_UNIQUE", ["name"]);

=head1 RELATIONS

=head2 posts

Type: has_many

Related object: L<MyBB::Schema::Result::Post>

=cut

__PACKAGE__->has_many(
  "posts",
  "MyBB::Schema::Result::Post",
  { "foreign.createdby" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 threads

Type: has_many

Related object: L<MyBB::Schema::Result::Thread>

=cut

__PACKAGE__->has_many(
  "threads",
  "MyBB::Schema::Result::Thread",
  { "foreign.createdby" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 topics

Type: has_many

Related object: L<MyBB::Schema::Result::Topic>

=cut

__PACKAGE__->has_many(
  "topics",
  "MyBB::Schema::Result::Topic",
  { "foreign.createdby" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-20 02:17:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Vd3DM8AK3SPGmyugsnPIug


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
