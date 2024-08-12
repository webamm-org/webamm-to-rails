module WamlToRails
  module Sources
    module Migrations
      module Devise
        class Definition
          def initialize(table_name:, waml_definition:)
            @table_name = table_name
            @waml_definition = waml_definition
          end

          def columns_collection
            return [] if authentication.blank?

            columns = [
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'email',
                type: 'string',
                null: false,
                default: ''
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'encrypted_password',
                type: 'string',
                null: false,
                default: ''
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'reset_password_token',
                type: 'string',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'reset_password_sent_at',
                type: 'datetime',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'remember_created_at',
                type: 'datetime',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'sign_in_count',
                type: 'integer',
                null: false,
                default: '0'
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'current_sign_in_at',
                type: 'datetime',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'last_sign_in_at',
                type: 'datetime',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'current_sign_in_ip',
                type: 'string',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'last_sign_in_ip',
                type: 'string',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'confirmation_token',
                type: 'string',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'confirmed_at',
                type: 'datetime',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'confirmation_sent_at',
                type: 'datetime',
                null: true,
                default: nil
              ),
              ::WamlToRails::Definition::Database::Schema::Column.new(
                name: 'unconfirmed_email',
                type: 'string',
                null: true,
                default: nil
              )
            ]

            if authentication.features.include?('invitations')
              columns |= [
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'invitation_token',
                  type: 'string',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'invitation_created_at',
                  type: 'datetime',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'invitation_sent_at',
                  type: 'datetime',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'invitation_accepted_at',
                  type: 'datetime',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'invitation_limit',
                  type: 'integer',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'invited_by_id',
                  type: 'integer',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'invited_by_type',
                  type: 'string',
                  null: true,
                  default: nil
                )
              ]
            end

            if authentication.features.include?('two_factor_authentication')
              columns |= [
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_auth_secret',
                  type: 'string',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_recovery_secret',
                  type: 'string',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_enabled',
                  type: 'boolean',
                  null: false,
                  default: 'false'
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_mandatory',
                  type: 'boolean',
                  null: false,
                  default: 'false'
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_enabled_on',
                  type: 'datetime',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_failed_attempts',
                  type: 'integer',
                  null: false,
                  default: '0'
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_recovery_counter',
                  type: 'integer',
                  null: false,
                  default: '0'
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_persistence_seed',
                  type: 'string',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_session_challenge',
                  type: 'string',
                  null: true,
                  default: nil
                ),
                ::WamlToRails::Definition::Database::Schema::Column.new(
                  name: 'otp_challenge_expires',
                  type: 'datetime',
                  null: true,
                  default: nil
                )
              ]
            end

            columns
          end

          def indices_collection
            return [] if authentication.blank?

            indices = [
              ::WamlToRails::Definition::Database::Schema::Index.new(
                columns: %w[email],
                unique: true,
                name: 'email_idx'
              ),
              ::WamlToRails::Definition::Database::Schema::Index.new(
                columns: %w[reset_password_token],
                unique: true,
                name: 'reset_password_token_idx'
              ),
              ::WamlToRails::Definition::Database::Schema::Index.new(
                columns: %w[confirmation_token],
                unique: true,
                name: 'confirmation_token_idx'
              )
            ]

            if authentication.features.include?('invitations')
              indices |= [
                ::WamlToRails::Definition::Database::Schema::Index.new(
                  columns: %w[invitation_token],
                  unique: true,
                  name: 'invitation_token_idx'
                )
              ]
            end

            if authentication.features.include?('two_factor_authentication')
              indices |= [
                ::WamlToRails::Definition::Database::Schema::Index.new(
                  columns: %w[otp_session_challenge],
                  unique: true,
                  name: 'otp_session_challenge_idx'
                ),
                ::WamlToRails::Definition::Database::Schema::Index.new(
                  columns: %w[otp_challenge_expires],
                  name: 'otp_challenge_expires_idx',
                  unique: false
                )
              ]
            end

            indices
          end

          private

          def authentication
            return @authentication if defined?(@authentication)

            @authentication = (@waml_definition.authentication || []).find do |auth|
              auth.table == @table_name
            end
          end
        end
      end
    end
  end
end
