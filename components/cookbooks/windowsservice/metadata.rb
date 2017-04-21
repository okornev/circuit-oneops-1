name             'Windowsservice'
maintainer       'Oneops'
maintainer_email 'support@oneops.com'
license          'Apache License, Version 2.0'
description      'Installs/Configures Windowsservice'
version          '0.1.0'

supports 'windows'

grouping 'default',
  :access   => 'global',
  :packages => ['base', 'mgmt.catalog', 'mgmt.manifest', 'catalog', 'manifest', 'bom']

attribute 'package_name',
  :description => "Package Name",
  :required    => "required",
  :default     => '',
  :format      =>   {
    :help      => 'Name of the package in the repository',
    :category  => '1.Nuget Package',
    :order     => 1
  }

attribute 'repository_url',
  :description => "Repository URL",
  :required    => "required",
  :default     => '',
  :format      => {
    :help      => 'Base URL of the repository, Ex: https://www.nuget.org/api/v2/',
    :category  => '1.Nuget Package',
    :order     => 2
  }

attribute 'version',
  :description => "Version",
  :required    => "required",
  :default     => 'latest',
  :format      => {
    :help      => 'Version of the package being deployed',
    :category  => '1.Nuget Package',
    :order     => 3
  }

attribute 'service_name',
  :description => 'Service name',
  :required    => 'required',
  :format      => {
    :help      => 'Name of the service to create',
    :category  => '2.General',
    :order     => 1
  }

attribute 'service_display_name',
  :description => 'Display name',
  :format      => {
    :help      => 'Display name of the service',
    :category  => '2.General',
    :order     => 2
  }

attribute 'path',
  :description => 'Executable Path',
  :required    => 'required',
  :format      => {
    :help      => 'Relative path to the program/script to be installed as service, Ex: bin\test.exe, myapp.exe',
    :category  => '2.General',
    :order     => 3
  }

attribute 'cmd_path',
  :description => 'Application directory',
  :required    => 'required',
  :format      => {
    :help      => 'Application directory where the package is to be installed, Ex: e:\apps',
    :category  => '2.General',
    :pattern   => '^((?:[${}a-zA-Z]:){0,1}(?:[\\$][${}a-zA-Z0-9]+(?:_[${}a-zA-Z0-9]+)*(?:-[${}a-zA-Z0-9]+)*)+)$',
    :order     => 4
  }

attribute 'startup_type',
  :description => 'Startup type',
  :default     => 'auto start',
  :format      => {
    :help      => 'When you want to start the serivce',
    :category  => '2.General',
    :order     => 5,
    :form      => {'field' => 'select',
                    'options_for_select' => [
                       ['Automatic','auto start'],
                       ['Manual','demand start'],
                       ['Disabled','disabled']
                      ]
                    }
  }

attribute 'arguments',
  :description => 'Start parameters',
  :data_type   => 'array',
  :format      => {
    :help      => 'You can specify the start parameters that apply when you start the service',
    :category  => '2.General',
    :order     => 6
  }

attribute 'user_account',
  :description => 'User Account',
  :required    => 'required',
  :format      => {
    :help      => 'Select the built-in account under which the service will be installed',
    :category  => '3.Log On',
    :order     => 1,
    :form      => { 'field' => 'select',
                    'options_for_select' => [
                      ['Local Service', 'NT AUTHORITY\\LocalService'],
                      ['Network Service', 'NT AUTHORITY\\NetworkService'],
                      ['Specific User', 'SpecificUser']
                    ]
                  }
  }

attribute 'username',
  :description => 'Username',
  :format      => {
    :help      => 'Username of the account under which the program/script is to be run, Ex: domain\username, username',
    :category  => '3.Log On',
    :order     => 2,
    :filter    => {'all' => {'visible' => 'user_account:eq:SpecificUser'}}
  }

attribute 'password',
  :description => 'Password',
  :encrypted   => true,
  :format      => {
    :help      => 'Password of the user',
    :category  => '3.Log On',
    :order     => 3,
    :filter    => {'all' => {'visible' => 'user_account:eq:SpecificUser'}}
  }

recipe 'start_service', 'Start windows service'
recipe 'stop_service', 'Stop windows service'
recipe 'restart_service', 'Restart windows service'
