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

class Screenshot < ActiveRecord::Base
  # Relationships  
  belongs_to :application

  # Validations
  validates_presence_of :application_id
  validates_associated :application
  
  validates_presence_of :name
  
  has_attached_file :image, :styles => { :thumb => "120x96#", :normal => "800x600>" },
                    :default_style => :normal,
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension"

  validates_attachment_presence :image
                   
end
