module FlashSDK

  ##
  # Creates AIR certificates and compiles AIR packages for distribution.
  #
  # Following is an example of how this tool might be used to create
  # a certificate and AIR package:
  #
  #   mxmlc 'bin/SomeProject.swf' do |t|
  #     t.input = 'src/SomeProject.as'
  #   end
  #
  #   adt 'cert/SomeProject.pfx' do |t|
  #     t.certificate = true
  #     t.cn          = 'SelfCertificate'
  #     t.key_type    = '1024-RSA'
  #     t.password    = File.read('cert/.password')
  #     t.pfx_file    = 'cert/SomeProject.pfx'
  #   end
  #
  #   adt 'bin/SomeProject.air' => ['bin/SomeProject.swf', 'cert/SomeProject.pfx'] do |t|
  #     t.package        = true
  #     t.package_input  = 'SomeProject.xml'
  #     t.package_output = 'bin/SomeProject.air'
  #     t.storetype      = 'pkcs12'
  #     t.keystore       = 'cert/SomeProject.pfx'
  #     t.storepass      = File.read('cert/.password')
  #     t.included_files << 'bin/SomeProject.swf'
  #   end
  #
  #   desc "Compile, certify and package the AIR application"
  #   task package => 'bin/SomeProject.air'
  #
  class ADT
    include Sprout::Executable
    #NOTE:
    # The order of these parameters is important!
    # Please do not alphabetize or rearrange unless you're
    # fixing a bug related to how ADT actually expects
    # the arguments...

    ##
    # Create an AIR package.
    #
    add_param :package, Boolean, { :hidden_value => true }

    ##
    # Set true to create a certificate.
    #
    # If this value is true, you can optionally set org_unit, org_name and country.
    # 
    # If this value is true, you MUST set +cn+, +key_type+, and +pfx_file+.
    #
    #  adt 'cert/SampleCert.pfx' do |t|
    #    t.certificate = true
    #    t.cn = 'SelfCertificate'
    #    t.key_type = '1024-RSA'
    #    t.pfx_file = 'cert/SampleCert.pfx'
    #    t.password = 'samplepassword'
    #  end
    #
    add_param :certificate, Boolean, { :hidden_value => true }

    ##
    # A Signing Option
    #
    add_param :storetype, String, { :delimiter => ' ' }


    ##
    # A Signing Option
    #
    add_param :keystore, String, { :delimiter => ' ' }


    ##
    # Provide the password directly to the ADT task
    # so that it doesn't attempt to prompt.
    #
    add_param :storepass, String, { :delimiter => ' ' }


    ##
    # A Signing Option
    #
    add_param :keypass, String, { :delimiter => ' ' }


    ##
    # A Signing Option
    #
    add_param :providername, String, { :delimiter => ' ' }


    ##
    # A Signing Option
    #
    add_param :tsa, String
    
    ##
    # Check Store Signing options
    #
    add_param :checkstore, String

    ##
    # Expects two files:
    #
    # 1) The Airi file (?)
    # 2) The application description
    #add_param :prepare, Files

    ##
    # Expects two files:
    #
    # 1) The Airi file (?)
    # 2) The Air file
    add_param :sign, Files, { :delimiter => ' ' }


    ##
    # The AIR runtime version to use.
    add_param :version, String, { :delimiter => ' ' }

    ##
    # The AIR file that should be created
    # after packaging is complete.
    #
    add_param :package_output, String, { :hidden_name => true }

    ##
    # The XML application descriptor that
    # should be used to create an AIR
    # application.
    #
    add_param :package_input, File, { :hidden_name => true }

    ##
    # Organization unit, follows certificate.
    #
    add_param :org_unit, String

    ##
    # Organization name, follows certificate.
    #
    add_param :org_name, String

    ##
    # Country, follows certificate.
    #
    add_param :country, String

    ##
    # The Certificate name.
    #
    add_param :cn, String, { :delimiter => ' ' }

    ##
    # Key Type, follows certificate.
    #
    add_param :key_type, String, { :hidden_name => true }

    ##
    # PFX File
    #
    add_param :pfx_file, File, { :hidden_name => true, :file_task_name => true }

    ##
    # When creating a certificate, this is the file
    # where the password can be found.
    #
    add_param :password, String, { :delimiter => ' ' }

    ##
    # Expects Signing Options, plus
    # two files:
    #
    # 1) The Air file in
    # 2) The Air file out
    #
    add_param :migrate, Files

    ##
    # A list of files to include in the 
    #
    add_param :included_files, Files, { :hidden_name => true }

    ##
    # A list of paths (directories) to search
    # for contents that will be included in the
    # packaged AIR application.
    #
    # If files are hidden from the file system,
    # they will not be included.
    #
    add_param :included_paths, Paths, { :hidden_name => true }

    ##
    # The the Ruby file that will load the expected
    # Sprout::Specification.
    #
    # Default value is 'flex4'
    #
    set :pkg_name, 'flex4'

    ##
    # The default pkg version
    #
    set :pkg_version, ">= #{FlashSDK::VERSION}"
    
    ##
    # The default executable target.
    #
    set :executable, :adt

  end
end

def adt args, &block
  exe = FlashSDK::ADT.new
  exe.to_rake(args, &block)
  exe
end

# This should be removed when we fix
# the bug at: http://www.pivotaltracker.com/story/show/4194822
#
module Sprout::Executable
  DEFAULT_PREFIX          = '-'
end