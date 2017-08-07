-module(ex_parser_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).

start_link() ->
  supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% TODO: Rename example_parse to ex_parser

parser() -> #{
  id => ex_parser,
  start => {example_parse, start_link, []},
  restart => temporary,
  shutdown => 3000,
  type => worker,
  modules => [example_parse]
}.

init([]) ->
  {ok, {{simple_one_for_one, 1, 1}, [parser()]}}.
