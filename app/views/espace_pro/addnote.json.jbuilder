json.form render(partial: "espace_pro/form_message", formats: :html,locals: {rdv: @rdv})
json.inserted_item render(partial: "espace_pro/messages_list", formats: :html, locals: {rdvs: @rdvs})
