class TwoBecomingOne::Setting < TwoBecomingOne::Base
  validates :var, presence: true, uniqueness: {case_sensitive: false}
  validates :type, presence: true
  validates :category, presence: true
  validate :validate_attrs

  with_options on: :update do |o|
    o.validates :file, presence: true, if: :file_type
    o.validate :validate_file_type
  end

  mount_uploader :file, FileUploader

  def typed_value
    case type
    when 'file'
      file
    when 'boolean'
      ['true','1'].include?(value.downcase)
    else
      value
    end
  end

  def self.fetch_all
    h = {}

    self.all.group_by{|x| x.category.downcase.underscore}.each do |category, group|
      ch = {}

      group.each do |setting|
        ch[setting.var] = setting.typed_value
      end

      unless ch.empty?
        h[category] = Struct.from_h(ch)
      end
    end

    return Struct.from_h(h)
  end

  private

  def validate_file_type
    if file_type && file_type != "file"
      if !FileUploader.validate_file_type(type: file_type, filename: file.name)
        errors.add(:file, "only #{file_type} files allowed")
      end
    end
  end

  def validate_attrs
    if value
      case var
      when "site_seo_description"
        if value && value.length > 160
          errors.add(:value, "SEO description max length is 160 characters")
        end
      end
    end
  end


end
