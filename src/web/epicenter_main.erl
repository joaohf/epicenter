-module(epicenter_main).
-compile(export_all).
-include("epicenter.hrl").

main() ->
    epicenter_common:check_role(user).

title() -> "Main".

header() ->
    epicenter_common:header(main).

content() ->
    #panel {body=[
        #panel{class=row, body=#panel{class="column column-100", body=p1()}}
    ]}.

p1() ->
    #p{body="Epicenter tsung"}.
