[![Gem Version](https://badge.fury.io/rb/tsudura.svg)](http://badge.fury.io/rb/tsudura) [![Build Status](https://travis-ci.org/onigra/tsudura.svg)](https://travis-ci.org/onigra/tsudura) [![Coverage Status](https://coveralls.io/repos/onigra/tsudura/badge.svg?branch=master)](https://coveralls.io/r/onigra/tsudura?branch=master) [![Code Climate](https://codeclimate.com/github/onigra/tsudura/badges/gpa.svg)](https://codeclimate.com/github/onigra/tsudura) [![Dependency Status](https://gemnasium.com/onigra/tsudura.svg)](https://gemnasium.com/onigra/tsudura)

# WARNING

This gem is alpha version.
このgemはまだアルファ版です。

# Tsudura

Yamlに記述した設定を元にAnsible Playbookをsshで実行し、AWSのAmiの作成、LaunchConfigの作成、AutoScalingGroupに紐づくLaunchConfigの入れ替えを行うコマンドラインツールです。
Packer + Ansibleを使い、自分が足りないと思った機能を埋めるために作成しました。

## Installation

install it yourself as:

    $ gem install tsudura

## Usage

`build`コマンドを使用します。

```sh
$ tsudura build example.yml
```

### 設定ファイル

packerで言う設定を記述するjsonをtsuduraではyamlに記述します。
[spec/samples/yamls](https://github.com/onigra/tsudura/tree/master/spec/samples/yamls)にテストで使用しているサンプルのyamlがありますので、参考になると思います。
また、yamlはERBの記法が使用できるようにしてあります。

#### required

- `service`: 扱うリソースの名前空間です。作成されたリソースにprefixとして付与されます。
- `region`: インスタンスを作成するRegionを指定します。
- `security_group_id`: インスタンスに設定するSecurityGroupIDを指定します。
- `subnet_id`: インスタンスに設定するSubnetIDを指定します。
- `image_id`: インスタンスを作成する際のAmiのIDを指定します。
- `key_name`: インスタンスを作成する際のKeyPairの名前を指定します。
- `instance_type`: インスタンスを作成、LaunchConfigを作成する際のInstanceTypeを指定します。
- `playbook_path`: 実行するAnsiblePlaybookのPathを指定します。
- `inventory_file`: Ansibleを実行する際のInventoryFileのPathを指定します。
- `owner`: Amiを作成する際に指定するOwnerのIDを指定します。

#### options

- `vault_password`: AnsibleVaultを使用していた場合、実行する際のVaultPasswordを指定します。
- `mode`: 後述する実行モードを指定します。
- `user_data_script`: LaunchConfigを作成する際にUserDataScriptを指定します。
- `auto_scaling_group_name`: 新しく作成したLaunchConfigを紐づけるAutoScalingGroupを指定します。

### モードについて

#### NormalMode

デフォルト。何も指定しないとこれになる。

- Amiの作成
- LaunchConfigの作成
- AutoScalingGroupの更新

```yaml
mode: normal
```

#### PackerMode

- Amiの作成

```yaml
mode: packer
```

#### PackerPlusMode

- Amiの作成
- LaunchConfigの作成

```yaml
mode: packer_plus
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. Run `bundle exec tsudura` to use the code located in this directory, ignoring other installed copies of this gem.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/tsudura/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
