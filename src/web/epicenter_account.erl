-module(epicenter_account).
-compile(export_all).
-include("epicenter.hrl").

main() ->
    epicenter_common:check_role(user).

title() -> "About".

header() ->
    epicenter_common:header(acount).

content() ->
    #panel {body=[
        #panel{class=row, body=#panel{class="column column-100", body=acount()}}
    ]}.

acount() ->
    [            
        #h2{text="Acount"},
        #p{body="aaaaa"}
    ].