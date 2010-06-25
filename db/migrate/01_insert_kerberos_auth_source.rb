class InsertKerberosAuthSource < ActiveRecord::Migration
  def self.up
    kerberos = AuthSourceKerberos.new(:name => "System Kerberos", :onthefly_register => true, :tls => false)
    kerberos.save
  end

  def self.down
    AuthSourceKerberos.destroy_all
  end
end

