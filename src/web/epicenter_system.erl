-module(epicenter_system).
-compile(export_all).
-include("epicenter.hrl").

main() ->
    epicenter_common:check_role(user).

title() -> "About".

header() ->
    epicenter_common:header(system).

content() ->
    #panel {body=[
        #panel{class=row, body=#panel{class="column column-100", body=about()}}
    ]}.

about() ->
    [            
        #h2{text="System Overview"},
        #p{body="aaaaa"}
    ].