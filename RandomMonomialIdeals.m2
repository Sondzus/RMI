--**************************--
-- -*- coding: utf-8 -*-
newPackage(
	"RandomMonomialIdeals",
    	Version => "1.0", 
    	Date => "May 5, 2017",
    	Authors => {
	    {
		Name => "Sonja Petrovic", 
		Email => "sonja.petrovic@iit.edu", 
		HomePage => "http://math.iit.edu/~spetrov1/"
	    },
	    {
		Name => "Despina Stasi", 
		Email => "stasdes@iit.edu", 
		HomePage => "http://math.iit.edu/~stasdes/"
	    },	
	    {
		Name => "Dane Wilburne", 
		Email => "dwilburn@hawk.iit.edu", 
		HomePage => "http://mypages.iit.edu/~dwilburn/"
	    },	
	    {
		Name => "Tanner Zielinski", 
		Email => "tzielin1@hawk.iit.edu", 
		HomePage => "https://www.linkedin.com/in/tannerzielinski/"
	    },	
	    {
		Name => "Daniel Kosmas", 
		Email => "dkosmas@hawk.iit.edu", 
		HomePage => "https://www.linkedin.com/in/daniel-kosmas-03160988/"
	    },
	    {
		Name => "Parker Joncus", 
		Email => "pjoncus@hawk.iit.edu", 
		HomePage => ""
	    },
	    {
		Name => "Richard Osborn", 
		Email => "rosborn@hawk.iit.edu", 
		HomePage => ""
	    },
	    {
	    	Name => "Monica Yun", 
	    	Email => "myun1@hawk.iit.edu", 
	    	HomePage => ""
	    },
	    {
	    	Name => "Genevieve Hummel", 
	    	Email => "ghummel1@hawk.iit.edu", 
	    	HomePage => ""
	    }
          -- {Name=> "Contributing authors and collaborators: add any acknowledgements here", 
	  -- Email=> "",
	  -- HomePage=>""}      
	},
    	Headline => "A package for generating Erdos-Renyi-type random monomial ideals",
    	DebuggingMode => false,
	Reload => true 
    	)

export {
    "firstFunction",
    "randomGeneratingSets"
    }

--***************************************--
--  Function provided by FirstPackage.m2 --
--***************************************--

firstFunction = method(TypicalValue => String)
firstFunction ZZ := String => n -> if n == 1 then "Hello World!" else "D'oh!"

--****************************************************************--
--  Methods written by D.Wilburne and S.Petrovic for RMI, 2016-17 --
--****************************************************************--


--**********************************--
--  Methods that need documentation --
--**********************************--
randomGeneratingSets = method(TypicalValue => List)
randomGeneratingSets (ZZ,ZZ,RR,ZZ) := List =>  (n,D,p,N) -> (
    x :=symbol x;
    R := QQ[x_1..x_n];
    -- graded model
    allMonomials := flatten flatten apply(toList(1..D),d->entries basis(d,R));
    -- this generates a list of all possible monomials of degree <= D in n variables
    -- go through list allMonomials, and for each monomial m in the list, select a number in Unif(0,1);
    -- if that number <= p, then include the monomial m in a generating set B
    -- since iid~Unif(0,1), this is same as keeping each possible monomial w/ probability p.
    -- we need a sample of size N of sets of monomials like these, so we repeat this process N times:
    B := apply(N,i-> select(allMonomials, m-> random(0.0,1.0)<=p) )
    --the result:
    -- B = list of random monomial ideal generating sets.
)

--**********************************--
--  Methods that need reformatting  --
--**********************************--

-- TO BE ADDED BY S.P. 


--******************************************--
-- DOCUMENTATION     	       	    	    -- 
--******************************************--
beginDocumentation()

doc ///
 Key
  RandomMonomialIdeals
 Headline
  A package for generating Erdos-Renyi-type random monomial ideals
 Description
  Text
   {\em RandomMonomialIdeals} is a  package that... 
  -- Caveat
  -- Still trying to figure this out. [REMOVE ME]
///

doc ///
 Key
  firstFunction
  (firstFunction,ZZ)
 Headline
  a silly first function
 Usage
  firstFunction n
 Inputs
  n:ZZ
 Outputs
  :String
   a silly string, depending on the value of {\tt n}
 Description
  Text
   Here we show an example.
  Example
   firstFunction 1
   firstFunction 0
///

doc ///
 Key
  randomGeneratingSets
  (randomGeneratingSets,ZZ,ZZ,RR,ZZ)
 Headline
  randomly generates lists of monomials, up to a given dimension
 Usage
  randomGeneratingSets (ZZ,ZZ,RR,ZZ)
 Inputs
  n: ZZ
  D: ZZ
  p: RR
  N: ZZ
 Outputs
  B: List
   a list of generating sets of monomials
 Description
  Text
   given number of variables n, degree bound D, and probability parameter p, N generating sets of monomials are randomly generated
  Example
   B=randomGeneratingSets(2,3,0.2,10)
   randomGeneratingSets(3,4,1.0,1)
   randomGeneratingSets(5,2,0.6,4)
 SeeAlso
  firstFunction
///



--******************************************--
-- TESTS     	     	       	    	    -- 
--******************************************--

--************************--
--  randomGeneratingSets  --
--************************--

TEST ///
    -- Check there are N samples
    N=10;
    assert (N==#randomGeneratingSets(3,2,0.5,N))
///

TEST ///
    -- Check no terms are chosen for a probability of 0
    assert (0==#(randomGeneratingSets(5,5,0.0,1))#0)
///

TEST ///
    -- Check all possible values are outputted with a probability of 1
    D=3;
    n=4;
    assert (product(toList((D+1)..D+n))/n!-1==#(randomGeneratingSets(n,D,1.0,1))#0)
    D=2;
    n=6;
    assert (product(toList((D+1)..D+n))/n!-1==#(randomGeneratingSets(n,D,1.0,1))#0)
///

TEST ///
    -- Check every monomial is generated
    L=(randomGeneratingSets(2,3,1.0,1))#0
    R=ring(L#0)
    assert(set L===set {R_0,R_1,R_0^2,R_0*R_1,R_1^2,R_0^3,R_0^2*R_1,R_0*R_1^2,R_1^3})
///

TEST ///
    -- Check max degree of monomial less than or equal to D
    n=10;
    D=5;
    assert(D==max(apply((randomGeneratingSets(n,D,1.0,1))#0,m->first degree m)))
    n=4;
    D=7;
    assert(D==max(apply((randomGeneratingSets(n,D,1.0,1))#0,m->first degree m)))
///

TEST ///
    -- Check min degree of monomial greater than or equal to 1
    n=8;
    D=6;
    assert(1==min(apply((randomGeneratingSets(n,D,1.0,1))#0,m->first degree m)))
    n=3;
    D=5;
    assert(1==min(apply((randomGeneratingSets(n,D,1.0,1))#0,m->first degree m)))
///

end

You can write anything you want down here.  I like to keep examples
as I’m developing here.  Clean it up before submitting for
publication.  If you don't want to do that, you can omit the "end"
above.
