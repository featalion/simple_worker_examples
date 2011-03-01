# load configuration files
db_config   = YAML.load_file("config/database.yml")
aws_config  = YAML.load_file("config/s3.yml")
sw_config   = YAML.load_file("config/sw.yml")


@keys               = {}
@keys[:development] = HashWithIndifferentAccess.new({
                                                      "aws_access_key" => aws_config["access_key_id"],
                                                      "aws_secret_key" => asw_config["secret_access_key"],
                                                      "env"            => "development",
                                                      "s3_suffix"      => "-dev",
                                                      "sw_access_key"  => sw_config["access_key_id"],
                                                      "sw_secret_key"  => sw_config["secret_access_key"],
                                                      "db_conf"        => db_config["development"]
                                                    })

@keys[:production]  = HashWithIndifferentAccess.new({
                                                      "aws_access_key" => aws_config["access_key_id"],
                                                      "aws_secret_key" => asw_config["secret_access_key"],
                                                      "env"            => "production",
                                                      "s3_suffix"      => "",
                                                      "sw_access_key"  => sw_config["access_key_id"],
                                                      "sw_secret_key"  => sw_config["secret_access_key"],
                                                      "db_conf"        => db_config["production"]
                                                    })


# get config based on environment (placed in schedule_*.rb)
config = @keys[@env]

# configure the worker
SimpleWorker.configure do |conf|
  conf.access_key                         = config["sw_access_key"]
  conf.secret_key                         = config["sw_secret_key"]
  conf.global_attributes[:aws_access_key] = config["aws_access_key"]
  conf.global_attributes[:aws_secret_key] = config["aws_secret_key"]
  conf.global_attributes[:s3_suffix]      = config["s3_suffix"]
  conf.global_attributes[:env]            = config["env"]
  conf.database                           = config["db_conf"]
end
