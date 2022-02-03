-module(epicenter_tests).
-compile(export_all).
-include("epicenter.hrl").

main() ->
    epicenter_common:check_role(user).

title() -> "Tests".

header() ->
    epicenter_common:header(tests).

content() ->
    #panel {body=[
        #panel{class=row, body=#panel{class="column column-100", body=tests()}}
    ]}.

tests() ->
    RowId = wf:temp_id(),

    [
        %epicenter_common:notification(),
        #panel{class="table-container", body=[
        #table { rows=[
            #tablerow { cells=[
                #tableheader { text="Name" },
                #tableheader { text="Date" },
                #tableheader { text="Type" },
                #tableheader { text="# workers" },
                #tableheader { text="# controllers" },
                #tableheader { text="Action" }
            ]},
            #tablerow { id=RowId, cells=[
                #tablecell { text="Simple htmlssssssssss", align=left },
                #tablecell { text="2020/03/31" },
                #tablecell { text="HTTP" },
                #tablecell { text="5" },
                #tablecell { text="1" },
                #tablecell { body=action(RowId) }

            ]}
        ]}]}
    ].

action(RowId) -> #epicenter_hoverable_dropdown{rowId=RowId}.

event({delete, _Id, RowId} = EventInfo) ->
    Msg = wf:f("Postback received with value: ~p", [EventInfo]),
    wf:remove(RowId),
    wf:info(Msg).