RailsAdmin.config do |config|

  config.current_user_method(&:current_user)
  config.authenticate_with do
    unless current_user.try(:admin?)
      redirect_to main_app.root_url, :notice => "Naughty! You don't have access to that page."
    end
  end

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
