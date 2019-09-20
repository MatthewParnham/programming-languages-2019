module Interpreter ( execCBN ) where

-------------------
-- AbsLambdaNat provides the interface with the grammar
-- and is automatically generated by bnfc
-------------------
import AbsLambdaNat -- defines "Program", "Exp", "EApp", "EAbs", etc
import ErrM
import PrintLambdaNat

import Data.Map ( Map )
import qualified Data.Map as M

-- execCBN is a function from type Program to type Exp, calling evalCBN
execCBN :: Program -> Exp  
-- Program and Exp are user defined data types (see AbsLambdaNat.hs)
-- "::" separates the name of a function from its type
-- in a C like language you would have sth like
--     Exp execCBN(Program p){if p == Prog e then return evalCBN(e)}
execCBN (Prog e) = evalCBN e

-- evalCBN is the actual interpreter ("eval" for evaluate, "CBN" for call by name)
evalCBN :: Exp -> Exp  
--the next case is the beta-reduction of lambda calculus
evalCBN (EApp e1 e2) = case (evalCBN e1) of
    (EAbs i e3) -> evalCBN (subst i e2 e3)
    e3 -> EApp e3 e2
----------------------------------------------------
--- here goes your code for extending the interpreter
----------------------------------------------------
evalCBN x = x -- this is a catch all clause, currently only for variables

-- fresh generates fresh names for substitutions, can be ignored for now
-- A quick and dirty way of getting fresh names. Rather inefficient for big terms...
fresh_aux :: Exp -> String
fresh_aux (EVar (Id i)) = i ++ "0"
fresh_aux (EApp e1 e2) = fresh_ e1 ++ fresh_ e2
fresh_aux (EAbs (Id i) e) = i ++ fresh_ e
--fresh_aux _ = "0"

fresh = Id . fresh_aux -- for Id see AbsLamdaNat.hs

subst :: Id -> Exp -> Exp -> Exp
subst id s (EVar id1) | id == id1 = s
                      | otherwise = EVar id1
subst id s (EApp e1 e2) = EApp (subst id s e1) (subst id s e2)
subst id s (EAbs id1 e1) = 
    -- to avoid variable capture, we first substitute id1 with a fresh name inside the body
    -- of the λ-abstraction, obtaining e2. 
    -- Only then do we proceed to apply substitution of the original s for id in the 
    -- body e2.
    let f = fresh (EAbs id1 e1)
        e2 = subst id1 (EVar f) e1 in 
        EAbs f (subst id s e2)
----------------------------------------------------------------
--- here goes your code as subst may need to be extended as well
----------------------------------------------------------------

