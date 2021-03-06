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

class Application < ActiveRecord::Base
  # Relationships
  has_many :resources, :dependent => :destroy
  has_many :screenshots, :dependent => :destroy
  has_many :installers, :dependent => :destroy
  
  acts_as_taggable_on :tags
  acts_as_rateable
  
  # Validations
  validates_presence_of :name
  validates_uniqueness_of :name, :case_sensitive => false, :message => 'Ya existe'
  
  has_attached_file :logo, :styles => { :normal => "63x63", :small => "32x32", :big => "128x128" },
                    :url => "/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :path => ":rails_root/public/attached/:class/:id/:attachment/:style_:basename.:extension",
                    :default_style => :normal,
                    :default_url => "/images/defaults/:class_:attachment_:style.png"
                    
  validates_attachment_content_type :logo, :content_type => ['image/jpeg', 'image/pjpeg', 'image/gif', 'image/png', 'image/x-png', 'image/jpg']

  def self.find_with_like_by_name(name)
    find(:first, :conditions => ["name LIKE ?", name])
  end

  def to_param
    unless name.nil?
      app_url = String.new(name)
      "#{app_url.to_url}"
    end
  end

end
