module ApplicationHelper
  # render breadcrumbs
  # always print 'Home'
  #
  # argument example:
  #   breadcrumb({ text: 'Home', href: root_path }, { text: 'Home', href: root_path })
  def breadcrumb(*links)
    render 'layouts/breadcrumb', links: [{ text: 'Home', href: root_path }] + links
  end

  # returns logged in employee id
  def current_employee_id
    session[:current_employee_id]
  end

  # this is almost same as `current_employee` but this returns Boolean
  # it is created to grow up code's readability
  def logged_in?
    !session[:current_employee_id].nil?
  end

  # which is better; Log#render_log (define as instance method)
  #                  define as View Helper(this case)
  def render_log(log)
    log.content.sub('__', link_to("オーダー#{log.order_id}", order_inspections_path(log.order_id))).html_safe
  end
end
