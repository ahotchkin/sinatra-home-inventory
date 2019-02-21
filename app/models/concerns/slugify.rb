module Slugify

  module ClassMethods
    def find_by_slug(slug)
      self.find { |name| name.slug + name.id.to_s == slug + name.id.to_s }
    end
  end

  module InstanceMethods
    def slug
      self.name.gsub(/\s/, "-").gsub(/[^0-9A-Za-z\-]/, '').downcase + self.id.to_s
    end
  end

end
