grammar Euporia;

start : (note+|headLine) EOF;
note : headLine ref item+ rem? eol;
headLine : HEAD_LINE;
eol : NEWLINE;
ref : wordRefRanges (EQ wordRefRanges)? COLON;
numRef : NUM (DOT NUM (DOT NUM)?)?;

wordRefRanges : wordRefRange (TILDE wordRefRange)*;
wordRefRange : (firstWordRef midWordRef* lastWordRef)|singleWordRef;
firstWordRef : (SEP|COLON)? numRef? anchor? wordRef;
midWordRef : (SEP|COLON)? numRef? wordRef;
lastWordRef : (SEP|COLON)? numRef? wordRef anchor?;
singleWordRef : (SEP|COLON)? numRef? anchor? wordRef anchor?;
anchor : L_BRAC wordRef+ R_BRAC;
wordRef : (PRE_PUNCT|L_CURL)? (WORD) (PUNCT|R_CURL|NOT|DOT|SEMICOLON|COMMA|COLON)? EXT_PUNCT?;

item : sentence+;
token : (((PRE_PUNCT|L_CURL)? (WORD|NUM) (PUNCT|R_CURL|NOT|DOT|SEMICOLON|COMMA|COLON)? EXT_PUNCT?)|(SEP|COLON));
rem : REM_BEG token*;

sentence : ((subject|subjects) (predicate|predicates) (object|objects) target? | (subject|subjects) (predicateGroup) (SEMICOLON predicateGroup)+) DOT;

subject : (role? value|value role);
subjects : subject (COMMA subject)+;
predicate : value;
predicates : predicate (COMMA predicate)+;
predicateGroup : (predicate|predicates) (object|objects) (PREP (target|targets))?;
object : ((role?|polarity) value|value role);
objects : object (COMMA object)+;
target : PREP (role? value|value role);
targets : target (COMMA value)+;
value : WORD|HASHTAG;
polarity: POLARITY;
role: (HASHTAG|AS value);

AS: 'as';
POLARITY: 'positive'|'negative'|'neutral'|'#pos'|'#neg'|'#neu'|'#very_neg'|'#quite_neg'|'#quite_pos'|'#very_pos';
COMMA : ','|'and';
PREP : 'for'|'to'|'towards';
REM_BEG : '//';
HEAD_LINE : '*';
NUM : [0-9]+;
SEP : '...'|'…'|'/';
COLON : ':';
DASH : '-';
EQ : '=';
HASHTAG : '#'('A'..'Z'|'a'..'z'|'_')+;
WORD : (LAT_WORD (UNDERSCORE (LAT_WORD|GRC_WORD))*|GRC_WORD (UNDERSCORE (GRC_WORD|LAT_WORD))*);
LAT_WORD : ('a'..'z'|'A'..'Z'|'á'|'à'|'ä'|'é'|'è'|'ë'|'í'|'ì'|'ï'|'ó'|'ò'|'ö'|'ú'|'ù'|'ü'|'ƀ'|'ð'|'’'|DASH)+;
GRC_WORD : ('\u0370'..'\u0386'|'\u0388'..'\u03ff'|'\u1f00'..'\u1fff'|'\u2019'|'\u2080'..'\u2089'|'·'|'·'|DASH|'&'('a'..'z')+';')+;
NEWLINE : ('\n'|'\r'|'\r\n')+;
UNDERSCORE : '_';
TILDE : '~';
L_BRAC : '[';
R_BRAC : ']';
L_CURL : '{';
R_CURL : '}';
NOT : '!';
PRE_PUNCT : '“'|'('|'<'|'‘'|'≺';
PUNCT : '?'|'-'|'’'|'”'|')'|'≻';
SEMICOLON : ';';
DOT : '.';
WS : (' '|'\t')->skip;
EXT_PUNCT : '>'|'"'|'='|' ';
ANY : .+?;
