use utf8;
package MyBB::Schema::Result::Post;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyBB::Schema::Result::Post

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

=head1 TABLE: C<Post>

=cut

__PACKAGE__->table("Post");

=head1 ACCESSORS

=head2 id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 content

  data_type: 'varchar'
  is_nullable: 0
  size: 2000

=head2 thread

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 ordernum

  data_type: 'integer'
  is_nullable: 0

=head2 createdby

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 createddate

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 0

=head2 lastupdate

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "content",
  { data_type => "varchar", is_nullable => 0, size => 2000 },
  "thread",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "ordernum",
  { data_type => "integer", is_nullable => 0 },
  "createdby",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "createddate",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 0,
  },
  "lastupdate",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 createdby

Type: belongs_to

Related object: L<MyBB::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "createdby",
  "MyBB::Schema::Result::User",
  { id => "createdby" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 thread

Type: belongs_to

Related object: L<MyBB::Schema::Result::Thread>

=cut

__PACKAGE__->belongs_to(
  "thread",
  "MyBB::Schema::Result::Thread",
  { id => "thread" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 threads

Type: has_many

Related object: L<MyBB::Schema::Result::Thread>

=cut

__PACKAGE__->has_many(
  "threads",
  "MyBB::Schema::Result::Thread",
  { "foreign.lastestpost" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-20 02:17:36
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:k2B5zlkhNuCrN6M3eVBWOw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;
