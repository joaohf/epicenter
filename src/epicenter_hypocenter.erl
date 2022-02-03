-module(epicenter_hypocenter).

-export([start_node/1,
         stop_node/1,
         status_node/1,
         start_test/2,
         stop_test/2]).

-include_lib("kernel/include/logger.hrl").

%%
%% Slave nodes
%%

-define(NODE_NAME, "hypocenter").


%% @doc Starts a slave hypocenter node. Hypocenter nodes
%%      are responsible to execute test tools and reports
%%      their results. This function will start a hypocenter
%%      application.
start_node(Host) ->
    %Erl = "-A 8 -K true -P 250000 -smp auto -rsh ssh -proto_dist inet_tcp  -setcookie tsung -kernel inet_dist_listen_min 64000 -kernel inet_dist_listen_max 65500 ",
    Path = get_hypocenter_libs(),
    Args = Path,
    case slave:start(Host, "?NODE_NAME", Args) of
        {error, Reason} = E ->
            ?LOG_ERROR("can not start a slave node on ~p: ~p", [Host, Reason]),
            E;
        {ok, _Node} = Reply ->
            Reply
    end.


%% @doc Stop an already started node. All activily tests will be
%%      stoped.
stop_node(Node) ->
    slave:stop(Node).


%% @doc Get status from a specific Node.
status_node(Node) ->
    ok.


%%
%% Hypocenter RPC
%%


%% @doc Create and starts a test on `Node' using `Config' as parameters. 
start_test(Node, Config) ->
    case rpc:call(Node, hypocenter, start_test, [Config], 30000) of
        {badrpc, Reason} ->
            ?LOG_ERROR("badrpc when starting test on node ~p", [Node, Reason]),
            {error, Reason};
        {ok, _Pid} = Reply ->
            Reply
    end.


%% @doc Stop a started test `Pid' on `Node'.
stop_test(Node, Pid) ->
    case rpc:call(Node, hypocenter, stop_test, [Pid], 30000) of
        {badrpc, Reason} ->
            ?LOG_ERROR("badrpc when stopping test on node ~p", [Node, Reason]),
            {error, Reason};
        ok ->
            ok
    end.


get_hypocenter_libs() ->
    P1 = "",
    lists:flatten(["-pa ", P1, " "]).
