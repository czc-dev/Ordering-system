module ApplicationHelper
  # render breadcrumbs
  # always print 'Home'
  #
  # argument example:
  #   breadcrumb({ text: 'Home', href: root_path }, { text: 'Home', href: root_path })
  def breadcrumb(*links)
    render 'layouts/breadcrumb', links: [{ text: 'Home', href: root_path }] + links
  end
end
