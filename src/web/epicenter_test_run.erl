-module(epicenter_test_run).
-compile(export_all).
-include("epicenter.hrl").

main() ->
    epicenter_common:check_role(user).

title() -> "Test Run".

header() ->
    epicenter_common:header(tests).

content() ->
    #panel {body=[
        #panel{class=row, body=#panel{class="column column-100", body=run()}}
    ]}.

run() ->
    Id = Path = wf:path_info(),

    TestName = "xxx",
    Type = "MQTT",
    NWorkers = "4",
    NControllers = "3",

    #panel { class=content, body=[
        #h1{text=wf:f("Run test: ~s", [TestName])},

        #label{for=testname, text = "Test name:"},
        #textbox{id = testname, text=TestName, readonly=true},

        #label{for=teyp, text = "Type:"},
        #textbox{id = type, text=Type, readonly=true},

        #label{for=workers, text = "# workers:"},                
        #textbox{id = workers, text=NWorkers, readonly=true},

        #label{for=controllers, text = "# controllers:"},
        #textbox{id = controllers, text=NControllers, readonly=true},

        #button{id = submit, body = #i{class="ri-play-fill", text="Run"}, postback = {run, Id, Path}},
        
        #flash{},

        #panel { body=["aaaaa"]}     
    ]}.

event({run, Id, Path}) ->
    Elements = #button{id = submit,
                       body = #i{class="ri-stop-fill", text="Stop"},
                       postback = {run, Id, Path}},

    wf:replace(submit, Elements),

    wf:info("xxxxx").