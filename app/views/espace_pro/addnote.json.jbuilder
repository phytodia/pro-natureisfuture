json.form render(partial: "espace_pro/form_message", formats: :html,locals: {rdv: @rdv})
json.inserted_item render(partial: "espace_pro/message_list_item", formats: :html, locals: {rdv: @rdv})
