-module(epicenter_test_edit).
-compile(export_all).
-include("epicenter.hrl").

main() ->
    epicenter_common:check_role(user).

title() -> "Test Edit".

header() ->
    epicenter_common:header(tests).

content() ->
    #panel {body=[
        #panel{class=row, body=#panel{class="column column-100", body=edit()}}
    ]}.

edit() ->
    Id = Path = wf:path_info(),

    TestName = "xxx",
    Date = "dddd",
    Type = "MQTT",
    NWorkers = "4",
    NControllers = "3",

    [
        #h1{text= wf:f("Edit test: ~s", [TestName])},

        #flash{},

        #label{for=testname, text = "Test name:"},
        #textbox{id = testname, text=TestName},
        #span{id = username_status},

        #label{for=date, text = "Date:"},
        #textbox{id = date, text=Date, readonly=true},
        #tablecell{body = #span{id = date_status}},

        #label{for=type, text = "Type:"},
        #textbox{id = type, text=Type, readonly=true},
        #span{id = type_status},

        #label{for=workers, text = "# workers:"},        
        #textbox{id = workers, text=NWorkers, readonly=true},
        #span{id = password_status},

        #label{for=controllers, text = "# controllers:"},
        #textbox{id = controllers, text=NControllers, readonly=true},
        #span{id = password_status},

        #button{id = submit, text = "Save", postback = {edit, Id, Path}}
    ].

event({edit, Id, Path}) ->
    [Name] = wf:mq([testname]),

    wf:info(Name).