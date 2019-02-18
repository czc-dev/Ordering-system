module ApplicationHelper
  # render breadcrumbs
  # always print 'Home'
  #
  # argument example:
  #   breadcrumb({ text: 'Home', href: root_path }, { text: 'Home', href: root_path })
  def breadcrumb(*links)
    render 'layouts/breadcrumb', links: [{ text: 'トップ', href: root_path }] + links
  end

  # returns logged in employee
  def current_employee
    @current_employee ||= Employee.find_by(id: session[:current_employee_id])
  end

  # this is almost same as `current_employee` but this returns Boolean
  # it is created to grow up code's readability
  def logged_in?
    !session[:current_employee_id].nil?
  end
end
