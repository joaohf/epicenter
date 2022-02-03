%%%-------------------------------------------------------------------
%% @doc epicenter public API
%% @end
%%%-------------------------------------------------------------------

-module(epicenter_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    epicenter_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
