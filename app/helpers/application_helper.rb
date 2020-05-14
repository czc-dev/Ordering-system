module ApplicationHelper
  # パンくずリストを表示します
  # 'Home' は常に表示されます
  #
  # usage:
  #   breadcrumb({ text: 'Home', href: root_path }, { text: 'Home', href: root_path })
  def breadcrumb(*links)
    render 'layouts/breadcrumb', links: [{ text: 'トップ', href: root_path }] + links
  end
end
