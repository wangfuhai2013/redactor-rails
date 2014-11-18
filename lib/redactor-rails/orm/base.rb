module RedactorRails
  module Orm
    module Base
      module AssetBase
        module InstanceMethods
          def has_dimensions?
            respond_to?(:width) && respond_to?(:height)
          end

          def image?
            RedactorRails::IMAGE_TYPES.include?(data_content_type)
          end

          def image
            url
          end

          def thumb
            ret = ""
            ret = url(:thumb) if self.image?            
            ret
          end

          def link
            url
          end

          def name
            ''
          end

          def title
            data_file_name
          end  

          def size
            ret = data_file_size.to_s + "B" 
            ret = (data_file_size / 1024).to_s + "KB" if  data_file_size >= 1024
            ret = (data_file_size / (1024*1024)).to_s + "MB" if data_file_size >= 1024*1024
            logger.debug("size:" + ret)
            ret
          end

          def as_json_methods
            [:image,:thumb,:link,:name,:size,:title]
          end

          def as_json(options = nil)
            options = {
              :methods => as_json_methods,
              :root => false
            }

            super options
          end
        end
      end
    end
  end
end
