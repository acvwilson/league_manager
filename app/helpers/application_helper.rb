module ApplicationHelper
  def current_class?(controller)
    'current' if params[:controller] =~ /#{controller}/
  end
end
