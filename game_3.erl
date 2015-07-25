-module(game_3).
-compile(export_all).

contains(N) ->
	fun(M) ->
		P1 = M rem 10,
		P2 = M div 10 rem 10,
		P3 = M div 10 div 10 rem 10,
		P1 =:= N orelse P2 =:= N orelse P3 =:= N
	end.

mutil(N) ->
	fun(M) ->
		M rem N =:= 0
	end.

rule(Pred, Trans) ->
	fun(N) ->
		case Pred(N) of 
			true -> {true, Trans(N)};
			false -> false
		end
	end.

'or'([]) -> fun(_) -> false end;
'or'([H|T]) ->
	fun(M) ->
		case H(M) of
			{true, A} -> {true, A};
			false -> ('or'(T))(M)
		end
	end.

game_3() ->
	R3 = rule(contains(3), fun(_) -> "Fizz" end),
	Rd = rule(fun(_) -> true end, fun(N) -> N end),
	
	R13 = rule(mutil(3), fun(_) -> "Fizz" end),
	R5 = rule(mutil(5), fun(_) -> "Buzz" end),
	R7 = rule(mutil(7), fun(_) -> "Whizz" end),
	
	R1 = 'or'([R13, R5, R7]),
	
	R15 = rule(mutil(15), fun(_) -> "FizzWhizz" end),
	R21 = rule(mutil(21), fun(_) -> "FizzWhizz" end),
	R35 = rule(mutil(35), fun(_) -> "BuzzWhizz" end),
	R105 = rule(mutil(105), fun(_) -> "FizzBuzzWhizz" end),
	R2 = 'or'([R15, R21, R35, R105]),
	
	A = 'or'([R3, R2, R1, Rd]),
	[A(I)||I <- lists:seq(1, 100)].

