module ActiveItemHelper
  def active_class(page_name)
    "active" if (@page_title.present? && @page_title == page_name)
  end
end
