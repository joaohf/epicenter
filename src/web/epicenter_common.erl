-module(epicenter_common).
-compile(export_all).
-include("epicenter.hrl").

header(Selected) ->
    wf:wire(Selected, #add_class { class=selected }),
    User = wf:user(),
    Body = case User of
        undefined ->
            #panel { class=menu, body=[
                #link{text = "Login", url = "/epicenter/login"},
                #link{text = "Register", url = "/epicenter/register"}
            ]};
        _ ->
            #panel { class=menu, body=[
                #link{ id=main, url = "/epicenter/main", text = "Main"},
                #link{ id=tests, url="/epicenter/tests", text="Tests" },
                #link{ id=system, url = "/epicenter/system", text = "System"},
                #link{ id=account, url = "/epicenter/account", text = "Account"},
                #link{ id=logout, url = "/epicenter/logout", text = "Logout"}
            ]}
    end,

    #panel{class="float-right", body=Body}.

check_role(Role) ->
    case wf:role(Role) of
        true ->
            #template{file = code:priv_dir(epicenter) ++ "/templates/base.html"};
        false ->
            wf:redirect_to_login("/epicenter/login")
    end.