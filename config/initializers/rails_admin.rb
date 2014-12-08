RailsAdmin.config do |config|

  config.current_user_method(&:current_user)
  config.authenticate_with do
    if current_user
      unless current_user.admin?
        redirect_to main_app.root_url, :notice => "Naughty! You don't have access to that page."
      end
    else
      warden.authenticate! scope: :user
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

  config.model 'User' do
    list do
      field :avatar
      field :id
      field :first_name
      field :last_name
      field :email
      field :tip do
        label "Tips"
        formatted_value do
          bindings[:object].tips.count
        end
      end
      field :friendship do
        label "Friends"
        formatted_value do
          bindings[:object].friends.count
        end
      end
    end
  end

  config.model 'Tip' do
    parent User
    weight -3
    list do
      field :user
      field :title
      field :description
      field :recipient do
        label "Recipients"
        formatted_value do
          bindings[:object].recipients.count
        end
      end
      field :originator
    end
  end

  config.model 'Share' do
    parent User
    weight -2
    list do
      field :tip
      field :user do
        label "Recipient"
      end
      field :visited
      field :served
    end
  end

  config.model 'Friendship' do
    parent User
    weight -1
  end

  config.model 'Invite' do
    parent User
  end

  config.model 'Invitee' do
    parent User
    list do
      field :email
      field :invite do
        label "Invites"
        formatted_value do
          bindings[:object].invites.count
        end
      end
      field :created_at
      field :updated_at
    end
  end
end
