#
#    ====================================================================
#    This file is part of LibreCMS.
#
#    Foobar is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    any later version.
#
#    Foobar is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
#    ====================================================================
#

require 'paperclip'

class Installer < ActiveRecord::Base
  # Relationships
  belongs_to :application
  
  # Validations
  acts_as_taggable_on :platforms, :languages, :licenses
  
  validates_presence_of :application_id
  validates_associated :application
  
  has_attached_file :installer,
                    :url => "/attached/:class/:id/:attachment/:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:basename.:extension"
                    
  validates_attachment_presence :installer

  def name
    application.name + ' ' + version
  end

end
