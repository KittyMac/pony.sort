use "ponytest"


actor Main is TestList
	new create(env: Env) => PonyTest(env, this)
	new make() => None

	fun tag tests(test: PonyTest) =>
	test(_Test1)
		
	
 	fun @runtime_override_defaults(rto: RuntimeOptions) =>
		rto.ponyanalysis = 1
		rto.ponynoblock = true
		rto.ponygcinitial = 0
		rto.ponygcfactor = 1.0


class iso _Test1 is UnitTest
	fun name(): String => "test argsort"
    
	fun apply(h: TestHelper) =>
      let a:Array[U32] =    [  6;   5;   4;   3;   2;   1;   0  ]
      let b:Array[String] = [ "g"; "f"; "e"; "d"; "c"; "b"; "a" ]
      
      ArgSort[Array[U32], U32, Array[String], String](a, b)
      
      let a_sorted = ",".join(a.values())
      let b_sorted = ",".join(b.values())
    
      h.complete( (a_sorted == "0,1,2,3,4,5,6") and (b_sorted == "a,b,c,d,e,f,g") )

