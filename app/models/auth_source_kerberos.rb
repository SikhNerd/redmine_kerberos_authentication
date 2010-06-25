# redMine - project management software
# Copyright (C) 2006  Jean-Philippe Lang
# Copyright (C) 2010 Stephan Eckardt
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

require 'krb5_auth'

class AuthSourceKerberos < AuthSource 
  validates_length_of :attr_login, :attr_firstname, :attr_lastname, :attr_mail, :maximum => 30, :allow_nil => true
  
  def authenticate(login, password)
    return nil if login.blank? || password.blank?
    
    if authenticate_kerberos(login, password)
      logger.debug "Authentication successful for '#{login}'" if logger && logger.debug?

      attrs =
      {
      :firstname => "",
      :lastname => "",
      :mail => "",
      :auth_source_id => self.id,
      } if(onthefly_register?)

      attrs || nil
    end
  end

  def authenticate_kerberos(username, password)
    begin
      Krb5Auth::Krb5.new.get_init_creds_password(username, password)
    rescue Krb5Auth::Krb5::Exception => text
      raise "KerberosError: " + text
    end
  end

  # test the connection to the LDAP
  def test_connection
  end
 
  def auth_method_name
    "Kerberos"
  end
  
end
