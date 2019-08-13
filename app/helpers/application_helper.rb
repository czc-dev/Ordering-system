module ApplicationHelper
  # パンくずリストを表示します
  # 'Home' は常に表示されます
  #
  # usage:
  #   breadcrumb({ text: 'Home', href: root_path }, { text: 'Home', href: root_path })
  def breadcrumb(*links)
    render 'layouts/breadcrumb', links: [{ text: 'トップ', href: root_path }] + links
  end

  # 現在の従業員(インスタンス)を返します
  def current_employee
    @current_employee ||= Employee.find_by(id: session[:current_employee_id])
  end

  # 上述した `current_employee` とほぼ同様の意味を成しますが、これは **真偽値** を返します
  # コードの可読性のために使い分けてください
  def logged_in?
    !session[:current_employee_id].nil?
  end
end
