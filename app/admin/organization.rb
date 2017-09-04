ActiveAdmin.register Organization do
  permit_params :name, :color, :logo

  controller do
    def find_resource
      scoped_collection.friendly.where(slug: params[:id]).first!
    end
  end
end
