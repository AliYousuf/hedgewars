module Pas2C where

import PascalParser
import Text.PrettyPrint.HughesPJ
import Data.Maybe
import Data.Char


pascal2C :: PascalUnit -> Doc
pascal2C (Unit unitName interface implementation init fin) = implementation2C implementation


implementation2C :: Implementation -> Doc
implementation2C (Implementation uses tvars) = typesAndVars2C tvars


typesAndVars2C :: TypesAndVars -> Doc
typesAndVars2C (TypesAndVars ts) = vcat $ map tvar2C ts


tvar2C :: TypeVarDeclaration -> Doc
tvar2C (FunctionDeclaration (Identifier name) (Identifier returnType) Nothing) = 
    text $ maybeVoid returnType ++ " " ++ name ++ "();"

    
tvar2C (FunctionDeclaration (Identifier name) (Identifier returnType) (Just phrase)) = 
    text (maybeVoid returnType ++ " " ++ name ++ "()") 
    $$
    phrase2C phrase
tvar2C _ = empty


phrase2C :: Phrase -> Doc
phrase2C (Phrases p) = braces . nest 4 . vcat . map phrase2C $ p
phrase2C (ProcCall (Identifier name) params) = text name <> parens (hsep . punctuate (char ',') . map expr2C $ params) <> semi
phrase2C (IfThenElse (expr) phrase1 mphrase2) = text "if" <> parens (expr2C expr) $$ (braces . nest 4 . phrase2C) phrase1 $+$ elsePart
    where
    elsePart | isNothing mphrase2 = empty
             | otherwise = text "else" $$ (braces . nest 4 . phrase2C) (fromJust mphrase2)
phrase2C (Assignment ref expr) = ref2C ref <> text " = " <> expr2C expr <> semi
phrase2C (WhileCycle expr phrase) = text "while" <> parens (expr2C expr) $$ nest 4 (phrase2C phrase)
phrase2C (SwitchCase expr cases mphrase) = text "switch" <> parens (expr2C expr) <> text "of" $$ (nest 4 . vcat . map case2C) cases
    where
    case2C :: (Expression, Phrase) -> Doc
    case2C (e, p) = text "case" <+> parens (expr2C e) <> char ':' <> nest 4 (phrase2C p $$ text "break;")
{-
        | RepeatCycle Expression Phrase
        | ForCycle
        | SwitchCase Expression [(Expression, Phrase)] (Maybe Phrase)
        | Assignment Identifier Expression
        -}
phrase2C _ = empty

ref2C :: Reference -> Doc
ref2C (ArrayElement (Identifier name) expr) = text name <> brackets (expr2C expr)
ref2C (SimpleReference (Identifier name)) = text name
ref2C (RecordField ref1 ref2) = ref2C ref1 <> text "." <> ref2C ref2
ref2C (Dereference ref) = parens $ text "*" <> ref2C ref

expr2C :: Expression -> Doc
expr2C (Expression s) = text s
expr2C (FunCall ref params) = ref2C ref <> parens (hsep . punctuate (char ',') . map expr2C $ params)
expr2C (BinOp op expr1 expr2) = (expr2C expr1) <+> op2C op <+> (expr2C expr2)
expr2C (NumberLiteral s) = text s
expr2C (HexNumber s) = text "0x" <> (text . map toLower $ s)
expr2C (StringLiteral s) = doubleQuotes $ text s 
expr2C (Address ref) = text "&" <> ref2C ref
expr2C (Reference ref) = ref2C ref

{-    
    | PrefixOp String Expression
    | PostfixOp String Expression
    | CharCode String
    -}            
expr2C _ = empty

op2C "or" = text "|"
op2C "and" = text "&"
op2C "div" = text "/"
op2C "mod" = text "%"
op2C "<>" = text "!="
op2C "=" = text "=="
op2C a = text a

maybeVoid "" = "void"
maybeVoid a = a
